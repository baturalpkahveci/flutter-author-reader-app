import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/models/category.dart';
import 'package:flutter_author_reader_app/services/category_service.dart';

class CategoryProvider with ChangeNotifier {
  final CategoryService _categoryService = CategoryService();
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  set categories(List<Category> categories) {
    _categories = categories;
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    try {
      _categories = await _categoryService.fetchCategories();
      notifyListeners();
    } catch (e) {
      print('Failed to fetch categories: $e');
    }
  }
}
