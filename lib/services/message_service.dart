import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_author_reader_app/models/message.dart';

class MessageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetches all messages sent to a user.
  Future<List<Message>> fetchMessages(String receiverId) async {
    try {
      final snapshot = await _firestore
          .collection('messages')
          .where('receiver_id', isEqualTo: _firestore.doc('users/$receiverId'))
          .get();

      return snapshot.docs
          .map((doc) => Message.fromFirestore(doc.id, doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching messages: $e');
      return [];
    }
  }

  /// Sends a message.
  Future<void> sendMessage(Message message) async {
    try {
      await _firestore.collection('messages').doc(message.id).set(message.toFirestore());
      print('Message sent successfully.');
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  /// Deletes a message.
  Future<void> deleteMessage(String messageId) async {
    try {
      await _firestore.collection('messages').doc(messageId).delete();
      print('Message deleted successfully.');
    } catch (e) {
      print('Error deleting message: $e');
    }
  }
}
