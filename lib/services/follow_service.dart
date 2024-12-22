import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_author_reader_app/models/follow.dart';

class FollowService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Send a follow request to another user.
  Future<void> sendFollowRequest(String currentUserId, String targetUserId) async {
    try {
      final timestamp = DateTime.now();

      // Add to current user's "follow_requests" subcollection.
      await _firestore
          .collection('users')
          .doc(targetUserId)
          .collection('follow_requests')
          .doc(currentUserId)
          .set(FollowRequest(userId: currentUserId, status: 'pending', requestedAt: timestamp).toFirestore());

      print('Follow request sent.');
    } catch (e) {
      print('Error sending follow request: $e');
    }
  }

  /// Accept a follow request from a user.
  Future<void> acceptFollowRequest(String currentUserId, String targetUserId) async {
    try {
      final timestamp = DateTime.now();

      // Add to current user's "following" subcollection.
      await _firestore
          .collection('users')
          .doc(currentUserId)
          .collection('following')
          .doc(targetUserId)
          .set(Follow(userId: targetUserId, followedAt: timestamp).toFirestore());

      // Add to target user's "followers" subcollection.
      await _firestore
          .collection('users')
          .doc(targetUserId)
          .collection('followers')
          .doc(currentUserId)
          .set(Follow(userId: currentUserId, followedAt: timestamp).toFirestore());

      // Update the follow request status to "accepted".
      await _firestore
          .collection('users')
          .doc(targetUserId)
          .collection('follow_requests')
          .doc(currentUserId)
          .update({'status': 'accepted'});

      print('Follow request accepted.');
    } catch (e) {
      print('Error accepting follow request: $e');
    }
  }

  /// Reject a follow request.
  Future<void> rejectFollowRequest(String currentUserId, String targetUserId) async {
    try {
      // Remove from target user's "follow_requests" subcollection.
      await _firestore
          .collection('users')
          .doc(targetUserId)
          .collection('follow_requests')
          .doc(currentUserId)
          .delete();

      print('Follow request rejected.');
    } catch (e) {
      print('Error rejecting follow request: $e');
    }
  }

  /// Get the pending follow requests for a user.
  Future<List<FollowRequest>> getFollowRequests(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('follow_requests')
          .where('status', isEqualTo: 'pending')
          .get();

      return snapshot.docs
          .map((doc) => FollowRequest.fromFirestore(doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching follow requests: $e');
      return [];
    }
  }

  /// Get the following list of a user.
  Future<List<Follow>> getFollowing(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('following')
          .get();

      return snapshot.docs
          .map((doc) => Follow.fromFirestore(doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching following list: $e');
      return [];
    }
  }

  /// Get the followers list of a user.
  Future<List<Follow>> getFollowers(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('followers')
          .get();

      return snapshot.docs
          .map((doc) => Follow.fromFirestore(doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching followers list: $e');
      return [];
    }
  }
}
