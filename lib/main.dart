import 'package:flutter/material.dart';
//Firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_author_reader_app/firebase_options.dart';
//Pages
import 'package:flutter_author_reader_app/pages/login.dart';
import 'package:flutter_author_reader_app/pages/splash_screen.dart';
import 'package:flutter_author_reader_app/providers/chat_provider.dart';
import 'package:flutter_author_reader_app/providers/follow_provider.dart';
import 'package:flutter_author_reader_app/providers/group_chat_provider.dart';
import 'package:flutter_author_reader_app/providers/search_provider.dart';
import 'package:flutter_author_reader_app/providers/user_chat_provider.dart';
//Providers
import 'package:provider/provider.dart';
import 'package:flutter_author_reader_app/providers/book_provider.dart';
import 'package:flutter_author_reader_app/providers/category_provider.dart';
import 'package:flutter_author_reader_app/providers/reading_list_provider.dart';
import 'package:flutter_author_reader_app/providers/user_provider.dart';
//Other
import 'package:flutter_author_reader_app/core/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => BookProvider()),
          ChangeNotifierProvider(create: (_) => ChatProvider()),
          ChangeNotifierProvider(create: (_) => GroupChatProvider()),
          ChangeNotifierProvider(create: (_) => UserChatProvider()),
          ChangeNotifierProvider(create: (_) => CategoryProvider()),
          ChangeNotifierProvider(create: (_) => ReadingListProvider()),
          ChangeNotifierProvider(create: (_) => FollowProvider()),
          ChangeNotifierProvider(create: (_) => SearchProvider()),
        ],
      child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'liberation_sans',
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.highlightColor, // The color of the progress indicator.
          circularTrackColor: AppColors.secondaryColor, // The background track color.
        ),
      ),
      home: SplashScreen(),
    );
  }
}
