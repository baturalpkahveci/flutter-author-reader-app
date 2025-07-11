import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUser {
  final String id;
  final String bio;
  final DateTime createdAt;
  final String email;
  final String fullName;
  final String username;

  FirestoreUser({
    required this.id,
    required this.bio,
    required this.createdAt,
    required this.email,
    required this.fullName,
    required this.username,
  });

  /// Factory method to create a User object from Firestore data.
  factory FirestoreUser.fromFirestore(String id, Map<String, dynamic> data) {
    return FirestoreUser(
      id: id,
      bio: data['bio'] ?? '',
      createdAt: (data['created_at'] as Timestamp).toDate(),
      email: data['email'] ?? '',
      fullName: data['full_name'] ?? '',
      username: data['username'] ?? '',
    );
  }

  /// Converts a User object to a Firestore-compatible map.
  Map<String, dynamic> toFirestore() {
    return {
      'bio': bio,
      'created_at': Timestamp.fromDate(createdAt),
      'email': email,
      'full_name': fullName,
      'username': username,
    };
  }
}
