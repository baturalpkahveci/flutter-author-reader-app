import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_author_reader_app/common/widgets/book_box.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_author_reader_app/models/category.dart';
import 'package:flutter_author_reader_app/providers/book_provider.dart';
import 'package:provider/provider.dart';

class BooksPage extends StatefulWidget {
  final Category category;

  const BooksPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  String _selectedOrder = 'Title'; // Default selected order
  final List<String> _orderOptions = ['Title', 'Author', 'Date Added']; // Available order options

  @override
  Widget build(BuildContext context) {
    var bookProvider = Provider.of<BookProvider>(context);
    bookProvider.fetchBooksByCategory(widget.category.id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.highlightColor,
        title: Text(
          widget.category.name,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'holen_vintage',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: bookProvider.books.isEmpty
          ? const Center(
        child: Text(
          "No books available.",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor
          ),
        ),
      )
          : _booksSection(context, bookProvider),
    );
  }

  Widget _booksSection(BuildContext context, BookProvider bookProvider) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Books',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontFamily: 'holen_vintage',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _orderDropdown(),
            ],
          ),
        ),
        const SizedBox(height: 5),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 15,
            childAspectRatio: 2,
          ),
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.all(15),
          itemCount: bookProvider.books.length,
          itemBuilder: (context, index) {
            return BookBox(
              book: bookProvider.books[index],
            );
          },
        ),
      ],
    );
  }

  Widget _orderDropdown() {
    return IntrinsicWidth(
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 8,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton<String>(
          isExpanded: true,
          value: _selectedOrder,
          items: _orderOptions.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(
                option,
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontFamily: 'liberation_sans',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedOrder = value!;
              _applySorting(); // Apply sorting based on the selected order
            });
          },
          icon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.primaryColor,
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(8),
          underline: Container(),
        ),
      ),
    );
  }

  void _applySorting() {
    var bookProvider = Provider.of<BookProvider>(context, listen: false);

    switch (_selectedOrder) {
      case 'Title':
        bookProvider.sortBooksByTitle();
        break;
      case 'Author':
        bookProvider.sortBooksByAuthor();
        break;
      case 'Date Added':
        bookProvider.sortBooksByDateAdded();
        break;
    }
  }
}
