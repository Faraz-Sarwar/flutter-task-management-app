import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskProvider extends ChangeNotifier {
  List<Map<String, dynamic>> tasks = [];

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    //this is because sharedPreference can only store string in local storage.
    final encodedTaskString = jsonEncode(tasks);
    await prefs.setString('tasks', encodedTaskString);
  }

  Future<void> addTask(String task) async {
    if (task.isEmpty) return;
    tasks.add({'title': task, 'isComplete': false});

    notifyListeners();
    await saveTasks();
  }

  Future<void> deleteTask(int index) async {
    tasks.removeAt(index);
    notifyListeners();
    await saveTasks();
  }

  Future<void> toggleTask(int index) async {
    // Flip the isComplete value, true becomes false, false becomes true
    tasks[index]['isComplete'] = !tasks[index]['isComplete'];

    notifyListeners();
    await saveTasks();
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();

    //Get saved Json string from SharedPreferences
    final taskJson = prefs.getString('tasks');
    if (taskJson != null) {
      //convert it back into dart object to display
      final List<dynamic> decodeData = jsonDecode(taskJson);

      //Convert every item to Map<String, dynamic>
      tasks = decodeData
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
      notifyListeners();
    }
  }

  Future<void> editTask(int index, String newTask) async {
    if (newTask.isEmpty) {
      return;
    }
    tasks[index]['title'] = newTask;
    notifyListeners();
    await saveTasks();
  }
}
