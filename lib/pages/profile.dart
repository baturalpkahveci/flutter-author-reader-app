import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/common/widgets/list_box.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_author_reader_app/models/firestore_user.dart';
import 'package:flutter_author_reader_app/pages/settings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_author_reader_app/providers/user_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // PROVIDERS
    var userProvider = Provider.of<UserProvider>(context);
    userProvider.fetchCurrentUser();
    var currentUser = userProvider.currentUser;

    // Null check for currentUser
    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Error")),
        body: Center(child: Text("User is not authenticated.")),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              _coverImage(currentUser),
              _profileImage(currentUser),
            ],
          ),
          _settingsButton(currentUser),
          SizedBox(height: 30),
          _userName(currentUser),
          _fullName(currentUser),
          _biography(currentUser),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _followUserButton(currentUser),
                    _sendMessageButton(currentUser),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          // Add lists below:
          ListBox(listName: 'Favorites'),
          ListBox(listName: 'Read Books'),
          ListBox(listName: 'Currently Reading'),
          ListBox(listName: 'To Read'),
        ],
      ),
    );
  }

  Padding _biography(FirestoreUser user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 20,
        ),
        width: double.maxFinite,
        child: Center(
          child: Text(
            user.bio,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontFamily: 'liberation_sans',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            softWrap: true,
          ),
        ),
      ),
    );
  }

  Flexible _sendMessageButton(FirestoreUser user) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          // Handle the tap event here.
          print('"Send Message" button tapped!');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          height: 50,
          width: 175,
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
            mainAxisSize: MainAxisSize.min, // İçeriğe göre genişlik
            children: [
              SvgPicture.asset(
                'assets/icons/message-square-lines-svgrepo-com.svg',
                color: AppColors.secondaryColor,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  'Send Message',
                  style: TextStyle(
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

  Flexible _followUserButton(FirestoreUser user) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          // Handle the tap event here.
          print('"Follow user" button tapped!');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          height: 50,
          width: 160,
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
            mainAxisSize: MainAxisSize.min, // İçeriğe göre genişlik
            children: [
              SvgPicture.asset(
                'assets/icons/profile-plus-round-1324-svgrepo-com.svg',
                color: AppColors.secondaryColor,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  'Follow user',
                  style: TextStyle(
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

  Column _settingsButton(FirestoreUser user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            // Handle the tap event here.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
            print('Settings button tapped!');
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: SvgPicture.asset(
                'assets/icons/setting-2-svgrepo-com.svg',
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding _fullName(FirestoreUser user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Center(
        child: Text(
          user.fullName,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontFamily: 'liberation_sans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          softWrap: true,
        ),
      ),
    );
  }

  Padding _userName(FirestoreUser user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Center(
        child: Text(
          user.username,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontFamily: 'holen_vintage',
            fontSize: 25,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.primaryColor,
          ),
          softWrap: true,
        ),
      ),
    );
  }

  Positioned _profileImage(FirestoreUser user) {
    return Positioned(
      top: 125,
      left: 0,
      right: 0,
      child: Center(
        child: CircleAvatar(
          radius: 75,
          backgroundColor: AppColors.highlightColor,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }

  Container _coverImage(FirestoreUser user) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 10,
          ),
        ],
      ),
      // Add cover image here.
      // child: Image.asset(
      //   'assets/images/images.jpg',
      //   fit: BoxFit.cover,
      // ),
    );
  }
}
