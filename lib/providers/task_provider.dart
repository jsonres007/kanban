import 'package:flutter/material.dart';
import '../models/task.dart';
import 'timer_provider.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<String> _columnStatuses = ['To Do', 'In Progress', 'Done'];

  List<Task> get tasks => _tasks;
  List<String> get columnStatuses => _columnStatuses;

  final TimerProvider timerProvider;

  TaskProvider(this.timerProvider);

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  void addColumn(String columnName) {
    if (!_columnStatuses.contains(columnName)) {
      _columnStatuses.add(columnName);
      notifyListeners();
    }
  }

  void removeColumn(String columnName) {
    if (_columnStatuses.contains(columnName)) {
      _columnStatuses.remove(columnName);
      notifyListeners();
    }
  }

  void renameColumn(String oldName, String newName) {
    final index = _columnStatuses.indexOf(oldName);
    if (index != -1 && !_columnStatuses.contains(newName)) {
      _columnStatuses[index] = newName;
      notifyListeners();
    }
  }

  void moveTask(Task task, String newStatus) {
    final taskIndex = _tasks.indexWhere((t) => t.id == task.id);
    if (taskIndex != -1) {
      final oldStatus = _tasks[taskIndex].status;

      if (oldStatus == 'In Progress' && newStatus != 'In Progress') {
        timerProvider.stopTimer(task.id);
        _tasks[taskIndex] = _tasks[taskIndex].copyWith(
          status: newStatus,
          timeSpent: _tasks[taskIndex].timeSpent + timerProvider.getTime(task.id),
        );
      } else if (oldStatus != 'In Progress' && newStatus == 'In Progress') {
        timerProvider.startTimer(task.id);
        _tasks[taskIndex] = _tasks[taskIndex].copyWith(status: newStatus);
      } else {
        _tasks[taskIndex] = _tasks[taskIndex].copyWith(status: newStatus);
      }

      notifyListeners();
    }
  }
}
