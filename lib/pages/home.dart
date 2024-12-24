import 'package:flutter_author_reader_app/common/widgets/genre_box.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/pages/books.dart';
import 'package:flutter_author_reader_app/pages/chats.dart';
import 'package:flutter_author_reader_app/pages/notices.dart';
import 'package:flutter_author_reader_app/pages/genres.dart';
import 'package:flutter_author_reader_app/pages/profile.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Tracks the current selected tab

  // List of widgets to display for each tab
  static const List<Widget> _pageOptions = <Widget>[
    GenresPage(),
    ChatsPage(),
    NoticesPage(),
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
      backgroundColor: AppColors.backgroundColor,
      appBar: appBar(),
      body: _selectedIndex == 0 // Ensure proper page display for the Home tab
          ? _pageOptions.elementAt(_selectedIndex)
          : _pageOptions.elementAt(_selectedIndex),
      bottomNavigationBar: bottomNavgiationBar(),
    );
  }

  Container bottomNavgiationBar() {
    // Get screen size for dynamic scaling
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scaleFactor = screenWidth / 375; // Assuming 375 as base width (common width for mobile)
    return Container(
      height: 70,
      width: double.maxFinite,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 8,
            offset: Offset(0, -3),
          )
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 10,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.highlightColor,
        selectedIconTheme: IconThemeData(
          color: AppColors.highlightColor,
        ),
        selectedLabelStyle: TextStyle(
          color: AppColors.highlightColor,
          fontFamily: 'liberation_sans',
          fontSize: 15 * scaleFactor,
          fontWeight: FontWeight.bold,
        ),
        unselectedItemColor: AppColors.primaryColor,
        unselectedIconTheme: IconThemeData(
          color: AppColors.primaryColor,
        ),
        unselectedLabelStyle: TextStyle(
          color: AppColors.primaryColor,
          fontFamily: 'liberation_sans',
          fontSize: 15 * scaleFactor,
          fontWeight: FontWeight.bold,
        ),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home-svgrepo-com.svg',
              color: _selectedIndex == 0 ? AppColors.highlightColor : AppColors.primaryColor,
              height: 17 * scaleFactor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/chat-ui-web-svgrepo-com.svg',
              color: _selectedIndex == 1 ? AppColors.highlightColor : AppColors.primaryColor,
              height: 17 * scaleFactor,
            ),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/favorite-svgrepo-com.svg',
              color: _selectedIndex == 2 ? AppColors.highlightColor : AppColors.primaryColor,
              height: 17 * scaleFactor,
            ),
            label: 'Notices',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/profile-round-1342-svgrepo-com.svg',
              color: _selectedIndex == 3 ? AppColors.highlightColor : AppColors.primaryColor,
              height: 15 * scaleFactor,
            ),
            label: 'My Profile',
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: AppColors.highlightColor,
      elevation: 0,
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
    );
  }
}
