import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/common/widgets/genre_box.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_author_reader_app/models/category.dart';
import 'package:flutter_author_reader_app/pages/books.dart';
import 'package:flutter_author_reader_app/providers/category_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_author_reader_app/models/book.dart';

class GenresPage extends StatefulWidget  {
  const GenresPage({super.key});

  @override
  State<GenresPage> createState() => _GenresPageState();
}

class _GenresPageState extends State<GenresPage> {
  bool isBooksPageOpen = false;
  bool isBookDetailsPageOpen = false;
  Category? lastSelectedCategory;

  void setBooksPageVisibility(bool booksPageVisibility){
    setState(() {
      isBooksPageOpen = booksPageVisibility;
      isBookDetailsPageOpen = false;
    });
  }

  void setBookDetailsPageVisibility(bool isOpen){
    setState(() {
      isBookDetailsPageOpen = isOpen;
    });
  }

  void setSelectedCategory(Category category){
    lastSelectedCategory = category;
  }

  @override
  Widget build(BuildContext context)  {
    final categoryProvider = Provider.of<CategoryProvider>(context); //Provider of the category service
    categoryProvider.fetchCategories();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: isBooksPageOpen
        ? BooksPage(
          category: lastSelectedCategory ?? categoryProvider.categories[0],
          visibilityFunction: setBooksPageVisibility,
          detailsVisibilityFunction: setBookDetailsPageVisibility,
          isBookDetailsPageOpen: isBookDetailsPageOpen,
          )
        : ListView(
        children: [
          _searchField(),
          SizedBox(height:10,),
          _genresSection(categoryProvider),
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
              fontWeight: FontWeight.w500,
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

  Column _genresSection(CategoryProvider categoryProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Genres',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontFamily: 'holen_vintage',
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5,),
        Container(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 15, // Horizontal space between items
                mainAxisSpacing: 15, // Vertical space between items
                childAspectRatio: 1, // Aspect ratio of each item
              ),
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              padding: const EdgeInsets.all(15),
              itemCount: categoryProvider.categories.length,
              itemBuilder: (context, index) {
                return GenreBox(
                    category: categoryProvider.categories[index],
                    iconPath: 'assets/icons/book-svgrepo-com.svg',
                    booksPageVisibilityFunction: setBooksPageVisibility,
                    setCategoryFunction: setSelectedCategory,
                );
              },
          )
        ),
      ],
    );
  }
}
