import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/common/widgets/genre_box.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BooksPage extends StatelessWidget {
  String bookCategory = "All Books";
  void Function(bool) visibilityFunction;

  BooksPage({super.key , String? bookCategory, required  this.visibilityFunction}){
    this.bookCategory = bookCategory ?? 'All Books';
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () => visibilityFunction(false),
                        icon: Icon(Icons.arrow_back_ios_new)
                    ),
                    Text(
                      'Books',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: 'liberation_sans',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ),
              SizedBox(height: 5,),

            ],
          ),
        ],
      ),
    );
  }
}