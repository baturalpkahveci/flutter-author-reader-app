import 'package:flutter/material.dart';
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
        title: Text('Search Results'),
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
          Text('Books', style: TextStyle(fontWeight: FontWeight.bold)),
          ...bookResults.map((book) => ListTile(
            title: Text(book.title),
            subtitle: Text(book.authorId),
            onTap: () {
              // Handle book tap if needed
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
          Text('Users', style: TextStyle(fontWeight: FontWeight.bold)),
          ...userResults.map((user) => ListTile(
            title: Text(user.username),
            subtitle: Text(user.email),
            onTap: () {
              // Handle user tap if needed
            },
          )),
        ],
      ),
    );
  }
}
