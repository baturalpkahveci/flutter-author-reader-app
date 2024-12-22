import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';

class ListMemberBox extends StatelessWidget {
  const ListMemberBox({
    Key? key,
  })  : super(key: key);
  
  @override
  Widget build(BuildContext context)  {
    return GestureDetector(
      onTap: () {
        // Handle tap event here.
        print('Book tapped!');
      },
      child: Column(
        children: [
          Container(
            height: 120,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color(0xffFBFBFB),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 10,
                ),
              ],
              image: DecorationImage(
                image: AssetImage('assets/images/book-image-example.jpg'),  // Take this information from db later.
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            height: 20,
            width: 90,
            child: Text(
              'Book Name',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontFamily: 'liberation_sans',
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

