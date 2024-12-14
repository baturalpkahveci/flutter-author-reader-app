import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/common/widgets/book_box.dart';
import 'package:flutter_author_reader_app/common/widgets/genre_box.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BooksPage extends StatefulWidget {
  String bookCategory = "All Books";
  void Function(bool) visibilityFunction;

  BooksPage({super.key, String? bookCategory, required this.visibilityFunction}) {
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.visibilityFunction(false);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Books',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontFamily: 'liberation_sans',
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownMenu(
                          menuStyle: MenuStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            surfaceTintColor: MaterialStateProperty.all(Colors.white),
                            elevation: MaterialStateProperty.all(8),
                          ),
                          initialSelection: _selectedOrder,
                          onSelected: (String? value) {
                            if(value != null) {
                              setState(() {
                                _selectedOrder = value;
                              });
                            }
                            print('Sorting books by: $_selectedOrder.');
                          },
                          dropdownMenuEntries: _orderOptions.map((option) {
                            return DropdownMenuEntry(
                              value: option,
                              label: option,
                            );
                          }).toList(),
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
                          imagePath: 'assets/images/book-image-example.jpg'
                      ),
                      BookBox(
                          name: 'Book2',
                          authorName: 'Author Name',
                          genreName: 'Genre Name',
                          rate: 3.5,
                          imagePath: 'assets/images/book-image-example.jpg'
                      ),
                      BookBox(
                          name: 'Book3',
                          authorName: 'Author Name',
                          genreName: 'Genre Name',
                          rate: 3.5,
                          imagePath: 'assets/images/book-image-example.jpg'
                      ),
                      BookBox(
                          name: 'Book4',
                          authorName: 'Author Name',
                          genreName: 'Genre Name',
                          rate: 3.5,
                          imagePath: 'assets/images/book-image-example.jpg'
                      ),
                      BookBox(
                          name: 'Book5',
                          authorName: 'Author Name',
                          genreName: 'Genre Name',
                          rate: 3.5,
                          imagePath: 'assets/images/book-image-example.jpg'
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Other Genres',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: 'liberation_sans',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // ADD OTHER GENRES PART HERE.
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
