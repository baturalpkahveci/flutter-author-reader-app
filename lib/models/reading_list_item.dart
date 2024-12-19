import 'package:cloud_firestore/cloud_firestore.dart';

class ReadingListItem {
  final String id;
  final DateTime addedAt;
  final int rating;
  final String status;

  ReadingListItem({
    required this.id,
    required this.addedAt,
    required this.rating,
    required this.status,
  });

  /// Factory method to create a ReadingListItem object from Firestore data.
  factory ReadingListItem.fromFirestore(String id, Map<String, dynamic> data) {
    return ReadingListItem(
      id: id,
      addedAt: (data['added_at'] as Timestamp).toDate(),
      rating: data['rating'] ?? 0,
      status: data['status'] ?? '',
    );
  }

  /// Converts a ReadingListItem object to a Firestore-compatible map.
  Map<String, dynamic> toFirestore() {
    return {
      'added_at': Timestamp.fromDate(addedAt),
      'rating': rating,
      'status': status,
    };
  }
}
