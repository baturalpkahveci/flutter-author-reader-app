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
        child: Row(
          children: [
            const SizedBox(width: 15),
            _buildBookImage(),
            const SizedBox(width: 15),
            _buildBookInfo(),
            const Spacer(),
            _buildRating(),
          ],
        ),
      ),
    );
  }

  Widget _buildBookImage() {
    return Container(
      width: 120,
      height: 160,
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
    );
  }

  Widget _buildBookInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            book.title,
            style: const TextStyle(
              color: AppColors.highlightColor,
              fontFamily: 'holen_vintage',
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          book.authorId,
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontFamily: 'liberation_sans',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        if (book.categoryName != null)
          Text(
            book.categoryName!,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontFamily: 'liberation_sans',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        const SizedBox(height: 10),
        Container(
          width: 150,
          height: 90,
          color: Colors.white,
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

  Widget _buildRating() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10),
      child: Container(
        width: 50,
        height: 30,
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
        child: const Center(
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
      ),
    );
  }
}
