import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/models/group_chat.dart';
import 'package:flutter_author_reader_app/models/user_chat.dart';
import 'package:flutter_author_reader_app/services/group_chat_service.dart';
import 'package:flutter_author_reader_app/services/user_chat_service.dart';

class ChatProvider with ChangeNotifier {
  final UserChatService _userChatService = UserChatService();
  final GroupChatService _groupChatService = GroupChatService();

  List<UserChat> _userChats = [];
  List<GroupChat> _groupChats = [];
  List<dynamic> _allChats = []; // Dynamic list to combine both types of chats.

  List<UserChat> get userChats => _userChats;
  List<GroupChat> get groupChats => _groupChats;
  List<dynamic> get allChats => _allChats;

  /// Fetches user chats.
  Future<void> fetchUserChats(String userId) async {
    try {
      _userChats = await _userChatService.fetchUserChats(userId);
      _updateAllChats();
      notifyListeners();
    } catch (e) {
      print('Failed to fetch user chats: $e');
    }
  }

  /// Fetches group chats.
  Future<void> fetchGroupChats(String userId) async {
    try {
      _groupChats = await _groupChatService.fetchUserGroupChats(userId);
      _updateAllChats();
      notifyListeners();
    } catch (e) {
      print('Failed to fetch group chats: $e');
    }
  }

  /// Updates the combined `allChats` list.
  void _updateAllChats() {
    _allChats = [..._userChats, ..._groupChats];
    _allChats.sort((a, b) {
      // Sort by the `lastMessageAt` timestamp, descending.
      final aDate = a is UserChat ? a.lastMessageAt : (a as GroupChat).lastMessageAt;
      final bDate = b is UserChat ? b.lastMessageAt : (b as GroupChat).lastMessageAt;
      return bDate.compareTo(aDate);
    });
  }

  /// Fetches all chats (user + group).
  Future<void> fetchAllChats(String userId) async {
    await Future.wait([
      fetchUserChats(userId),
      fetchGroupChats(userId),
    ]);
  }
}
