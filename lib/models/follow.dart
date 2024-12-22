import 'package:cloud_firestore/cloud_firestore.dart';

class FollowRequest {
  final String userId;
  final String status;
  final DateTime requestedAt;

  FollowRequest({required this.userId, required this.status, required this.requestedAt});

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'status': status,
      'requested_at': requestedAt.toUtc(),
    };
  }

  static FollowRequest fromFirestore(Map<String, dynamic> data) {
    return FollowRequest(
      userId: data['userId'],
      status: data['status'],
      requestedAt: (data['requested_at'] as Timestamp).toDate(),
    );
  }
}

class Follow {
  final String userId;
  final DateTime followedAt;

  Follow({required this.userId, required this.followedAt});

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'followed_at': followedAt.toUtc(),
    };
  }

  static Follow fromFirestore(Map<String, dynamic> data) {
    return Follow(
      userId: data['userId'],
      followedAt: (data['followed_at'] as Timestamp).toDate(),
    );
  }
}
