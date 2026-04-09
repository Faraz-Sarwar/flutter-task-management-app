import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final taskController = TextEditingController();
  List<Map<String, dynamic>> tasks = [];

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    //this is because sharedPreference can only store string in local storage.
    final encodedTaskString = jsonEncode(tasks);
    await prefs.setString('tasks', encodedTaskString);
  }

  Future<void> addTask(String task) async {
    if (task.isEmpty) return;

    setState(() {
      tasks.add({'title': task, 'isComplete': false});
      taskController.clear();
    });

    await saveTasks();
  }

  Future<void> deleteTask(int index) async {
    setState(() {
      tasks.removeAt(index);
    });
    await saveTasks();
  }

  Future<void> toggleTask(int index) async {
    setState(() {
      // Flip the isComplete value, true becomes false, false becomes true
      tasks[index]['isComplete'] = !tasks[index]['isComplete'];
    });

    await saveTasks();
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();

    //Get saved string from SharedPreferences
    final taskJson = prefs.getString('tasks');
    if (taskJson != null) {
      //convert it back into dart object to display
      final List<dynamic> decodeData = jsonDecode(taskJson);
      setState(() {
        //Convert every item to Map<String, dynamic>
        tasks = decodeData
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your tasks'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Add a task'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          //add the task user entered in textformfield
                          addTask(taskController.text);
                          Navigator.pop(context);
                        },
                        child: const Text('Add'),
                      ),
                    ],
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: taskController,
                          decoration: InputDecoration(
                            hintText: 'Enter task',

                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.add,
              size: 32,
              color: Colors.deepOrangeAccent,
            ),
          ),
        ],
      ),

      body: tasks.isEmpty
          ? Center(
              child: const Text(
                'No tasks right now, add one to appear',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final taskTitle = tasks[index]['title'];
                        final isComplete = tasks[index]['isComplete'];
                        return Container(
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.only(bottom: 12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Checkbox(
                                focusColor: Colors.white,
                                hoverColor: Colors.white,
                                checkColor: Colors.black,
                                activeColor: Colors.white,
                                side: BorderSide(color: Colors.white),
                                value: isComplete,
                                onChanged: (value) {
                                  toggleTask(index);
                                },
                              ),
                              Expanded(
                                child: Text(
                                  taskTitle,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    decoration: isComplete
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  deleteTask(index);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
