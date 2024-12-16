import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';

class CommentBox extends StatelessWidget {
  final String userName;
  final DateTime date;
  final String comment;

  const CommentBox({
    Key? key,
    required this.userName,
    required this.date,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Name and Date
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: 'liberation_sans',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${date.day}/${date.month}/${date.year}',
                      style: TextStyle(
                        color: AppColors.primaryColor.withOpacity(0.6),
                        fontFamily: 'liberation_sans',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Comment text box
                Container(
                  constraints: BoxConstraints(
                    maxWidth: double.infinity,  // Ensures the container expands to fit text
                  ),
                  child: Text(
                    comment,
                    style: TextStyle(
                      fontFamily: 'liberation_sans',
                      fontSize: 14,
                      color: AppColors.primaryColor.withOpacity(0.8),
                      fontWeight: FontWeight.w400,
                    ),
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
