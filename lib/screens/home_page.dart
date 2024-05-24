import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../routes/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
                children: [
          const SizedBox(
            height: 80.0,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Lottie.asset(
                'assets/animation.json',
                width: 400,
                height: 400,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const Text(
            "No tasks yet",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Add your to-dos by tapping the plus button below",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 190,
          ),
          FloatingActionButton(
            onPressed: () {
             Routes().navigateToAddTask(context);
            },
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
                ],
              ),
        ));
  }
}
