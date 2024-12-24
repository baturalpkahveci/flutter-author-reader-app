import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_author_reader_app/models/message.dart';
import 'package:flutter_author_reader_app/models/user_chat.dart';

class UserChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetches all user chats for a specific user.
  Future<List<UserChat>> fetchUserChats(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('user_chats')
          .where('participants', arrayContains: _firestore.doc('users/$userId'))
          .get();

      return snapshot.docs
          .map((doc) => UserChat.fromFirestore(doc.id, doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching user chats: $e');
      return [];
    }
  }

  // Fetch all messages in a user chat (one-on-one)
  Future<List<Message>> fetchUserMessages(String userChatId) async {
    try {
      final snapshot = await _firestore
          .collection('user_chats')
          .doc(userChatId)
          .collection('messages')
          .orderBy('sent_at')
          .get();

      return snapshot.docs
          .map((doc) => Message.fromFirestore(doc.id, doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching user messages: $e');
      return [];
    }
  }

  // Send a message in a user chat (one-on-one)
  Future<void> sendUserMessage(String userChatId, Message message) async {
    try {
      await _firestore
          .collection('user_chats')
          .doc(userChatId)
          .collection('messages')
          .add(message.toFirestore());
      print('User message sent successfully.');
    } catch (e) {
      print('Error sending user message: $e');
    }
  }

  // Like a message in a user chat
  Future<void> likeUserMessage(String userChatId, String messageId, DocumentReference userId) async {
    try {
      final messageRef = _firestore.collection('user_chats').doc(userChatId).collection('messages').doc(messageId);
      await messageRef.update({
        'likes': FieldValue.arrayUnion([userId]),
      });
      print('Message liked successfully.');
    } catch (e) {
      print('Error liking user message: $e');
    }
  }
}
