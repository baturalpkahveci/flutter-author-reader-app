import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_author_reader_app/common/widgets/book_box.dart';
import 'package:flutter_author_reader_app/common/widgets/comment_box.dart';
import 'package:flutter_author_reader_app/common/widgets/genre_box.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_author_reader_app/models/book.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookDetailsPage extends StatefulWidget  {
  final Book book;
  void Function(bool) visibilityFunction;
  void Function(Book) setSelectedBookFunction;

  BookDetailsPage({
    super.key,
    required this.book,
    required this.visibilityFunction,
    required this.setSelectedBookFunction
  });

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  String exampleComment1 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  @override
  Widget build(BuildContext context)  {
    return WillPopScope(
      onWillPop: () async {
        widget.visibilityFunction(false);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: ListView(
          children: [
            _bookDetailsSection(),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aralık ekler
                    children: [
                      // "Add to Favorites" button
                      _addToFavoritesButton(),
                      SizedBox(width: 15), // Buttons arasında boşluk
                      // "Add to a Reading List" button
                      _addToListButton(),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            _commentsSection(),
          ],
        ),
      ),
    );
  }

  Flexible _addToListButton() {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          // Handle the tap event here.
          print('"Add to a Reading List" button tapped!');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          height: 80,
          width: 160,
          decoration: BoxDecoration(
            color: AppColors.highlightColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 8,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // İçeriğe göre genişlik
            children: [
              SvgPicture.asset(
                'assets/icons/add-to-queue-svgrepo-com.svg',
                color: AppColors.secondaryColor,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  'Add to a List',
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontFamily: 'holen_vintage',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Flexible _addToFavoritesButton() {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          // Handle the tap event here.
          print('"Add to favorites" button tapped!');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          height: 80,
          width: 160,
          decoration: BoxDecoration(
            color: AppColors.highlightColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 8,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // İçeriğe göre genişlik
            children: [
              SvgPicture.asset(
                'assets/icons/favorite-svgrepo-com.svg',
                color: AppColors.secondaryColor,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  'Add to Favorites',
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontFamily: 'holen_vintage',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _commentsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Container(
            height: 60,
            width: double.infinity, // Ensures it stretches fully within constraints
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 8,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 20,),
              child: Text(
                'Comments',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontFamily: 'holen_vintage',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 8,
                ),
              ],
            ),
            child: const TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(15),
                  hintText: 'Share your thoughts with others...',
                  hintStyle: TextStyle(
                    color: AppColors.primaryColor,
                    fontFamily: 'liberation_sans',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.zero,
                    ),
                    borderSide: BorderSide.none,
                  )
              ),
            ),
          ),
          Container(
            height: 400, // set it to double.minPositive later.
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 8,
                ),
              ],
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: Container(
              child: GridView.count(
                crossAxisCount: 1,
                mainAxisSpacing: 15,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                padding: EdgeInsets.all(15),
                children: [
                  // Add comment boxes here.
                  CommentBox(
                      userName: 'User Name1',
                      date: DateTime(2004,11,23),
                      comment: exampleComment1
                  ),
                  CommentBox(
                      userName: 'User Name1',
                      date: DateTime(2004,11,23),
                      comment: exampleComment1
                  ),
                  CommentBox(
                      userName: 'User Name1',
                      date: DateTime(2004,11,23),
                      comment: exampleComment1
                  ),
                  CommentBox(
                      userName: 'User Name1',
                      date: DateTime(2004,11,23),
                      comment: exampleComment1
                  ),CommentBox(
                      userName: 'User Name1',
                      date: DateTime(2004,11,23),
                      comment: exampleComment1
                  ),CommentBox(
                      userName: 'User Name1',
                      date: DateTime(2004,11,23),
                      comment: exampleComment1
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _bookDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child:  Row(
            children: [
              Text(
                widget.book.title,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontFamily: 'holen_vintage',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                softWrap: true,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Row(
                children: [
                  Container(
                    width: 135,
                    height: 180,
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 10,
                      ),],
                      image: DecorationImage(
                        image: AssetImage('assets/images/book-image-example.jpg'),  // Take this information from db later.
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color(0xffFBFBFb),
                        width: 2,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(  // Take this information from db later.
                      widget.book.authorId,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: 'liberation_sans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(  // Take this information from db later.
                      'Genre Name',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: 'liberation_sans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(  // Take this information from db later.
                      'Published At',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: 'liberation_sans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(  // Take this information from db later.
                      'Rate',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: 'liberation_sans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(  // Take this information from db later.
                      'Reads Count',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: 'liberation_sans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}