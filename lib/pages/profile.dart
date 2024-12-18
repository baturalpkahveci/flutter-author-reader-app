import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/common/widgets/genre_box.dart';
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  print('Settings button tapped!');
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
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
          ),
          SizedBox(height: 85,),
          _userName(),
          _realName(),
        ],
      ),
    );
  }

  Padding _realName() {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Center(
            child: Text(
              'Real Name',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontFamily: 'holen_vintage',
                fontSize: 25,
                fontWeight: FontWeight.w500,
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
                fontSize: 30,
                fontWeight: FontWeight.bold,
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