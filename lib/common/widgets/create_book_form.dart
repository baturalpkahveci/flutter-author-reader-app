import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_author_reader_app/services/book_service.dart';
import 'package:flutter_author_reader_app/providers/category_provider.dart';
import 'package:flutter_author_reader_app/models/category.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateBookForm extends StatefulWidget {
  @override
  _CreateBookFormState createState() => _CreateBookFormState();
}

class _CreateBookFormState extends State<CreateBookForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _authorIdController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  DateTime? _publishedDate;
  Category? _selectedCategory; // Store the selected Category model

  // Method to show date picker
  Future<void> _selectPublishedDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2000);
    DateTime lastDate = DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null && pickedDate != _publishedDate) {
      setState(() {
        _publishedDate = pickedDate;
      });
    }
  }

  // Method to handle form submission
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String authorId = _authorIdController.text;
      String title = _titleController.text;
      String? summary = _summaryController.text.isEmpty ? null : _summaryController.text;

      if (_selectedCategory == null) {
        // If no category is selected, show an error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select a category')));
        return;
      }

      // Use the selected category's ID and name
      String categoryId = _selectedCategory!.id;
      String categoryName = _selectedCategory!.name;

      // Call the createNewBook method from BookService
      BookService bookService = BookService();
      await bookService.createNewBook(
        authorId: authorId,
        categoryId: categoryId,
        categoryName: categoryName,
        title: title,
        publishedDate: _publishedDate ?? DateTime.now(),
        summary: summary,
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Book created successfully!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Book'),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _authorIdController,
                  decoration: InputDecoration(labelText: 'Author ID'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an Author ID';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Book Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Book Title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _summaryController,
                  decoration: InputDecoration(labelText: 'Summary (Optional)'),
                ),
                // Category Dropdown
                Consumer<CategoryProvider>(
                  builder: (context, categoryProvider, child) {
                    // Fetch categories if not already loaded
                    if (categoryProvider.categories.isEmpty) {
                      categoryProvider.fetchCategories();
                    }

                    return categoryProvider.categories.isEmpty
                        ? CircularProgressIndicator() // Show loading indicator while categories are loading
                        : DropdownButton<Category>(
                      isExpanded: true,
                      hint: Text('Select Category'),
                      value: _selectedCategory,
                      onChanged: (Category? newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      },
                      items: categoryProvider.categories.map<DropdownMenuItem<Category>>((Category category) {
                        return DropdownMenuItem<Category>(
                          value: category,
                          child: Text(category.name),
                        );
                      }).toList(),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    _publishedDate == null
                        ? 'Select Published Date'
                        : 'Published Date: ${DateFormat('yyyy-MM-dd').format(_publishedDate!)}',
                  ),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () => _selectPublishedDate(context),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Create Book'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
