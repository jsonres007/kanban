import 'dart:convert';

class Comment {
  final String id;
  final String taskId;
  final String content;
  final DateTime createdDate;

  Comment({
    required this.id,
    required this.taskId,
    required this.content,
    required this.createdDate,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      taskId: json['taskId'],
      content: json['content'],
      createdDate: DateTime.parse(json['createdDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskId': taskId,
      'content': content,
      'createdDate': createdDate.toIso8601String(),
    };
  }
}
