import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'add_task.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late Stream<QuerySnapshot> _taskStream;

  @override
  void initState() {
    super.initState();
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _taskStream = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('tasks')
          .snapshots();
    }
  }

  List<DocumentSnapshot>
  categorizeTasks(List<DocumentSnapshot> tasks, String category) {
    DateTime now = DateTime.now();
    List<DocumentSnapshot> todayTasks = [];
    List<DocumentSnapshot> futureTasks = [];
    List<DocumentSnapshot> completedTasks = [];

    for (var task in tasks) {
      DateTime taskDate = DateTime.parse(task['date']);
      bool isCompleted = task['isCompleted'];

      if (isCompleted) {
        completedTasks.add(task);
      } else if (taskDate.isBefore(now) || taskDate.isSameDate(now)) {
        todayTasks.add(task);
      } else {
        futureTasks.add(task);
      }
    }

    if (category == 'today') {
      return todayTasks;
    } else if (category == 'future') {
      return futureTasks;
    } else if (category == 'completed') {
      return completedTasks;
    } else {
      return tasks;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 34,
                  height: 34,
                  color: Colors.black,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: -4,
                        left: -2,
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 28,
                          height: 28,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "FocusCraft",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {
                // Add your search action here
              },
            ),
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: Colors.black),
              onPressed: () {
                // Add your notification action here
              },
            ),
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                // Add your navigation bar action here
              },
            ),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(60.0), // Adjust the height here
            child: TabBar(
              isScrollable: true,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              labelStyle: TextStyle(
                fontSize: 20.0, // Customize the font size for selected tab
                fontWeight: FontWeight.bold, // Customize the font weight for selected tab
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 18.0, // Customize the font size for unselected tabs
              ),
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("All"),
                      SizedBox(width: 5),
                      Text("(5)", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Work"),
                      SizedBox(width: 5),
                      Text("(2)", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Personal"),
                      SizedBox(width: 5),
                      Text("(1)", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Others"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            TaskListView(taskStream: _taskStream, category: 'all'),
            TaskListView(taskStream: _taskStream, category: 'work'),
            TaskListView(taskStream: _taskStream, category: 'personal'),
            TaskListView(taskStream: _taskStream, category: 'others'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigate to AddTask screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTask()),
            );
          },
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class TaskListView extends StatelessWidget {
  final Stream<QuerySnapshot> taskStream;
  final String category;

  const TaskListView({required this.taskStream, required this.category});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: taskStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        var tasks = snapshot.data!.docs;
        var todayTasks = categorizeTasks(tasks, 'today');
        var futureTasks = categorizeTasks(tasks, 'future');
        var completedTasks = categorizeTasks(tasks, 'completed');

        return ListView(
          children: [
            ExpansionTile(
              title: Text('Today'),
              children: todayTasks.map((task) {
                return TaskTile(task: task);
              }).toList(),
            ),
            ExpansionTile(
              title: Text('Future'),
              children: futureTasks.map((task) {
                return TaskTile(task: task);
              }).toList(),
            ),
            ExpansionTile(
              title: Text('Completed Today'),
              children: completedTasks.map((task) {
                return TaskTile(task: task);
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  List<DocumentSnapshot>
  categorizeTasks(List<DocumentSnapshot> tasks, String category) {
    DateTime now = DateTime.now();
    List<DocumentSnapshot> todayTasks = [];
    List<DocumentSnapshot> futureTasks = [];
    List<DocumentSnapshot> completedTasks = [];

    for (var task in tasks) {
      DateTime taskDate = DateTime.parse(task['date']);
      bool isCompleted = task['isCompleted'];

      if (isCompleted) {
        completedTasks.add(task);
      } else if (taskDate.isBefore(now) || taskDate.isSameDate(now)) {
        todayTasks.add(task);
      } else {
        futureTasks.add(task);
      }
    }

    if (category == 'today') {
      return todayTasks;
    } else if (category == 'future') {
      return futureTasks;
    } else if (category == 'completed') {
      return completedTasks;
    } else {
      return tasks;
    }
  }
}

class TaskTile extends StatelessWidget {
  final DocumentSnapshot task;

  const TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task['isCompleted'],
        onChanged: (bool? value) {
          FirebaseFirestore.instance.runTransaction((transaction) async {
            DocumentSnapshot freshSnap = await transaction.get(task.reference);
            transaction.update(freshSnap.reference, {'isCompleted': value});
          });
        },
      ),
      title: Text(task['title']),
      subtitle: Text(task['time']),
      trailing: IconButton(
        icon: Icon(task['isFavourite'] ?
        Icons.flag_outlined : Icons.flag,
          color:Colors.orange ,),
        onPressed: () {
          FirebaseFirestore.instance.runTransaction((transaction) async {
            DocumentSnapshot freshSnap = await transaction.get(task.reference);
            transaction.update(freshSnap.reference, {'isFavourite': !task['isFavourite']});
          });
        },
      ),
    );
  }
}

extension DateHelpers on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year && this.month == other.month && this.day == other.day;
  }
}
