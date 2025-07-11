import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/models/book.dart';
import 'package:flutter_author_reader_app/services/book_service.dart';

class BookProvider with ChangeNotifier {
  final BookService _bookService = BookService();
  List<Book> _books = [];
  List<Book> get books => _books;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set books(List<Book> books) {
    _books = books;
    notifyListeners();
  }

  Future<void> fetchBooks() async {
    _isLoading = true;
    notifyListeners();
    try {
      _books = await _bookService.fetchBooks();
    } catch (e) {
      print('Failed to fetch books: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchBooksByCategory(String categoryId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _books = await _bookService.fetchBooksByCategory(categoryId);
    } catch (e) {
      print('Failed to fetch books by category: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<Book?> fetchBookDetails(String bookId) async {
    try {
      return await _bookService.fetchBook(bookId);
    } catch (e) {
      print('Failed to fetch book details: $e');
      throw e;
    }
  }

  /// Sorts books alphabetically by title.
  void sortBooksByTitle() {
    _books.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    notifyListeners();
  }

  /// Sorts books alphabetically by author name.
  void sortBooksByAuthor() {
    _books.sort((a, b) => a.authorId.toLowerCase().compareTo(b.authorId.toLowerCase()));
    notifyListeners();
  }

  /// Sorts books by date added in descending order (most recent first).
  void sortBooksByDateAdded() {
    _books.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    notifyListeners();
  }

  /// Searches books by title or author.
  Future<List<Book>> searchBooks(String query) async {
    try {
      return await _bookService.searchBooks(query);
    } catch (e) {
      print('Failed to search books: $e');
      return [];
    }
  }
}
