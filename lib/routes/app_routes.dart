import 'package:flutter/material.dart';
import 'package:kanban/models/task.dart';
import '../screens/kanban_board_screen.dart';
import '../screens/task_detail_screen.dart';
import '../screens/history_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => KanbanBoardScreen(),
  '/history': (context) => HistoryScreen(),
};

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/taskDetail':
      final task = settings.arguments as Task;
      return MaterialPageRoute(
        builder: (context) => TaskDetailScreen(task: task),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => KanbanBoardScreen(),
      );
  }
}
