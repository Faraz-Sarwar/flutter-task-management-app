import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/provider/task_provider.dart';
import 'package:task_manager/task_enum.dart';

class TaskDialogue extends StatelessWidget {
  final TaskMoode mode;
  final TextEditingController taskValue;
  final int? index;

  const TaskDialogue({
    super.key,
    required this.mode,
    required this.taskValue,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TaskProvider>();

    return AlertDialog(
      title: Text(mode == TaskMoode.add ? "Add Task" : "Edit task"),

      content: TextFormField(
        controller: taskValue,
        decoration: InputDecoration(
          hintText: mode == TaskMoode.add ? "Add task" : "Edit task",
          enabledBorder: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(),
        ),
      ),

      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(foregroundColor: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrangeAccent,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            if (taskValue.text.isEmpty) return;

            if (mode == TaskMoode.add) {
              provider.addTask(taskValue.text);
              taskValue.clear();
              Navigator.pop(context);
            } else {
              if (index != null && mode == TaskMoode.edit) {
                provider.editTask(index!, taskValue.text);
                Navigator.pop(context);
                taskValue.clear();
              }
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
