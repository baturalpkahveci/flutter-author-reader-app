import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/common/widgets/genre_box.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_author_reader_app/pages/books.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenresPage extends StatefulWidget  {
  const GenresPage({super.key});

  @override
  State<GenresPage> createState() => _GenresPageState();
}

class _GenresPageState extends State<GenresPage> {
  bool isBooksPageOpen = false;
  String selectedGenre = "";

  void setBooksPageVisibility(bool isOpen){
    setState(() {
      isBooksPageOpen = isOpen;
    });
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: isBooksPageOpen ? BooksPage(visibilityFunction: setBooksPageVisibility) : ListView(
        children: [
          _searchField(),
          SizedBox(height:10,),
          _genresSection(),
        ]
      ),
    );
  }

  Container _searchField() {
    return Container(
      margin: EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black54.withOpacity(0.10),
              blurRadius: 40,
              spreadRadius: 10.0,
            )
          ]
      ),
      child: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(15),
            hintText: 'Search for a book or author',
            hintStyle: TextStyle(
              fontFamily: 'liberation_sans',
              color: Color(0xffDDDADA),
              fontSize: 15,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                'assets/icons/search-alt-2-svgrepo-com.svg',
                color: Color(0xffDDDADA),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            )
        ),
      ),
    );
  }

  Column _genresSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Genres',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontFamily: 'liberation_sans',
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5,),
        Container(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            padding: EdgeInsets.all(15),
            children: [
              // Add genre boxes here.
              GenreBox(
                  name: 'Genre1',
                  iconPath:'assets/icons/book-svgrepo-com.svg',
                  booksPageVisibilityFunction: setBooksPageVisibility
              ),
              GenreBox(
                  name: 'Genre2',
                  iconPath:'assets/icons/book-svgrepo-com.svg',
                  booksPageVisibilityFunction: setBooksPageVisibility
              ),
              GenreBox(
                  name: 'Genre3',
                  iconPath:'assets/icons/book-svgrepo-com.svg',
                  booksPageVisibilityFunction: setBooksPageVisibility
              ),
              GenreBox(
                  name: 'Genre4',
                  iconPath:'assets/icons/book-svgrepo-com.svg',
                  booksPageVisibilityFunction: setBooksPageVisibility
              ),
              GenreBox(
                  name: 'Genre5',
                  iconPath:'assets/icons/book-svgrepo-com.svg',
                  booksPageVisibilityFunction: setBooksPageVisibility
              ),
              GenreBox(
                  name: 'Genre6',
                  iconPath:'assets/icons/book-svgrepo-com.svg',
                  booksPageVisibilityFunction: setBooksPageVisibility
              ),
              GenreBox(
                  name: 'Genre7',
                  iconPath:'assets/icons/book-svgrepo-com.svg',
                  booksPageVisibilityFunction: setBooksPageVisibility
              ),
              GenreBox(
                  name: 'Genre8',
                  iconPath:'assets/icons/book-svgrepo-com.svg',
                  booksPageVisibilityFunction: setBooksPageVisibility
              ),
              GenreBox(
                  name: 'Genre9',
                  iconPath:'assets/icons/book-svgrepo-com.svg',
                  booksPageVisibilityFunction: setBooksPageVisibility
              ),
            ],
          ),
        ),
      ],
    );
  }
}