import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/common/widgets/setting_box.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_author_reader_app/pages/profile_settings.dart';
import 'package:flutter_author_reader_app/services/auth_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        children: [
          _settingsSection(),
        ],
      ),
    );
  }

  Column _settingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.all(15),
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: Icon(CupertinoIcons.profile_circled),
                  title: Text("Profile"),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileSettingsPage(),)),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Icon(Icons.logout_outlined),
                  title: Text("Log Out"),
                  iconColor: AppColors.secondaryHighlight,
                  textColor: AppColors.secondaryHighlight,
                  tileColor: AppColors.secondaryColor,
                  onTap: () => _showConfirmationDialog(context),
                ),
              ],
            )),
      ],
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              "Logging Out",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryHighlight
            ),
          ),
          content: Text("Are you sure you want to log out from Readdict?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User canceled
              },
              child: Text(
                  "Cancel",
                style: TextStyle(
                  color: AppColors.primaryColor
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User confirmed
                authService.logout(context);
              },
              child: Text(
                  "Log Out",
                style: TextStyle(
                  color: AppColors.secondaryHighlight
                ),
              ),
            ),
          ],
        );
      },
    );
  }

}
