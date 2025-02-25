import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_author_reader_app/pages/book_details.dart';
import 'package:provider/provider.dart';
import 'package:flutter_author_reader_app/providers/search_provider.dart';
import 'package:flutter_author_reader_app/models/book.dart';
import 'package:flutter_author_reader_app/models/firestore_user.dart';

class SearchResultsPage extends StatefulWidget {
  final String query;

  const SearchResultsPage({required this.query, Key? key}) : super(key: key);

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  bool _hasSearched = false;
  String filter = "books"; // "books" or "users"

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_hasSearched && widget.query.isNotEmpty) {
      // Trigger search after the initial build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final searchProvider = Provider.of<SearchProvider>(context, listen: false);
        searchProvider.searchBooks(widget.query);
        searchProvider.searchUsers(widget.query);
        print("Search results for books: ${searchProvider.bookResults}");
        print("Search results for users: ${searchProvider.userResults}");
        setState(() {
          _hasSearched = true; // Ensure this block runs only once
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Search Results',
          style: TextStyle(
            fontFamily: 'holen_vintage',
            color: AppColors.secondaryColor
          ),
        ),
        backgroundColor: AppColors.highlightColor,
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              searchProvider.clearSearchResults();
              setState(() {
                _hasSearched = false;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Results for: "${widget.query}"',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          if (searchProvider.isLoading)
            Center(child: CircularProgressIndicator()),
          if (!searchProvider.isLoading)
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15 ,vertical: 6),
                    child: Row(
                      children: [
                        _filterButton("Books", "books"),
                        SizedBox(width: 10,),
                        _filterButton("Users", "users")
                      ],
                    ),
                  ),
                  if (searchProvider.bookResults.isNotEmpty) ...[
                    BookSearchResults(bookResults: searchProvider.bookResults),
                  ],
                  if (searchProvider.userResults.isNotEmpty) ...[
                    UserSearchResults(userResults: searchProvider.userResults),
                  ],
                  if (searchProvider.bookResults.isEmpty &&
                      searchProvider.userResults.isEmpty)
                    Center(child: Text('No results found')),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _filterButton(String label, String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          filter = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          color: filter == value ? AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: filter == value ? Colors.white : AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class BookSearchResults extends StatelessWidget {
  final List<Book> bookResults;

  const BookSearchResults({required this.bookResults});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...bookResults.map((book) => ListTile(
            title: Text(book.title),
            subtitle: Text(book.authorId),
            tileColor: AppColors.highlightColor,
            textColor: AppColors.secondaryColor,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => BookDetailsPage(book: book)));
            },
          )),
        ],
      ),
    );
  }
}

class UserSearchResults extends StatelessWidget {
  final List<FirestoreUser> userResults;

  const UserSearchResults({required this.userResults});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...userResults.map((user) => ListTile(
            title: Text(user.username),
            subtitle: Text(user.fullName),
            onTap: () {
              // Handle user tap if needed
            },
          )),
        ],
      ),
    );
  }
}

