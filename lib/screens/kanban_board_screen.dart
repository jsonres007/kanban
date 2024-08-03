import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/column_widget.dart';
import '../models/task.dart';

class KanbanBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kanban Board")),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return Row(
            children: [
              Expanded(
                child: ColumnWidget(
                  status: "To Do",
                  tasks: taskProvider.tasks.where((task) => task.status == "To Do").toList(),
                  onTaskMoved: (task) => taskProvider.moveTask(task, "To Do"),
                ),
              ),
              Expanded(
                child: ColumnWidget(
                  status: "In Progress",
                  tasks: taskProvider.tasks.where((task) => task.status == "In Progress").toList(),
                  onTaskMoved: (task) => taskProvider.moveTask(task, "In Progress"),
                ),
              ),
              Expanded(
                child: ColumnWidget(
                  status: "Done",
                  tasks: taskProvider.tasks.where((task) => task.status == "Done").toList(),
                  onTaskMoved: (task) => taskProvider.moveTask(task, "Done"),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTask(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTask(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.addTask(Task(
      id: DateTime.now().toString(),
      title: 'New Task',
      description: 'Task description',
      status: 'To Do',
      comments: [],
      timeSpent: Duration.zero, // Initialize timeSpent
    ));
  }
}
