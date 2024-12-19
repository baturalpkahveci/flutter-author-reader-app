import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String id;
  final String content;
  final DateTime createdAt;
  final DocumentReference userId;

  Comment({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.userId,
  });

  /// Factory method to create a Comment object from Firestore data.
  factory Comment.fromFirestore(String id, Map<String, dynamic> data) {
    return Comment(
      id: id,
      content: data['content'] ?? '',
      createdAt: (data['created_at'] as Timestamp).toDate(),
      userId: data['user_id'],
    );
  }

  /// Converts a Comment object to a Firestore-compatible map.
  Map<String, dynamic> toFirestore() {
    return {
      'content': content,
      'created_at': Timestamp.fromDate(createdAt),
      'user_id': userId,
    };
  }
}
