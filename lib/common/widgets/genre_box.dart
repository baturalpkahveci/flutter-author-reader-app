import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_author_reader_app/pages/books.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenreBox extends StatelessWidget {
  final String name;
  final String iconPath;
  final void Function(bool) booksPageVisibilityFunction;

  const GenreBox({
    Key? key,
    required this.name,
    required this.iconPath,
    required this.booksPageVisibilityFunction
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle the tap event here.
        print('Genre tapped: $name');
        booksPageVisibilityFunction(true);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        padding: EdgeInsets.only(top: 20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensures content stays compact
            children: [
              SvgPicture.asset(
                iconPath,
                width: 50, // Adjust SVG size as needed
                height: 50,
              ),
              SizedBox(height: 10), // Space between icon and text
              Text(
                name,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontFamily: 'liberation_sans',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
