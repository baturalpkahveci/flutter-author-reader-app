import 'package:flutter_author_reader_app/common/widgets/genre_box.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/pages/books.dart';
import 'package:flutter_author_reader_app/pages/chats.dart';
import 'package:flutter_author_reader_app/pages/favorites.dart';
import 'package:flutter_author_reader_app/pages/genres.dart';
import 'package:flutter_author_reader_app/pages/profile.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  {
  int _selectedIndex = 0; // Tracks the current selected tab

  // List of widgets to display for each tab
  static const List<Widget> _pageOptions = <Widget>[
    GenresPage(),
    ChatsPage(),
    FavoritesPage(),
    ProfilePage(),
    // Add pages here.
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: _pageOptions.elementAt(_selectedIndex),
      bottomNavigationBar: bottomNavgiationBar(),
    );
  }

  Container bottomNavgiationBar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.highlightColor,
        selectedFontSize: 15,
        unselectedItemColor: AppColors.highlightColor,
        unselectedFontSize: 15,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home-svgrepo-com.svg',
              color: _selectedIndex == 0 ? AppColors.highlightColor : AppColors.primaryColor,
              height: 20,
              width: 20,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/chat-ui-web-svgrepo-com.svg',
              color: _selectedIndex == 1 ? AppColors.highlightColor : AppColors.primaryColor,
              height: 20,
              width: 20,
            ),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/favorite-svgrepo-com.svg',
              color: _selectedIndex == 2 ? AppColors.highlightColor : AppColors.primaryColor,
              height: 20,
              width: 20,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/profile-round-1342-svgrepo-com.svg',
              color: _selectedIndex == 3 ? AppColors.highlightColor : AppColors.primaryColor,
              height: 20,
              width: 20,
            ),
            label: 'My Profile',
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Center(
        child: Text(
          'Author - Reader App',
          style: TextStyle(
            fontFamily: 'holen_vintage',
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      toolbarHeight: 70,
      backgroundColor: AppColors.highlightColor,
    );
  }
}