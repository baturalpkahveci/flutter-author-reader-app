import 'package:cloud_firestore/cloud_firestore.dart';

class UserChat {
  final String id;
  final List<DocumentReference> participants;
  final String lastMessage;
  final DateTime lastMessageAt;

  UserChat({
    required this.id,
    required this.participants,
    required this.lastMessage,
    required this.lastMessageAt,
  });

  /// Factory method to create a UserChat object from Firestore data.
  factory UserChat.fromFirestore(String id, Map<String, dynamic> data) {
    return UserChat(
      id: id,
      participants: List<DocumentReference>.from(data['participants'] ?? []),
      lastMessage: data['last_message'] ?? '',
      lastMessageAt: (data['last_message_at'] as Timestamp).toDate(),
    );
  }

  /// Converts a UserChat object to a Firestore-compatible map.
  Map<String, dynamic> toFirestore() {
    return {
      'participants': participants,
      'last_message': lastMessage,
      'last_message_at': Timestamp.fromDate(lastMessageAt),
    };
  }
}
