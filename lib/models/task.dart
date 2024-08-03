import 'comment.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final String status; // e.g., "To Do", "In Progress", "Done"
  final List<Comment> comments;
  final Duration timeSpent;
  final DateTime? completionDate;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.comments,
    required this.timeSpent,
    this.completionDate,
  });

  // Factory constructor to create a Task object from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      comments: (json['comments'] as List).map((commentJson) => Comment.fromJson(commentJson)).toList(),
      timeSpent: Duration(seconds: json['timeSpent']),
      completionDate: json['completionDate'] != null ? DateTime.parse(json['completionDate']) : null,
    );
  }

  // Method to convert a Task object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'comments': comments.map((comment) => comment.toJson()).toList(),
      'timeSpent': timeSpent.inSeconds,
      'completionDate': completionDate?.toIso8601String(),
    };
  }
}
