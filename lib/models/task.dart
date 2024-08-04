import 'comment.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final String status;
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

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? status,
    List<Comment>? comments,
    Duration? timeSpent,
    DateTime? completionDate,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      comments: comments ?? this.comments,
      timeSpent: timeSpent ?? this.timeSpent,
      completionDate: completionDate ?? this.completionDate,
    );
  }
}
