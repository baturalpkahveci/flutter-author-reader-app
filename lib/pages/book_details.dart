import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_author_reader_app/common/widgets/book_box.dart';
import 'package:flutter_author_reader_app/common/widgets/genre_box.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookDetailsPage extends StatefulWidget  {
  void Function(bool) visibilityFunction;

  BookDetailsPage({super.key, required this.visibilityFunction}){

  }

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
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
            _addingButtons(),
          ],
        ),
      ),
    );
  }

  Padding _addingButtons() {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle the button tap event here.
                    print('"Add to favorites" button tapped!');
                  },
                  child: Container(
                    height: 70,
                    width: 165,
                    decoration: BoxDecoration(
                      color: AppColors.highlightColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/add-to-queue-svgrepo-com.svg',
                            color: AppColors.secondaryColor,
                          ),
                          SizedBox(width: 10,),
                          Text(
                            'Add to\nFavorites',
                            style: TextStyle(
                              color: AppColors.secondaryColor,
                              fontFamily: 'holen_vintage',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle the button tap event here.
                    print('"Add to a Reading List" button tapped!');
                  },
                  child: Container(
                    height: 70,
                    width: 165,
                    decoration: BoxDecoration(
                      color: AppColors.highlightColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/add-to-queue-svgrepo-com.svg',
                            color: AppColors.secondaryColor,
                          ),
                          SizedBox(width: 10,),
                          Text(
                            'Add to a\nReading List',
                            style: TextStyle(
                              color: AppColors.secondaryColor,
                              fontFamily: 'holen_vintage',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
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
                    RichText(
                      text: TextSpan(
                        text: 'Book Name',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontFamily: 'holen_vintage',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
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
                            'Author Name',
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