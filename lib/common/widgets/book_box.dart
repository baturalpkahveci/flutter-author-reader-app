import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_author_reader_app/models/book.dart';
import 'package:flutter_author_reader_app/pages/book_details.dart';

class BookBox extends StatelessWidget {
  final Book book;

  static const defaultImagePath = 'assets/images/book-image-example.jpg';

  const BookBox({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigating to BookDetailsPage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookDetailsPage(book: book),)
        );
        print('Book tapped: ${book.title}');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildBookImage(context),
                  const SizedBox(width: 10),
                  _buildBookInfo(context),
                  //_buildRating(),
                ],
              ),
            ],
          ),
      ),
    );
  }

  Column _buildBookImage(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.30,
          height: MediaQuery.of(context).size.width * 0.40,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 10,
              ),
            ],
            image: DecorationImage(
              image: AssetImage(defaultImagePath),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xffFBFBFb),
              width: 2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.40,
              height: MediaQuery.of(context).size.width * 0.20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                      color: AppColors.highlightColor,
                      fontFamily: 'holen_vintage',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    book.authorId,
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: 'liberation_sans',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (book.categoryName != null)
                    Text(
                      book.categoryName!,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: 'liberation_sans',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            _builtRating(context),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.55,
          height: MediaQuery.of(context).size.width * 0.20,
          child: Text(
            book.summary,
            style: TextStyle(
              fontFamily: 'liberation_sans',
              fontSize: 12,
              color: AppColors.primaryColor.withOpacity(0.4),
              fontWeight: FontWeight.w500,
            ),
            softWrap: true,
            overflow: TextOverflow.fade,
          ),
        ),
      ],
    );
  }

  Container _builtRating(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.width * 0.10,
      decoration: BoxDecoration(
        color: AppColors.highlightColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Center(
        child: Text(
          "3.5", // TODO: Replace with actual rating value
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'holen_vintage',
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
