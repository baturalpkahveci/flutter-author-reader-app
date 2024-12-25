import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/models/book.dart';
import 'package:flutter_author_reader_app/models/firestore_user.dart';
import 'package:flutter_author_reader_app/services/book_service.dart';
import 'package:flutter_author_reader_app/services/user_service.dart';

class SearchProvider with ChangeNotifier {
  final BookService _bookService = BookService();
  final UserService _userService = UserService();

  // Search result lists
  List<Book> _bookResults = [];
  List<FirestoreUser> _userResults = [];

  // Getters
  List<Book> get bookResults => _bookResults;
  List<FirestoreUser> get userResults => _userResults;

  // Search status
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Search books by title or author
  Future<void> searchBooks(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _bookResults = await _bookService.searchBooks(query);
    } catch (e) {
      print("Error searching books: $e");
      _bookResults = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Search users by username or email
  Future<void> searchUsers(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _userResults = await _userService.searchUsers(query);
    } catch (e) {
      print("Error searching users: $e");
      _userResults = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Clear all search results
  void clearSearchResults() {
    _bookResults = [];
    _userResults = [];
    notifyListeners();
  }
}
