import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_author_reader_app/models/book.dart';
import 'package:flutter_author_reader_app/models/comment.dart';
import 'package:flutter_author_reader_app/utils/keyword_utils.dart';
import 'package:intl/intl.dart'; // For generating random book ID

class BookService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Generate and sets keywords for searching
  Future<void> generateAndSetBookKeywords(Book book) async {
    final titleKeywords = generateKeywords(book.title);
    final authorKeywords = generateKeywords(book.authorId);
    final allKeywords = [...titleKeywords, ...authorKeywords];

    await FirebaseFirestore.instance.collection('books').doc(book.id).update({
      'keywords': allKeywords,
    });
  }

  /// Searches books by title or author.
  Future<List<Book>> searchBooks(String query) async {
    try {
      if (query.isEmpty) return []; // Return an empty list for an empty query

      final snapshot = await FirebaseFirestore.instance
          .collection('books')
          .orderBy('titleLowerCase') // Ensure this field is indexed in Firestore
          .startAt([query.toLowerCase()])
          .endAt(['${query.toLowerCase()}\uf8ff'])
          .get();

      // Use Future.wait to resolve the list of Future<Book>
      final books = await Future.wait(
        snapshot.docs.map((doc) => Book.fromFirestore(doc.id, doc.data())),
      );

      print('Books found: ${books.length}');
      return books;
    } catch (e) {
      print('Failed to search books: $e');
      return [];
    }
  }


  /// Fetches all books.
  Future<List<Book>> fetchBooks() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('books').get();

      // Use Future.wait to handle asynchronous Book creation
      List<Book> books = await Future.wait(snapshot.docs.map((doc) async {
        return await Book.fromFirestore(
          doc.id,
          doc.data() as Map<String, dynamic>, // Explicit cast
        );
      }).toList());

      return books;
    } catch (e) {
      print('Error fetching books: $e');
      throw e; // Optionally rethrow the error for higher-level handling
    }
  }


  /// Fetches a book by its ID.
  Future<Book?> fetchBook(String bookId) async {
    try {
      final doc = await _firestore.collection('books').doc(bookId).get();
      if (doc.exists) {
        return Book.fromFirestore(doc.id, doc.data()!);
      }
    } catch (e) {
      print('Error fetching book: $e');
    }
    return null;
  }

  /// Fetches books by category.
  Future<List<Book>> fetchBooksByCategory(String categoryId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('books')
          .where('category_id', isEqualTo: categoryId) // Ensure the field name matches your database
          .get();

      // Use Future.wait to handle asynchronous Book creation
      List<Book> books = await Future.wait(snapshot.docs.map((doc) async {
        return await Book.fromFirestore(
          doc.id,
          doc.data() as Map<String, dynamic>, // Explicit cast
        );
      }).toList());

      return books;
    } catch (e) {
      print('Error fetching books by category: $e');
      return [];
    }
  }

  /// Adds a new book to Firestore.
  Future<void> addBook(Book book) async {
    try {
      await _firestore.collection('books').doc(book.id).set(book.toFirestore());
      generateAndSetBookKeywords(book);
      print('Book added successfully.');
    } catch (e) {
      print('Error adding book: $e');
    }
  }

  /// Updates a specific field for a book.
  Future<void> updateBookField(String bookId, String field, dynamic value) async {
    try {
      await _firestore.collection('books').doc(bookId).update({field: value});
      //Generating no keyword here for now
      print('Book field updated successfully.');
    } catch (e) {
      print('Error updating book field: $e');
    }
  }

  /// Deletes a book from Firestore.
  Future<void> deleteBook(String bookId) async {
    try {
      await _firestore.collection('books').doc(bookId).delete();
      print('Book deleted successfully.');
    } catch (e) {
      print('Error deleting book: $e');
    }
  }

  /// Fetches the comments for a book.
  Future<List<Comment>> fetchComments(String bookId) async {
    try {
      final snapshot = await _firestore
          .collection('books')
          .doc(bookId)
          .collection('comments')
          .get();

      return snapshot.docs
          .map((doc) => Comment.fromFirestore(doc.id, doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching comments: $e');
      return [];
    }
  }

  /// Adds a comment to a book.
  Future<void> addComment(String bookId, Comment comment) async {
    try {
      await _firestore
          .collection('books')
          .doc(bookId)
          .collection('comments')
          .doc(comment.id)
          .set(comment.toFirestore());
      print('Comment added successfully.');
    } catch (e) {
      print('Error adding comment: $e');
    }
  }

  /// Generates a unique book ID and creates a new book with minimal input
  Future<void> createNewBook({
    required String authorId,
    required String categoryId,
    required String categoryName,
    required String title,
    required DateTime publishedDate,
    String? summary, // Optional summary
  }) async {
    try {
      // Step 1: Generate a random book ID
      String bookId = await _generateUniqueBookId();

      // Step 2: Set default values for other fields
      DateTime createdAt = DateTime.now();
      List<DocumentReference> favorites = [];
      int favoritesCount = 0;
      int readCount = 0;
      //String categoryName = ''; // Initially empty, will fetch later if needed
      String bookSummary = summary ?? ''; // Use provided summary or default to empty string

      // Step 3: Create a new Book object with minimal input
      Book newBook = Book(
        id: bookId,
        authorId: authorId,
        categoryId: categoryId,
        categoryName: categoryName,
        createdAt: createdAt,
        favorites: favorites,
        favoritesCount: favoritesCount,
        publishedDate: publishedDate,
        readCount: readCount,
        summary: bookSummary,
        title: title,
      );

      // Step 4: Add the new book to Firestore
      await _firestore.collection('books').doc(bookId).set(newBook.toFirestore());
      // Generate Keywords
      generateAndSetBookKeywords(newBook);
      print('Book created successfully with ID: $bookId');
    } catch (e) {
      print('Error creating book: $e');
    }
  }

  /// Generates a unique book ID and ensures it doesn't conflict with existing books
  Future<String> _generateUniqueBookId() async {
    String newId = '';
    bool idExists = true;

    while (idExists) {
      newId = _generateRandomBookId();
      idExists = await _checkIfBookIdExists(newId);
    }

    return newId;
  }

  /// Generates a random book ID
  String _generateRandomBookId() {
    final rand = Random();
    final dateTimeStr = DateFormat('yyyyMMddHHmmss').format(DateTime.now());
    final randomStr = List.generate(5, (index) => rand.nextInt(10)).join();
    return '$dateTimeStr$randomStr';
  }

  /// Checks if a book ID already exists in Firestore
  Future<bool> _checkIfBookIdExists(String bookId) async {
    try {
      final docSnapshot = await _firestore.collection('books').doc(bookId).get();
      return docSnapshot.exists;
    } catch (e) {
      print('Error checking if book ID exists: $e');
      return true; // Assume it exists if there's an error
    }
  }
}
