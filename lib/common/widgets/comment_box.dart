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
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // User Name and Date
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                          ],
                        ),
                        Row(
                          children: [
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
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Handle the tap event here.
                                print('Dislike button tapped!');
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: AppColors.secondaryColor,
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(10),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 20,
                                          spreadRadius: 5,
                                          offset: Offset(-5, 0),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.thumb_down_outlined,
                                      color: AppColors.highlightColor,
                                      size: 20,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '13',
                                        style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 1,),
                            GestureDetector(
                              onTap: () {
                                // Handle the tap event here.
                                print('Like button tapped!');
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: AppColors.secondaryColor,
                                      borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(10),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 20,
                                          spreadRadius: 5,
                                          offset: Offset(5, 0),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.thumb_up_outlined,
                                      color: AppColors.highlightColor,
                                      size: 20,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '31',
                                        style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: AppColors.primaryColor,
                  thickness: 0.2,
                ),
                Column(
                  children: [
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
