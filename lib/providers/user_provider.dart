import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/models/user.dart';
import 'package:flutter_author_reader_app/services/user_service.dart';
import 'package:flutter_author_reader_app/models/reading_list_item.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();
  User? _currentUser;

  User? get currentUser => _currentUser;

  set currentUser(User? user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> fetchUser(String userId) async {
    try {
      _currentUser = await _userService.fetchUser(userId);
      notifyListeners();
    } catch (e) {
      print('Failed to fetch user: $e');
    }
  }

  Future<void> updateUserProfile(User updatedUser) async {
    try {
      await _userService.updateUser(updatedUser);
      _currentUser = updatedUser; // Update the local user state
      notifyListeners();
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }

  Future<List<ReadingListItem>> fetchReadingList(String userId) async {
    try {
      return await _userService.fetchReadingList(userId);
    } catch (e) {
      print('Failed to fetch reading list: $e');
      return [];
    }
  }

  Future<void> addToReadingList(String userId, ReadingListItem item) async {
    try {
      await _userService.addToReadingList(userId, item);
      notifyListeners(); // Update provider state to reflect changes
    } catch (e) {
      print('Failed to add to reading list: $e');
    }
  }
}
