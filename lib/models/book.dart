import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_author_reader_app/services/category_service.dart';

class Book {
  final String id;
  final String authorId;
  String? categoryName;
  final String categoryId;
  final DateTime createdAt;
  final List<DocumentReference> favorites;
  final int favoritesCount;
  final DateTime publishedDate;
  final int readCount;
  final String summary;
  final String title;

  Book({
    required this.id,
    required this.authorId,
    required this.categoryId,
    required this.createdAt,
    required this.favorites,
    required this.favoritesCount,
    required this.publishedDate,
    required this.readCount,
    required this.summary,
    required this.title,
    this.categoryName, // Optional during initialization
  });

  /// Factory method to create a Book object from Firestore data and fetch category name asynchronously.
  static Future<Book> fromFirestore(String id, Map<String, dynamic> data) async {
    var categoryService = CategoryService();
    String? categoryName;

    try {
      var category = await categoryService.fetchCategoryById(data['category_id']);
      categoryName = category?.name;
    } catch (e) {
      // Handle the error or log it
      print('Error fetching category: $e');
    }

    return Book(
      id: id,
      authorId: data['author_id'] ?? '',
      categoryId: data['category_id'] ?? '',
      createdAt: (data['created_at'] as Timestamp).toDate(),
      favorites: List<DocumentReference>.from(data['favorites'] ?? []),
      favoritesCount: data['favorites_count'] ?? 0,
      publishedDate: (data['published_date'] as Timestamp).toDate(),
      readCount: data['read_count'] ?? 0,
      summary: data['summary'] ?? '',
      title: data['title'] ?? '',
      categoryName: categoryName,
    );
  }

  /// Converts a Book object to a Firestore-compatible map.
  Map<String, dynamic> toFirestore() {
    return {
      'author_id': authorId,
      'category_id': categoryId,
      'created_at': Timestamp.fromDate(createdAt),
      'favorites': favorites,
      'favorites_count': favoritesCount,
      'published_date': publishedDate,
      'read_count': readCount,
      'summary': summary,
      'title': title,
    };
  }
}
