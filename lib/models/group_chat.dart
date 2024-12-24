import 'package:cloud_firestore/cloud_firestore.dart';

class GroupChat {
  final String id;
  final String groupName;
  final String groupIcon;
  final List<DocumentReference> members;
  final String lastMessage;
  final DateTime lastMessageAt;

  GroupChat({
    required this.id,
    required this.groupName,
    required this.groupIcon,
    required this.members,
    required this.lastMessage,
    required this.lastMessageAt,
  });

  /// Factory method to create a GroupChat object from Firestore data.
  factory GroupChat.fromFirestore(String id, Map<String, dynamic> data) {
    return GroupChat(
      id: id,
      groupName: data['group_name'] ?? 'Unknown Group',
      groupIcon: data['group_icon'] ?? '',
      members: List<DocumentReference>.from(data['members'] ?? []),
      lastMessage: data['last_message'] ?? '',
      lastMessageAt: (data['last_message_at'] as Timestamp).toDate(),
    );
  }

  /// Converts a GroupChat object to a Firestore-compatible map.
  Map<String, dynamic> toFirestore() {
    return {
      'group_name': groupName,
      'group_icon': groupIcon,
      'members': members,
      'last_message': lastMessage,
      'last_message_at': Timestamp.fromDate(lastMessageAt),
    };
  }
}
