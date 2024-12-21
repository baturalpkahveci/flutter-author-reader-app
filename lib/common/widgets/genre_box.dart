import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_author_reader_app/models/category.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenreBox extends StatelessWidget {
  final Category category;
  final String iconPath;
  final void Function(bool) booksPageVisibilityFunction;
  final void Function(Category) setCategoryFunction;

  const GenreBox({
    Key? key,
    required this.category,
    required this.iconPath,
    required this.booksPageVisibilityFunction,
    required this.setCategoryFunction
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Genre tapped: ${category.name}');
        setCategoryFunction(category);
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
                category.name,
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
