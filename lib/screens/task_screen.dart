import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TaskScreen(),
    );
  }
}

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
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
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.center,
            labelColor: Colors.grey,
            indicatorColor: Colors.black ,
            tabs: [
              Tab(text: "All"),
              Tab(text: "Tasks"),
              Tab(text: "Profile"),
              Tab(text: "Settings"),

            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomePage(),
            TasksPage(),
            ProfilePage(),
            SettingsPage(),
          ],
        ),
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Home Page"));
  }
}

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Tasks Page"));
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Profile Page"));
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Settings Page"));
  }
}
