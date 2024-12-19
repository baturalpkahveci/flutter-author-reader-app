import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_author_reader_app/models/book.dart';
import 'package:flutter_author_reader_app/models/comment.dart';

class BookService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetches all books.
  Future<List<Book>> fetchBooks() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('books').get();
      List<Book> books = snapshot.docs.map((doc) {
        return Book.fromFirestore(
          doc.id,
          doc.data() as Map<String, dynamic>, // Explicit cast
        );
      }).toList();
      return books;
    } catch (e) {
      print('Error fetching books: $e');
      throw e;
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

  /// Adds a new book to Firestore.
  Future<void> addBook(Book book) async {
    try {
      await _firestore.collection('books').doc(book.id).set(book.toFirestore());
      print('Book added successfully.');
    } catch (e) {
      print('Error adding book: $e');
    }
  }

  /// Updates a specific field for a book.
  Future<void> updateBookField(String bookId, String field, dynamic value) async {
    try {
      await _firestore.collection('books').doc(bookId).update({field: value});
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
}
