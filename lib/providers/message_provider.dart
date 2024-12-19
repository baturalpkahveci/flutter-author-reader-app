import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/models/message.dart';
import 'package:flutter_author_reader_app/services/message_service.dart';

class MessageProvider with ChangeNotifier {
  final MessageService _messageService = MessageService();
  List<Message> _messages = [];

  List<Message> get messages => _messages;

  set messages(List<Message> messages) {
    _messages = messages;
    notifyListeners();
  }

  Future<void> fetchMessages(String userId) async {
    try {
      _messages = await _messageService.fetchMessages(userId);
      notifyListeners();
    } catch (e) {
      print('Failed to fetch messages: $e');
    }
  }

  Future<void> sendMessage(Message message) async {
    try {
      await _messageService.sendMessage(message);
      _messages.add(message);
      notifyListeners();
    } catch (e) {
      print('Failed to send message: $e');
    }
  }
}
