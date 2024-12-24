import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/models/message.dart';
import 'package:flutter_author_reader_app/services/group_chat_service.dart';

class GroupChatProvider with ChangeNotifier {
  final GroupChatService _groupChatService = GroupChatService();
  List<Message> _messages = [];

  List<Message> get messages => _messages;

  set messages(List<Message> messages) {
    _messages = messages;
    notifyListeners();
  }

  // Fetch messages for a specific group
  Future<void> fetchGroupMessages(String groupId) async {
    try {
      _messages = await _groupChatService.fetchGroupMessages(groupId);
      notifyListeners();
    } catch (e) {
      print('Error fetching group messages: $e');
    }
  }

  // Send a message in a group
  Future<void> sendGroupMessage(String groupId, Message message) async {
    try {
      await _groupChatService.sendGroupMessage(groupId, message);
      _messages.add(message);
      notifyListeners();
    } catch (e) {
      print('Error sending group message: $e');
    }
  }

  // Like a message in a group chat
  Future<void> likeGroupMessage(String groupId, String messageId, DocumentReference userId) async {
    try {
      await _groupChatService.likeGroupMessage(groupId, messageId, userId);
      // Update locally after liking
      final message = _messages.firstWhere((msg) => msg.id == messageId);
      message.likes.add(userId);
      notifyListeners();
    } catch (e) {
      print('Error liking group message: $e');
    }
  }
}
