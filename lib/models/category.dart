class Category {
  final String id;
  final int bookCount;
  final String description;
  final String name;

  Category({
    required this.id,
    required this.bookCount,
    required this.description,
    required this.name,
  });

  /// Factory method to create a Category object from Firestore data.
  factory Category.fromFirestore(String id, Map<String, dynamic> data) {
    return Category(
      id: id,
      bookCount: data['book_count'] ?? 0,
      description: data['description'] ?? '',
      name: data['name'] ?? '',
    );
  }

  /// Converts a Category object to a Firestore-compatible map.
  Map<String, dynamic> toFirestore() {
    return {
      'book_count': bookCount,
      'description': description,
      'name': name,
    };
  }
}
