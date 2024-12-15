import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_author_reader_app/common/widgets/book_box.dart';
import 'package:flutter_author_reader_app/common/widgets/genre_box.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_author_reader_app/pages/book_details.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BooksPage extends StatefulWidget {
  String bookCategory = "All Books";
  final bool isBookDetailsPageOpen;
  final void Function(bool) visibilityFunction;
  final void Function(bool) detailsVisibilityFunction;

  BooksPage({
    super.key,
    String? bookCategory,
    required this.visibilityFunction,
    required this.detailsVisibilityFunction,
    this.isBookDetailsPageOpen = false,
  }) {
    this.bookCategory = bookCategory ?? 'All Books';
  }

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  String _selectedOrder = 'Book Name (A-Z)';

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(widget.isBookDetailsPageOpen)  {
          setBookDetailsPageVisibility(false);
        } else  {
          widget.visibilityFunction(false);
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: widget.isBookDetailsPageOpen
        ? BookDetailsPage(
            visibilityFunction: widget.detailsVisibilityFunction,
          )
        : ListView(
          children: [
            _booksSection(),
          ],
        ),
      ),
    );
  }

  Column _booksSection() {
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
              Container(
                width: 170,
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
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  isExpanded: true,
                  value: _selectedOrder,
                  items: _orderOptions.map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(
                        option,
                        style: TextStyle(
                          color:
                          AppColors.primaryColor,
                          fontFamily: 'liberation_sans',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          shadows: [BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 20,
                          )],
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value)  {
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
            ],
          ),
        ),
        SizedBox(height: 5),
        Container(
          child: GridView.count(
            crossAxisCount: 1,
            mainAxisSpacing: 15,
            childAspectRatio: 2,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            padding: EdgeInsets.all(15),
            children: [
              // Add book boxes here.
              BookBox(
                name: 'Book1',
                authorName: 'Author Name',
                genreName: 'Genre Name',
                rate: 3.5,
                imagePath: 'assets/images/book-image-example.jpg',
                bookDetailsPageVisibilityFunction: (isOpen) {
                  setBookDetailsPageVisibility(isOpen);
                },
              ),
              BookBox(
                name: 'Book2',
                authorName: 'Author Name',
                genreName: 'Genre Name',
                rate: 3.5,
                imagePath: 'assets/images/book-image-example.jpg',
                bookDetailsPageVisibilityFunction: (isOpen) {
                  setBookDetailsPageVisibility(isOpen);
                },
              ),
              BookBox(
                name: 'Book3',
                authorName: 'Author Name',
                genreName: 'Genre Name',
                rate: 3.5,
                imagePath: 'assets/images/book-image-example.jpg',
                bookDetailsPageVisibilityFunction: (isOpen) {
                  setBookDetailsPageVisibility(isOpen);
                },
              ),
              BookBox(
                name: 'Book4',
                authorName: 'Author Name',
                genreName: 'Genre Name',
                rate: 3.5,
                imagePath: 'assets/images/book-image-example.jpg',
                bookDetailsPageVisibilityFunction: (isOpen) {
                  setBookDetailsPageVisibility(isOpen);
                },
              ),
              BookBox(
                name: 'Book5',
                authorName: 'Author Name',
                genreName: 'Genre Name',
                rate: 3.5,
                imagePath: 'assets/images/book-image-example.jpg',
                bookDetailsPageVisibilityFunction: (isOpen) {
                  setBookDetailsPageVisibility(isOpen);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
