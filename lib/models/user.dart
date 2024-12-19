import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String bio;
  final DateTime createdAt;
  final String email;
  final String fullName;
  final String password;
  final String username;

  User({
    required this.id,
    required this.bio,
    required this.createdAt,
    required this.email,
    required this.fullName,
    required this.password,
    required this.username,
  });

  /// Factory method to create a User object from Firestore data.
  factory User.fromFirestore(String id, Map<String, dynamic> data) {
    return User(
      id: id,
      bio: data['bio'] ?? '',
      createdAt: (data['created_at'] as Timestamp).toDate(),
      email: data['email'] ?? '',
      fullName: data['full_name'] ?? '',
      password: data['password'] ?? '',
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
      'password': password,
      'username': username,
    };
  }
}
