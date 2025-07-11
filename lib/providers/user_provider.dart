import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/models/firestore_user.dart';
import 'package:flutter_author_reader_app/models/reading_list_item.dart';
import 'package:flutter_author_reader_app/services/user_service.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();
  FirestoreUser? _currentUser;

  FirestoreUser? get currentUser => _currentUser;

  set currentUser(FirestoreUser? user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> fetchCurrentUser() async {
    try {
      _currentUser = await _userService.fetchCurrentUser();
      notifyListeners();
    } catch (e) {
      print('Failed to fetch current user: $e');
    }
  }

  Future<void> fetchUser(String userId) async {
    try {
      _currentUser = await _userService.fetchUser(userId);
      notifyListeners();
    } catch (e) {
      print('Failed to fetch user: $e');
    }
  }

  Future<void> updateUserProfile(FirestoreUser updatedUser) async {
    try {
      await _userService.updateUser(updatedUser);
      _currentUser = updatedUser;
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
      notifyListeners();
    } catch (e) {
      print('Failed to add to reading list: $e');
    }
  }

  /// Searches users by name or email.
  Future<List<FirestoreUser>> searchUsers(String query) async {
    try {
      return await _userService.searchUsers(query);
    } catch (e) {
      print('Failed to search users: $e');
      return [];
    }
  }
}
