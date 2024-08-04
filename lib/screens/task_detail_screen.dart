import 'package:flutter/material.dart';
import 'package:kanban/widgets/edit_task_dialog.dart';
import 'package:kanban/widgets/task_details_view.dart';
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
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _task = widget.task;
    _commentController = TextEditingController();

    // Start timer if the task is in progress
    if (_task.status == 'inprogress') {
      _startTimer();
    }
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
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime += Duration(seconds: 1);
      });
    });
    setState(() {
      _isTimerRunning = true;
    });
  }

  void _showEditPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return EditTaskDialog(task: _task, onSave: (updatedTask) {
          setState(() {
            _task = updatedTask;
            _isEditing = false;
          });

          // Notify provider
          final taskProvider = Provider.of<TaskProvider>(context, listen: false);
          taskProvider.updateTask(_task);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Task Details'),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
               
                  _showEditPopup();
                
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TaskDetailsView(
          task: _task,
          isEditing: _isEditing,
          commentController: _commentController,
          onAddComment: _addComment,
          onStartStopTimer: _startStopTimer,
          elapsedTime: _elapsedTime,
          isTimerRunning: _isTimerRunning,
        ),
      ),
    );
  }
}
