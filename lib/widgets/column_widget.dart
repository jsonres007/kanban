import 'package:flutter/material.dart';
import '../models/task.dart';
import '../screens/task_detail_screen.dart';
import 'task_card.dart';

class ColumnWidget extends StatelessWidget {
  final String status;
  final List<Task> tasks;
  final void Function(Task) onTaskMoved;

  ColumnWidget({
    required this.status,
    required this.tasks,
    required this.onTaskMoved,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<Task>(
      onAccept: (task) {
        onTaskMoved(task);
      },
      builder: (context, candidateData, rejectedData) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                status,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailScreen(task: task),
                        ),
                      );
                    },
                    child: TaskCard(task: task),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
