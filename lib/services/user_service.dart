import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_author_reader_app/models/firestore_user.dart';
import 'package:flutter_author_reader_app/models/reading_list_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_author_reader_app/utils/keyword_utils.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Generate and sets keywords for searching
  Future<void> generateAndSetUserKeywords(String userId) async {
    final FirestoreUser? currentUser = await fetchCurrentUser();

    if (currentUser == null) {
      throw "Current user is null.";
    }

    var keywords = generateSubstrings(currentUser.username);

    await FirebaseFirestore.instance.collection('users').doc(currentUser.id).update({
      'keywords': keywords,
    });
  }

  /// Searches users by username keywords.
  Future<List<FirestoreUser>> searchUsers(String query) async {
    try {
      if (query.isEmpty) return [];

      final lowerQuery = query.toLowerCase();

      // Generate possible substrings to search for
      final List<String> queryParts = generateSubstrings(lowerQuery);

      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('keywords', arrayContainsAny: queryParts.take(10).toList()) // Max 10 elements
          .limit(20) // Prevent fetching too many documents
          .get();

      // Further refine results to ensure full substring matching
      final users = snapshot.docs
          .where((doc) {
        final keywords = List<String>.from(doc['keywords']);
        return keywords.any((keyword) => keyword.contains(lowerQuery));
      })
          .map((doc) => FirestoreUser.fromFirestore(doc.id, doc.data()))
          .toList();

      return users;
    } catch (e) {
      print('Failed to search users: $e');
      return [];
    }
  }

  Future<FirestoreUser?> fetchCurrentUser() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) return null;
    return await fetchUser(firebaseUser.uid);
  }

  /// Fetches a user by their ID.
  Future<FirestoreUser?> fetchUser(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return FirestoreUser.fromFirestore(doc.id, doc.data()!);
      }
    } catch (e) {
      print('Error fetching user: $e');
    }
    return null;
  }

  /// Adds a new user to Firestore.
  Future<void> addUser(FirestoreUser user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toFirestore());
      generateAndSetUserKeywords(user.id);
      print('User added successfully.');
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  /// Updates a specific field for a user.
  Future<void> updateUserField(String userId, String field, dynamic value) async {
    try {
      await _firestore.collection('users').doc(userId).update({field: value});
      generateAndSetUserKeywords(userId);
      print('User field updated successfully.');
    } catch (e) {
      print('Error updating user field: $e');
    }
  }

  /// Updates the specified user's data in Firestore with the provided `User` object.
  Future<void> updateUser(FirestoreUser user) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.id)
          .update(user.toFirestore());
      generateAndSetUserKeywords(user.id);
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  /// Deletes a user from Firestore.
  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
      print('User deleted successfully.');
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  /// Fetches the reading list for a user.
  Future<List<ReadingListItem>> fetchReadingList(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('reading_list')
          .get();

      return snapshot.docs
          .map((doc) => ReadingListItem.fromFirestore(doc.id, doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching reading list: $e');
      return [];
    }
  }

  /// Adds a book to the user's reading list.
  Future<void> addToReadingList(String userId, ReadingListItem item) async {
    try {
      final userDoc = _firestore.collection('users').doc(userId);
      var readingListSnapshot = await userDoc.collection('reading_list').get();
      if (readingListSnapshot.docs.isEmpty) {
        await userDoc.collection('reading_list').doc(item.id).set(item.toFirestore());
      } else {
        await userDoc.collection('reading_list').doc(item.id).set(item.toFirestore());
      }
      print('Book added to reading list.');
    } catch (e) {
      print('Error adding to reading list: $e');
    }
  }

  /// Updates a reading list item's status or rating.
  Future<void> updateReadingListItem(String userId, String itemId, Map<String, dynamic> updates) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('reading_list')
          .doc(itemId)
          .update(updates);
      print('Reading list item updated.');
    } catch (e) {
      print('Error updating reading list item: $e');
    }
  }

  /// Removes a book from the user's reading list.
  Future<void> removeFromReadingList(String userId, String itemId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('reading_list')
          .doc(itemId)
          .delete();
      print('Book removed from reading list.');
    } catch (e) {
      print('Error removing from reading list: $e');
    }
  }
}
