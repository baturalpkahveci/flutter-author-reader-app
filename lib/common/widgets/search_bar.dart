import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/models/book.dart';
import 'package:flutter_author_reader_app/models/firestore_user.dart';
import 'package:flutter_author_reader_app/providers/book_provider.dart';
import 'package:flutter_author_reader_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  final Function(Book book) onBookTap;
  final Function(FirestoreUser user) onUserTap;

  const SearchBar({
    Key? key,
    required this.onBookTap,
    required this.onUserTap,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _searchController = TextEditingController();
  List<Book> _bookResults = [];
  List<FirestoreUser> _userResults = [];
  bool _isSearching = false;

  void _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _bookResults = [];
        _userResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    final bookProvider = Provider.of<BookProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final books = await bookProvider.searchBooks(query);
      final users = await userProvider.searchUsers(query);

      setState(() {
        _bookResults = books;
        _userResults = users;
      });
    } catch (e) {
      print('Error during search: $e');
    } finally {
      setState(() {
        _isSearching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search books or users...',
              prefixIcon: Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  _performSearch('');
                },
              )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: _performSearch,
          ),
        ),
        if (_isSearching)
          Center(child: CircularProgressIndicator())
        else
          Expanded(
            child: ListView(
              children: [
                if (_bookResults.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      'Books',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ..._bookResults.map(
                        (book) => ListTile(
                      title: Text(book.title),
                      subtitle: Text(book.authorId),
                      onTap: () => widget.onBookTap(book),
                    ),
                  ),
                ],
                if (_userResults.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      'Users',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ..._userResults.map(
                        (user) => ListTile(
                      title: Text(user.username),
                      subtitle: Text(user.email),
                      onTap: () => widget.onUserTap(user),
                    ),
                  ),
                ],
                if (_bookResults.isEmpty && _userResults.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text('No results found.'),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
