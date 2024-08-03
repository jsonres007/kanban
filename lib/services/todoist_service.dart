import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';

class TodoistService {
  final String baseUrl = "https://api.todoist.com/rest/v2";
  final String token = "YOUR_TEST_TOKEN";

  Future<List<Task>> fetchTasks() async {
    final response = await http.get(
      Uri.parse('$baseUrl/tasks'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> taskJson = json.decode(response.body);
      return taskJson.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> createTask(Task task) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tasks'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(task.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create task');
    }
  }

  // Additional methods for updating, deleting tasks, and adding comments
}
