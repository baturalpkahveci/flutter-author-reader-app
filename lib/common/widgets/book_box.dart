import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/common/widgets/genre_box.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_author_reader_app/pages/books.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookBox extends StatelessWidget {
  final String name;
  final String authorName;
  final String genreName;
  final double rate;
  final String imagePath;

  const BookBox({
    Key? key,
    required this.name,
    required this.authorName,
    required this.genreName,
    required this.rate,
    required this.imagePath,
  })  : super(key: key);

  @override
  Widget build(BuildContext context)  {
    return GestureDetector(
      onTap: () {
        // Handle the tap event here.
        print('Book tapped: $name');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 15,),
            Container(
              width: 120,
              height: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xffFBFBFb),
                  width: 2,
                ),
              ),
            ),
            SizedBox(width: 15,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: AppColors.highlightColor,
                      fontFamily: 'holen_vintage',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  authorName,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontFamily: 'liberation_sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  genreName,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontFamily: 'liberation_sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 150,
                  height: 90,
                  color: Colors.white,
                  child: RichText(
                    overflow: TextOverflow.fade,
                    text: TextSpan(
                      text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                      style: TextStyle(
                        fontFamily: 'liberation_sans',
                        fontSize: 12,
                        color: AppColors.primaryColor.withOpacity(0.4),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    softWrap: true,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10),
                  child: Container(
                    width: 50,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.highlightColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        (rate).toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'holen_vintage',
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
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