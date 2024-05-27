import 'package:flutter/material.dart';
import 'package:to_do_app/screens/home_page.dart';
import 'package:to_do_app/auth/signup_screen.dart';
import 'package:to_do_app/screens/task_screen.dart';
import '../screens/add_task.dart';
import '../auth/signin_screen.dart';

class Routes {
  void navigateToHomeScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }


  void navigateToTaskScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const TaskScreen()),
    );
  }



  void navigateToSignUpScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  void navigateToSignInScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }

  void navigateToAddTask(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) =>  AddTask()),
    );
  }



}
