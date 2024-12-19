import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/models/reading_list_item.dart';
import 'package:flutter_author_reader_app/services/user_service.dart';

class ReadingListProvider with ChangeNotifier {
  final UserService _userService = UserService();
  List<ReadingListItem> _readingList = [];

  List<ReadingListItem> get readingList => _readingList;

  set readingList(List<ReadingListItem> readingList) {
    _readingList = readingList;
    notifyListeners();
  }

  Future<void> fetchReadingList(String userId) async {
    try {
      _readingList = await _userService.fetchReadingList(userId);
      notifyListeners();
    } catch (e) {
      print('Failed to fetch reading list: $e');
    }
  }

  Future<void> addToReadingList(String userId, ReadingListItem item) async {
    try {
      await _userService.addToReadingList(userId, item);
      _readingList.add(item);
      notifyListeners();
    } catch (e) {
      print('Failed to add to reading list: $e');
    }
  }
}
