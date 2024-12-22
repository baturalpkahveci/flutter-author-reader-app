import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/models/follow.dart';
import 'package:flutter_author_reader_app/services/follow_service.dart';

class FollowProvider with ChangeNotifier {
  final FollowService _followService = FollowService();

  List<Follow> _following = [];
  List<Follow> _followers = [];
  List<FollowRequest> _followRequests = [];

  List<Follow> get following => _following;
  List<Follow> get followers => _followers;
  List<FollowRequest> get followRequests => _followRequests;

  Future<void> fetchFollowing(String userId) async {
    try {
      _following = await _followService.getFollowing(userId);
      notifyListeners();
    } catch (e) {
      print('Error fetching following list: $e');
    }
  }

  Future<void> fetchFollowers(String userId) async {
    try {
      _followers = await _followService.getFollowers(userId);
      notifyListeners();
    } catch (e) {
      print('Error fetching followers list: $e');
    }
  }

  Future<void> fetchFollowRequests(String userId) async {
    try {
      _followRequests = await _followService.getFollowRequests(userId);
      notifyListeners();
    } catch (e) {
      print('Error fetching follow requests: $e');
    }
  }

  Future<void> sendFollowRequest(String currentUserId, String targetUserId) async {
    try {
      await _followService.sendFollowRequest(currentUserId, targetUserId);
      await fetchFollowRequests(targetUserId); // Refresh requests
    } catch (e) {
      print('Error sending follow request: $e');
    }
  }

  Future<void> acceptFollowRequest(String currentUserId, String targetUserId) async {
    try {
      await _followService.acceptFollowRequest(currentUserId, targetUserId);
      await fetchFollowRequests(targetUserId); // Refresh requests
      await fetchFollowers(currentUserId);     // Refresh followers
      await fetchFollowing(currentUserId);     // Refresh following
    } catch (e) {
      print('Error accepting follow request: $e');
    }
  }

  Future<void> rejectFollowRequest(String currentUserId, String targetUserId) async {
    try {
      await _followService.rejectFollowRequest(currentUserId, targetUserId);
      await fetchFollowRequests(targetUserId); // Refresh requests
    } catch (e) {
      print('Error rejecting follow request: $e');
    }
  }
}
