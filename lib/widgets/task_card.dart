import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.description),
        trailing: Text(task.status),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import '../models/task.dart';

// class TaskCard extends StatelessWidget {
//   final Task task;

//   TaskCard({required this.task});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         title: Text(task.title),
//         subtitle: Text(
//           '${task.description}\nTime Spent: ${task.timeSpent.inMinutes} minutes',
//         ),
//         onTap: () {
//           Navigator.pushNamed(
//             context,
//             '/taskDetail',
//             arguments: task,
//           );
//         },
//       ),
//     );
//   }
// }
