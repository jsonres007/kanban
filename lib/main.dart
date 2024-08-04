import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'providers/timer_provider.dart';
import 'screens/kanban_board_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TimerProvider()),
        ChangeNotifierProxyProvider<TimerProvider, TaskProvider>(
          create: (context) => TaskProvider(Provider.of<TimerProvider>(context, listen: false)),
          update: (context, timerProvider, taskProvider) => TaskProvider(timerProvider),
        ),
      ],
      child: MaterialApp(
        title: 'Kanban Board',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: KanbanBoardScreen(),
      ),
    );
  }
}
