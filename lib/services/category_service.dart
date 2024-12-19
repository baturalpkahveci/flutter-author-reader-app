import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_author_reader_app/models/category.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetches all categories.
  Future<List<Category>> fetchCategories() async {
    try {
      final snapshot = await _firestore.collection('categories').get();
      return snapshot.docs
          .map((doc) => Category.fromFirestore(doc.id, doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }

  /// Adds a new category to Firestore.
  Future<void> addCategory(Category category) async {
    try {
      await _firestore
          .collection('categories')
          .doc(category.id)
          .set(category.toFirestore());
      print('Category added successfully.');
    } catch (e) {
      print('Error adding category: $e');
    }
  }

  /// Updates a category's fields.
  Future<void> updateCategoryField(String categoryId, String field, dynamic value) async {
    try {
      await _firestore.collection('categories').doc(categoryId).update({field: value});
      print('Category updated successfully.');
    } catch (e) {
      print('Error updating category: $e');
    }
  }

  /// Deletes a category from Firestore.
  Future<void> deleteCategory(String categoryId) async {
    try {
      await _firestore.collection('categories').doc(categoryId).delete();
      print('Category deleted successfully.');
    } catch (e) {
      print('Error deleting category: $e');
    }
  }
}
