import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_author_reader_app/models/message.dart';
import 'package:flutter_author_reader_app/models/group_chat.dart';

class GroupChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetches all group chats for a specific user.
  Future<List<GroupChat>> fetchUserGroupChats(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('group_chats')
          .where('members', arrayContains: _firestore.doc('users/$userId'))
          .get();

      return snapshot.docs
          .map((doc) => GroupChat.fromFirestore(doc.id, doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching group chats: $e');
      return [];
    }
  }

  // Fetch all messages in a group chat
  Future<List<Message>> fetchGroupMessages(String groupId) async {
    try {
      final snapshot = await _firestore
          .collection('group_chats')
          .doc(groupId)
          .collection('messages')
          .orderBy('sent_at')
          .get();

      return snapshot.docs
          .map((doc) => Message.fromFirestore(doc.id, doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching group messages: $e');
      return [];
    }
  }

  // Send a message in a group chat
  Future<void> sendGroupMessage(String groupId, Message message) async {
    try {
      await _firestore
          .collection('group_chats')
          .doc(groupId)
          .collection('messages')
          .add(message.toFirestore());
      print('Group message sent successfully.');
    } catch (e) {
      print('Error sending group message: $e');
    }
  }

  // Like a message in a group chat
  Future<void> likeGroupMessage(String groupId, String messageId, DocumentReference userId) async {
    try {
      final messageRef = _firestore.collection('group_chats').doc(groupId).collection('messages').doc(messageId);
      await messageRef.update({
        'likes': FieldValue.arrayUnion([userId]),
      });
      print('Message liked successfully.');
    } catch (e) {
      print('Error liking group message: $e');
    }
  }
}
