import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/models/message.dart';
import 'package:flutter_author_reader_app/services/user_chat_service.dart';

class UserChatProvider with ChangeNotifier {
  final UserChatService _userChatService = UserChatService();
  List<Message> _messages = [];

  List<Message> get messages => _messages;

  set messages(List<Message> messages) {
    _messages = messages;
    notifyListeners();
  }

  // Fetch messages for a specific user chat (one-on-one)
  Future<void> fetchUserMessages(String userChatId) async {
    try {
      _messages = await _userChatService.fetchUserMessages(userChatId);
      notifyListeners();
    } catch (e) {
      print('Error fetching user messages: $e');
    }
  }

  // Send a message in a user chat (one-on-one)
  Future<void> sendUserMessage(String userChatId, Message message) async {
    try {
      await _userChatService.sendUserMessage(userChatId, message);
      _messages.add(message);
      notifyListeners();
    } catch (e) {
      print('Error sending user message: $e');
    }
  }

  // Like a message in a user chat
  Future<void> likeUserMessage(String userChatId, String messageId, DocumentReference userId) async {
    try {
      await _userChatService.likeUserMessage(userChatId, messageId, userId);
      // Update locally after liking
      final message = _messages.firstWhere((msg) => msg.id == messageId);
      message.likes.add(userId);
      notifyListeners();
    } catch (e) {
      print('Error liking user message: $e');
    }
  }
}
