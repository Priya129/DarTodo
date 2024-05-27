import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/global/app_colors.dart';
import '../components/button.dart';
import '../routes/routes.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  String get formattedDate => DateFormat('yyyy-MM-dd').format(selectedDate);
  String get formattedTime => selectedTime.format(context);

  String dropdownValue = "Others";
  bool isFavorite = false;

  bool isSwitched = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Future<void> _saveTask() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final String userId = user.uid;
        final taskData = {
          'title': titleController.text,
          'date': formattedDate,
          'time': formattedTime,
          'category': dropdownValue,
          'isCompleted': isSwitched,
          'isFavourite': isFavorite,
        };

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('tasks')
            .add(taskData);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully saved the task!'),
            backgroundColor: Colors.green,
          ),
        );
        Routes().navigateToTaskScreen(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No user is currently signed in.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving task: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Add Task',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Title",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5.0),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Enter your title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Colors.black12,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Colors.black12,
                      width: 2.0,
                    ),
                  ),
                ),
                maxLines: 3,
                minLines: 2,
              ),
              const SizedBox(height: 15),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.transparentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    const Text("Selected date: "),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () => _selectDate(context),
                      child: Text(
                        formattedDate,
                        style: const TextStyle(
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text("Time: "),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () => _selectTime(context),
                      child: Text(
                        formattedTime,
                        style: const TextStyle(
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Text(
                    "Select Task Category:",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    style: const TextStyle(color: Colors.black),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: const [
                      DropdownMenuItem<String>(
                          value: 'Priority',
                          child: Text('Priority')),
                      DropdownMenuItem<String>(
                          value: 'Personal',
                          child: Text('Personal')),
                      DropdownMenuItem<String>(
                          value: 'Others',
                          child: Text('Others')),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Text(
                    "Completed:",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 20),
                  FlutterSwitch(
                    width: 70.0,
                    height: 35.0,
                    toggleSize: 30.0,
                    value: isSwitched,
                    borderRadius: 20.0,
                    padding: 4.0,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white,
                    toggleColor: Colors.white,
                    activeToggleColor: Colors.deepPurple.shade300,
                    inactiveToggleColor: Colors.grey.shade300,
                    activeSwitchBorder: Border.all(
                      color: Colors.deepPurple.shade300,
                      width: 1.0,
                    ),
                    inactiveSwitchBorder: Border.all(
                      color: Colors.grey.shade300,
                      width: 1.0,
                    ),
                    activeIcon: const Icon(
                      Icons.circle,
                      color: Colors.white,
                    ),
                    inactiveIcon: const Icon(
                      Icons.circle,
                      color: Colors.white,
                    ),
                    onToggle: (val) {
                      setState(() {
                        isSwitched = val;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Text(
                    "Favourite: ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: Colors.orange,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 380.0),
              Button(
                name: "Save",
                onPressed: _saveTask,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
