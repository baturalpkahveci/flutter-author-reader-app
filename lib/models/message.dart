import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String content;
  final DocumentReference receiverId;
  final DocumentReference senderId;
  final DateTime sentAt;

  Message({
    required this.id,
    required this.content,
    required this.receiverId,
    required this.senderId,
    required this.sentAt,
  });

  /// Factory method to create a Message object from Firestore data.
  factory Message.fromFirestore(String id, Map<String, dynamic> data) {
    return Message(
      id: id,
      content: data['content'] ?? '',
      receiverId: data['receiver_id'],
      senderId: data['sender_id'],
      sentAt: (data['sent_at'] as Timestamp).toDate(),
    );
  }

  /// Converts a Message object to a Firestore-compatible map.
  Map<String, dynamic> toFirestore() {
    return {
      'content': content,
      'receiver_id': receiverId,
      'sender_id': senderId,
      'sent_at': Timestamp.fromDate(sentAt),
    };
  }
}
