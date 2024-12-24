import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/common/widgets/comment_box.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_author_reader_app/models/book.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class BookDetailsPage extends StatefulWidget {
  final Book book;

  const BookDetailsPage({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  final String exampleComment =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          widget.book.title,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'holen_vintage',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          _bookDetailsSection(),
          const SizedBox(height: 20),
          _actionButtonsSection(),
          const SizedBox(height: 20),
          _commentsSection(),
        ],
      ),
    );
  }

  Widget _actionButtonsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _actionButton(
            label: 'Add to Favorites',
            iconPath: 'assets/icons/favorite-svgrepo-com.svg',
            onTap: () {
              // Handle adding to favorites
              print('Add to Favorites tapped!');
            },
          ),
          const SizedBox(width: 15),
          _actionButton(
            label: 'Add to a List',
            iconPath: 'assets/icons/add-to-queue-svgrepo-com.svg',
            onTap: () {
              // Handle adding to a list
              print('Add to a List tapped!');
            },
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required String label,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.highlightColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 8,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconPath,
                color: AppColors.secondaryColor,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.secondaryColor,
                    fontFamily: 'holen_vintage',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _commentsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          _commentsHeader(),
          _commentsInputField(),
          _commentsList(),
        ],
      ),
    );
  }

  Widget _commentsHeader() {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            spreadRadius: 8,
          ),
        ],
      ),
      padding: const EdgeInsets.only(left: 15, top: 20),
      child: const Text(
        'Comments',
        style: TextStyle(
          color: AppColors.primaryColor,
          fontFamily: 'holen_vintage',
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _commentsInputField() {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            spreadRadius: 8,
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(15),
          hintText: 'Share your thoughts with others...',
          hintStyle: TextStyle(
            color: AppColors.primaryColor,
            fontFamily: 'liberation_sans',
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.zero),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _commentsList() {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            spreadRadius: 8,
          ),
        ],
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: 5,
        itemBuilder: (context, index) {
          return CommentBox(
            userName: 'User $index',
            date: DateTime.now(),
            comment: exampleComment,
          );
        },
      ),
    );
  }

  Widget _bookDetailsSection() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Container(
            width: 135,
            height: 180,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/book-image-example.jpg'),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFFbFbFb), width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                  spreadRadius: 10,
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _detailText(widget.book.authorId),
              _detailText(widget.book.categoryName ?? ''),
              _detailText(DateFormat('dd-MM-yyyy').format(widget.book.publishedDate)),
              _detailText('Rate'),
              _detailText('Read by: ${widget.book.readCount}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.primaryColor,
          fontFamily: 'liberation_sans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
