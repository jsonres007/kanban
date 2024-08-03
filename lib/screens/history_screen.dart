import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("History")),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          final completedTasks = taskProvider.tasks.where((task) => task.status == "Done").toList();
          return ListView.builder(
            itemCount: completedTasks.length,
            itemBuilder: (context, index) {
              final task = completedTasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text("Completed on: ${task.completionDate} - Time spent: ${task.timeSpent}"),
              );
            },
          );
        },
      ),
    );
  }
}
