import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/components/task_dialogue.dart';
import 'package:task_manager/provider/task_provider.dart';
import 'package:task_manager/task_enum.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final taskController = TextEditingController();
  final editController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskProvider>().loadTasks();
    });
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
                  // TaskDialogue is a reusable task dialague box, gets parameter of wheather to call edit or add function which I pass it through an enum TaskMoode which determines which function to call. we can use string also like mode == "add or delete" but enums are more type safe.
                  //This is also an abstraction principle as it hides internal complexities of a module or class and makes UI screen in this case homescreen.dart clean and maintainable
                  return TaskDialogue(
                    mode: TaskMoode.add,
                    taskValue: taskController,
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

      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          if (provider.tasks.isEmpty) {
            return const Center(
              child: Text('No tasks right now, add one to appear'),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.tasks.length,
                    itemBuilder: (context, index) {
                      final taskTitle = provider.tasks[index]['title'];
                      final isComplete = provider.tasks[index]['isComplete'];
                      return Dismissible(
                        key: ValueKey(taskTitle),
                        direction: DismissDirection.horizontal,
                        background: Container(
                          padding: EdgeInsets.all(20),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        secondaryBackground: Container(
                          padding: EdgeInsets.all(20),
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        onDismissed: (direction) {
                          provider.deleteTask(index);
                        },
                        child: AnimatedContainer(
                          margin: EdgeInsets.only(bottom: 12),
                          padding: EdgeInsets.all(8),
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                          decoration: BoxDecoration(
                            color: isComplete
                                ? Colors.green
                                : Colors.deepOrange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Expanded(
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: Colors.white,
                                  checkColor: Colors.black,
                                  side: BorderSide(color: Colors.white),
                                  value: isComplete,
                                  onChanged: (value) {
                                    provider.toggleTask(index);
                                  },
                                ),
                                Expanded(
                                  child: Text(
                                    taskTitle,
                                    style: TextStyle(
                                      fontSize: 18,
                                      decoration: isComplete
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    editController.text = taskTitle;
                                    showDialog(
                                      context: context,
                                      builder: (_) => TaskDialogue(
                                        // here you can see the reusability of the task dialague class. its reuable and maintainable.
                                        mode: TaskMoode.edit,
                                        taskValue: editController,
                                        index: index,
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
