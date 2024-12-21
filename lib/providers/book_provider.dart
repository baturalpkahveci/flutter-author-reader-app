import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/models/book.dart';
import 'package:flutter_author_reader_app/services/book_service.dart';

class BookProvider with ChangeNotifier {
  final BookService _bookService = BookService();
  List<Book> _books = [];

  List<Book> get books => _books;

  set books(List<Book> books) {
    _books = books;
    notifyListeners();
  }

  Future<void> fetchBooks() async {
    try {
      _books = await _bookService.fetchBooks();
      notifyListeners();
    } catch (e) {
      print('Failed to fetch books: $e');
    }
  }

  /// Fetches books by category.
  Future<void> fetchBooksByCategory(String categoryId) async {
    try {
      _books = await _bookService.fetchBooksByCategory(categoryId);
      notifyListeners();
    } catch (e) {
      print('Failed to fetch books by category: $e');
    }
  }

  Future<Book?> fetchBookDetails(String bookId) async {
    try {
      return await _bookService.fetchBook(bookId);
    } catch (e) {
      print('Failed to fetch book details: $e');
      throw e;
    }
  }
}
