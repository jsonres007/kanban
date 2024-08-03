import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void moveTask(Task task, String newStatus) {
    final taskIndex = _tasks.indexWhere((t) => t.id == task.id);
    if (taskIndex != -1) {
      _tasks[taskIndex] = Task(
        id: task.id,
        title: task.title,
        description: task.description,
        status: newStatus,
        comments: task.comments,
        timeSpent: task.timeSpent,
        completionDate: task.completionDate,
      );
      notifyListeners();
    }
  }

  void updateTask(Task updatedTask) {
    final taskIndex = _tasks.indexWhere((t) => t.id == updatedTask.id);
    if (taskIndex != -1) {
      _tasks[taskIndex] = updatedTask;
      notifyListeners();
    }
  }
}
