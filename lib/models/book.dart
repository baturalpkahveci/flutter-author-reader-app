import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String id;
  final String authorId;
  final String categoryId;
  final DateTime createdAt;
  final List<DocumentReference> favorites;
  final int favoritesCount;
  final String publishedDate;
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
  });

  /// Factory method to create a Book object from Firestore data.
  factory Book.fromFirestore(String id, Map<String, dynamic> data) {
    return Book(
      id: id,
      authorId: data['author_id'] ?? '',
      categoryId: data['category_id'] ?? '',
      createdAt: (data['created_at'] as Timestamp).toDate(),
      favorites: List<DocumentReference>.from(data['favorites'] ?? []),
      favoritesCount: data['favorites_count'] ?? 0,
      publishedDate: data['published_date'] ?? '',
      readCount: data['read_count'] ?? 0,
      summary: data['summary'] ?? '',
      title: data['title'] ?? '',
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
