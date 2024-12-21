import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_author_reader_app/pages/books.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingBox extends StatelessWidget {
  final String settingName;

  const SettingBox({
    Key? key,
    required this.settingName,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle the tap event here.
        print('Setting tapped: $settingName');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColors.primaryColor.withOpacity(0.3),
            width: 2,
            strokeAlign: 0
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              settingName,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontFamily: 'liberation_sans',
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SvgPicture.asset(
              'assets/icons/right-arrow-next-svgrepo-com (1).svg',
              height: 15,
              width: 15,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
