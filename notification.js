const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.scheduleTaskNotifications = functions.firestore
  .document('users/{userId}/tasks/{taskId}')
  .onCreate((snap, context) => {
    const task = snap.data();
    const taskId = context.params.taskId;
    const userId = context.params.userId;

    console.log(`Task created: ${taskId}, for user: ${userId}`);

    if (task.dueDate) {
      const dueDate = task.dueDate.toDate();

      const notificationTime = dueDate.getTime() - 15 * 60 * 1000;

      const now = Date.now();

      if (notificationTime > now) {
        return admin.firestore().collection('notifications').add({
          userId: userId,
          taskId: taskId,
          title: 'Task Reminder',
          body: `Your task "${task.title}" is due soon!`,
          scheduledTime: admin.firestore.Timestamp.fromMillis(notificationTime),
          sent: false
        });
      } else {
        console.log('Notification time is in the past. Skipping notification.');
        return null;
      }
    } else {
      console.log('Due date is not properly set.');
      return null;
    }
  });

exports.sendScheduledNotifications = functions.pubsub.schedule('every 24 hours').onRun(async (context) => {
  const now = admin.firestore.Timestamp.now();
  console.log('Running scheduled notification check at', now.toDate());

  const notificationsSnapshot = await admin.firestore()
    .collection('notifications')
    .where('sent', '==', false)
    .where('scheduledTime', '<=', now)
    .get();

  const notifications = [];
  notificationsSnapshot.forEach(doc => {
    notifications.push({ id: doc.id, ...doc.data() });
  });

  console.log(`Found ${notifications.length} notifications to send.`);

  const sendPromises = notifications.map(notification => {
    return admin.firestore().collection('users').doc(notification.userId).get()
      .then(userDoc => {
        const user = userDoc.data();
        if (user && user.token) {
          const message = {
            notification: {
              title: notification.title,
              body: notification.body
            },
            token: user.token
          };
          return admin.messaging().send(message);
        } else {
          console.log(`User ${notification.userId} does not have a valid token.`);
          return null;
        }
      })
      .then(() => {
        return admin.firestore().collection('notifications').doc(notification.id).update({ sent: true });
      })
      .catch(error => {
        console.error(`Error sending notification to ${notification.userId}:`, error);
        return null;
      });
  });

  return Promise.all(sendPromises);
});
