import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/common/widgets/genre_box.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatsPage extends StatefulWidget  {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        children: [
          Text(
            'Here is Chat Page',
            style: TextStyle(
              fontSize: 50,
            ),
          ),
        ],
      ),
    );
  }
}