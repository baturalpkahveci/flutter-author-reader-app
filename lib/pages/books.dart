import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_author_reader_app/common/widgets/book_box.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_author_reader_app/models/category.dart';
import 'package:flutter_author_reader_app/pages/book_details.dart';
import 'package:flutter_author_reader_app/providers/book_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_author_reader_app/models/book.dart';

class BooksPage extends StatefulWidget {
  final Category category;
  final bool isBookDetailsPageOpen;
  final void Function(bool) visibilityFunction;
  final void Function(bool) detailsVisibilityFunction;

  BooksPage({
    super.key,
    required this.category,
    required this.visibilityFunction,
    required this.detailsVisibilityFunction,
    this.isBookDetailsPageOpen = false,
  });

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  String _selectedOrder = 'Book Name (A-Z)';
  Book? lastSelectedBook;

  final List<String> _orderOptions = [
    'Book Name (A-Z)',
    'Book Name (Z-A)',
    'Author Name (A-Z)',
    'Author Name (Z-A)',
    'Highest Rate First',
    'Lowest Rate First',
    'Most Read First',
    'Least Read First',
  ];

  void setBookDetailsPageVisibility(bool isOpen) {
    setState(() {
      widget.detailsVisibilityFunction(isOpen);
    });
  }

  void setSelectedBook(Book book) {
    setState(() {
      lastSelectedBook = book;
    });
    print("Last selected book: ${lastSelectedBook?.title}");
  }

  @override
  Widget build(BuildContext context) {
    var bookProvider = Provider.of<BookProvider>(context);
    bookProvider.fetchBooksByCategory(widget.category.id);

    return WillPopScope(
      onWillPop: () async {
        if (widget.isBookDetailsPageOpen) {
          setBookDetailsPageVisibility(false);
        } else {
          widget.visibilityFunction(false);
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: widget.isBookDetailsPageOpen
            ? (lastSelectedBook != null
            ? BookDetailsPage(
          book: lastSelectedBook!,
          visibilityFunction: widget.detailsVisibilityFunction,
          setSelectedBookFunction: setSelectedBook,
        )
            : Center(
          child: Text(
            'The book could not be found.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ))
            : ListView(
          children: [
            _booksSection(bookProvider),
          ],
        ),
      ),
    );
  }

  Column _booksSection(BookProvider bookProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Books',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontFamily: 'holen_vintage',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IntrinsicWidth(
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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButton(
                    isExpanded: true,
                    value: _selectedOrder,
                    items: _orderOptions.map((option) {
                      return DropdownMenuItem(
                        value: option,
                        child: Text(
                          option,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: 'liberation_sans',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 20,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedOrder = value as String;
                      });
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/arrow-drop-down-big-svgrepo-com.svg',
                      width: 15,
                      height: 15,
                      color: AppColors.primaryColor,
                    ),
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    underline: Container(),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 5),
        Container(
          child: bookProvider.books.isEmpty
              ? Center(
            child: Text(
              "No books available.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          )
              : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 15,
              childAspectRatio: 2,
            ),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            padding: EdgeInsets.all(15),
            itemCount: bookProvider.books.length,
            itemBuilder: (context, index) {
              return BookBox(
                book: bookProvider.books[index],
                bookDetailsPageVisibilityFunction: setBookDetailsPageVisibility,
                setSelectedBookFunction: setSelectedBook,
              );
            },
          ),
        ),
      ],
    );
  }
}

