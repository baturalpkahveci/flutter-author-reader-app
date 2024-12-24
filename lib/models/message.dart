import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String content;
  final DocumentReference senderId;
  final DateTime sentAt;
  final List<DocumentReference> likes;

  Message({
    required this.id,
    required this.content,
    required this.senderId,
    required this.sentAt,
    required this.likes,
  });

  /// Factory method to create a Message object from Firestore data.
  factory Message.fromFirestore(String id, Map<String, dynamic> data) {
    return Message(
      id: id,
      content: data['content'] ?? '',
      senderId: data['sender_id'],
      sentAt: (data['sent_at'] as Timestamp).toDate(),
      likes: List<DocumentReference>.from(data['likes'] ?? []),
    );
  }

  /// Converts a Message object to a Firestore-compatible map.
  Map<String, dynamic> toFirestore() {
    return {
      'content': content,
      'sender_id': senderId,
      'sent_at': Timestamp.fromDate(sentAt),
      'likes': likes,
    };
  }
}
