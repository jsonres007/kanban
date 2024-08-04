import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskDetailsView extends StatelessWidget {
  final Task task;
  final bool isEditing;
  final TextEditingController commentController;
  final VoidCallback onAddComment;
  final VoidCallback onStartStopTimer;
  final Duration elapsedTime;
  final bool isTimerRunning;

  TaskDetailsView({
    required this.task,
    required this.isEditing,
    required this.commentController,
    required this.onAddComment,
    required this.onStartStopTimer,
    required this.elapsedTime,
    required this.isTimerRunning,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'Task Details',
        //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        // ),
        // SizedBox(height: 16),
        isEditing
            ? SizedBox.shrink() // Hide title and description if editing
            : Text(
                task.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
                isEditing
            ? SizedBox.shrink() // Hide status if editing
            : Text(
                'Status: ${task.status}',
                style: TextStyle(fontSize: 16),
              ),
              // Text(
              //   'Time Spent: ${task.timeSpent}',
              //   style: TextStyle(fontSize: 16),
              // ),
        isEditing
            ? SizedBox.shrink() 
            : Text(
                task.description,
                style: TextStyle(fontSize: 16),
              ),
        SizedBox(height: 16),
      
        SizedBox(height: 16),
        // isEditing
        //     ? SizedBox.shrink() // Hide status dropdown if editing
        //     : DropdownButton<String>(
        //         value: task.status,
        //         onChanged: (newStatus) {},
        //         items: [],
        //       ),
        SizedBox(height: 16),
        // Text(
        //   'Time Spent: ${task.timeSpent.inMinutes} minutes',
        //   style: TextStyle(fontSize: 16),
        // ),
        // Text(
        //   'Elapsed Time: ${elapsedTime.inMinutes} minutes',
        //   style: TextStyle(fontSize: 16),
        // ),
        // SizedBox(height: 16),
        // ElevatedButton(
        //   onPressed: onStartStopTimer,
        //   child: Text(isTimerRunning ? 'Stop Timer' : 'Start Timer'),
        // ),
        SizedBox(height: 16),
        Divider(height: 2,),
                 SizedBox(height: 24,),
       Container(
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey), // Set the border color
    borderRadius: BorderRadius.circular(8.0), // Set the border radius
  ),
  child: TextField(
    controller: commentController,
    decoration: InputDecoration(
      hintText: 'Add Comment',
      border: InputBorder.none, // Remove the default underline
      contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0), // Add padding
    ),
  ),
),

        SizedBox(height: 20,),
        
        ElevatedButton(
          onPressed: onAddComment,
          child: Text('Add Comment'),
        ),
        SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: task.comments.length,
            itemBuilder: (context, index) {
              final comment = task.comments[index];
              return ListTile(
                title: Text(comment.content),
                subtitle: Text(comment.createdDate.toLocal().toString()),
              );
            },
          ),
        ),
      ],
    );
  }
}
