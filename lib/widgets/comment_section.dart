import 'package:flutter/material.dart';
import '../models/comment.dart';

class CommentSection extends StatelessWidget {
  final List<Comment> comments;

  CommentSection({required this.comments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];
        return ListTile(
          title: Text(comment.content), // Use comment.content instead of comment.text
          subtitle: Text(comment.createdDate.toLocal().toString()), // Use comment.createdDate instead of comment.timestamp
        );
      },
    );
  }
}
