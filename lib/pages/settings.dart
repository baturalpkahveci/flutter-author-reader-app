import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/common/widgets/setting_box.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';

class SettingsPage extends StatefulWidget  {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>  {

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
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
          padding: const EdgeInsets.all(15),
          child: Text(
            'Settings',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontFamily: 'holen_vintage',
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          child: GridView.count(
            crossAxisCount: 1,
            crossAxisSpacing: 15,
            childAspectRatio: 7,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              SettingBox(settingName: 'Edit User Name',),
              SettingBox(settingName: 'Edit Full Name',),
              SettingBox(settingName: 'Edit Biography',),
              SettingBox(settingName: 'Edit Profile Image',),
              SettingBox(settingName: 'Edit Cover Image',),
            ],
          ),
        ),
      ],
    );
  }
}