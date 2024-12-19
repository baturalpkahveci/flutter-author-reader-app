import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/common/widgets/genre_box.dart';
import 'package:flutter_author_reader_app/common/widgets/list_box.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget  {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              _coverImage(),
              _profileImage(),
            ],
          ),
          _settingsButton(),
          SizedBox(height: 30,),
          _userName(),
          _fullName(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              constraints: BoxConstraints(
                minHeight: 20,
              ),
              width: double.maxFinite,
              child: Center(
                child: Text(
                  'biography',
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
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _followUserButton(),
                    _sendMessageButton(),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 40,),
          // Add lists below:
          ListBox(listName: 'Favorites',),
          ListBox(listName: 'Read Books',),
          ListBox(listName: 'Currently Reading',),
          ListBox(listName: 'To Read',),
        ],
      ),
    );
  }

  Flexible _sendMessageButton() {
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

  Flexible _followUserButton() {
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

  Column _settingsButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            // Handle the tap event here.
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

  Padding _fullName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Center(
        child: Text(
          'Real Name',
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

  Padding _userName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Center(
        child: Text(
          'username',
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

  Positioned _profileImage() {
    return Positioned(
      top: 125,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Center(
            child: Icon(Icons.star, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Container _coverImage() {
    return Container(
      width: double.infinity,
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
      /*
      Add cover image here.
      child: Image.asset(
        'assets/images/images.jpg',
        fit: BoxFit.cover,
      ),
      **/
    );
  }
}