import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/column_widget.dart';
import '../models/task.dart';

class KanbanBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kanban Board"),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.remove, color: Colors.white),
                          onPressed: () => _showRemoveColumnDialog(context),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Column',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.add, color: Colors.white),
                          onPressed: () => _showAddColumnDialog(context),
                        ),
                      ),
                    ],
                  ),
                ),
                // Kanban Board with border
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2.0), // Border color and width
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners (optional)
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: taskProvider.columnStatuses
                            .asMap()
                            .entries
                            .map((entry) {
                          int index = entry.key;
                          String status = entry.value;

                          return Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width /
                                    taskProvider.columnStatuses.length,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          status,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () =>
                                              _addTask(context, status),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: ColumnWidget(
                                        status: status,
                                        tasks: taskProvider.tasks
                                            .where((task) =>
                                                task.status == status)
                                            .toList(),
                                        onTaskMoved: (task) =>
                                            taskProvider.moveTask(task, status),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (index <
                                  taskProvider.columnStatuses.length - 1) // Add divider only if not the last column
                                VerticalDivider(width: 40, thickness: 2),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _addTask(BuildContext context, String status) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.addTask(Task(
      id: DateTime.now().toString(),
      title: 'New Task',
      description: 'Task description',
      status: status,
      comments: [],
      timeSpent: Duration.zero,
    ));
  }

  void _showAddColumnDialog(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    TextEditingController columnController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Column'),
          content: TextField(
            controller: columnController,
            decoration: InputDecoration(hintText: 'Column name'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                String columnName = columnController.text.trim();
                if (columnName.isNotEmpty) {
                  taskProvider.addColumn(columnName);
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showRemoveColumnDialog(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    String? selectedColumn;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Remove Column'),
          content: DropdownButton<String>(
            value: selectedColumn,
            hint: Text('Select column to remove'),
            items: taskProvider.columnStatuses.map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text(status),
              );
            }).toList(),
            onChanged: (value) {
              selectedColumn = value;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (selectedColumn != null) {
                  taskProvider.removeColumn(selectedColumn!);
                  Navigator.pop(context);
                }
              },
              child: Text('Remove'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
