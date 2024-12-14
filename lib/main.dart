import 'package:flutter_author_reader_app/pages/login.dart';

import 'pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

      ),
      home: const LoginScreen()
    );
  }
}
