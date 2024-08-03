import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../models/comment.dart';
import 'dart:async';

class TaskDetailScreen extends StatefulWidget {
  final Task task;

  TaskDetailScreen({required this.task});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late Task _task;
  late TextEditingController _commentController;
  Timer? _timer;
  Duration _elapsedTime = Duration.zero;
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    _task = widget.task;
    _commentController = TextEditingController();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _commentController.dispose();
    super.dispose();
  }

  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      final newComment = Comment(
        id: DateTime.now().toString(),
        taskId: _task.id,
        content: _commentController.text,
        createdDate: DateTime.now(),
      );

      setState(() {
        _task.comments.add(newComment);
        _commentController.clear();
      });

      // Notify provider
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      taskProvider.updateTask(_task);
    }
  }

  void _startStopTimer() {
    if (_isTimerRunning) {
      _timer?.cancel();
      setState(() {
        _isTimerRunning = false;
        _task = Task(
          id: _task.id,
          title: _task.title,
          description: _task.description,
          status: _task.status,
          comments: _task.comments,
          timeSpent: _task.timeSpent + _elapsedTime,
          completionDate: _task.completionDate,
        );
        _elapsedTime = Duration.zero;
      });
      // Notify provider
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      taskProvider.updateTask(_task);
    } else {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _elapsedTime += Duration(seconds: 1);
        });
      });
      setState(() {
        _isTimerRunning = true;
      });
    }
  }

  void _updateTaskStatus(String newStatus) {
    setState(() {
      _task = Task(
        id: _task.id,
        title: _task.title,
        description: _task.description,
        status: newStatus,
        comments: _task.comments,
        timeSpent: _task.timeSpent,
        completionDate: _task.completionDate,
      );
    });

    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.updateTask(_task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_task.title),
        actions: [
          PopupMenuButton<String>(
            onSelected: _updateTaskStatus,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: 'To Do', child: Text('To Do')),
                PopupMenuItem(value: 'In Progress', child: Text('In Progress')),
                PopupMenuItem(value: 'Done', child: Text('Done')),
              ];
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _task.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Time Spent: ${_task.timeSpent.inMinutes} minutes',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Elapsed Time: ${_elapsedTime.inMinutes} minutes',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _startStopTimer,
              child: Text(_isTimerRunning ? 'Stop Timer' : 'Start Timer'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(labelText: 'Add Comment'),
            ),
            ElevatedButton(
              onPressed: _addComment,
              child: Text('Add Comment'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _task.comments.length,
                itemBuilder: (context, index) {
                  final comment = _task.comments[index];
                  return ListTile(
                    title: Text(comment.content),
                    subtitle: Text(comment.createdDate.toLocal().toString()),
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
