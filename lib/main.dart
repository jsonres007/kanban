import 'package:flutter/material.dart';
import 'package:kanban/models/task.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'screens/kanban_board_screen.dart';
import 'screens/task_detail_screen.dart';
import 'screens/history_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        title: 'Kanban App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: KanbanBoardScreen(),
        routes: {
          '/taskDetail': (context) => TaskDetailScreen(task: ModalRoute.of(context)!.settings.arguments as Task),
          '/history': (context) => HistoryScreen(),
        },
      ),
    );
  }
}
