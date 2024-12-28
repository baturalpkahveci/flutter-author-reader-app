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

      body: ListView(
        children: [
          _bookDetailsSection(),
          const SizedBox(height: 20),
          _actionButtonsSection(),
          const SizedBox(height: 20),
          _summarySection(),
          const SizedBox(height: 20),
          _commentsSection(),
        ],
      ),
    );
  }

  Padding _summarySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          _summaryHeader(),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor.withOpacity(0.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                  spreadRadius: 8,
                ),
              ],
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                widget.book.summary,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontFamily: 'liberation_sans',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _summaryHeader() {
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
        'Summary',
        style: TextStyle(
          color: AppColors.primaryColor,
          fontFamily: 'holen_vintage',
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
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
          height: 60,
          width: MediaQuery.of(context).size.width * 0.40,
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
              Row(
                children: [
                  SvgPicture.asset(
                    alignment: Alignment.center,
                    iconPath,
                    color: AppColors.secondaryColor,
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 50,
                    child: Center(
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.secondaryColor,
                          fontFamily: 'holen_vintage',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),
                ],
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
        maxLines: 4,
        minLines: 1,
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
          suffixIcon: Icon(
            Icons.arrow_circle_right_outlined,
            color: AppColors.highlightColor,
            size: 30,
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
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 70,
                    child: Text(
                      widget.book.title,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: 'holen_vintage',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.30,
                height: MediaQuery.of(context).size.width * 0.40,
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
                  _detailText(DateFormat('dd/MM/yyyy').format(widget.book.publishedDate)),
                  _detailText('Rate'),
                  _detailText('Read by: ${widget.book.readCount}'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom:5),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.primaryColor,
          fontFamily: 'liberation_sans',
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        softWrap: true,
      ),
    );
  }
}
