import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_author_reader_app/pages/home.dart';
import 'package:flutter_author_reader_app/pages/login.dart';
import 'package:flutter_author_reader_app/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();

    _checkAuthorization();
  }

  Future<void> _checkAuthorization() async {
    bool isAuthorized = await _authService.checkAutoLogin();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return; // Ensure widget is still in the tree
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => isAuthorized ? HomePage() : LoginScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.highlightColor, // Change to match your brand
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset("assets/images/splash_logo.png", width: 150, height: 150),
        ),
      ),
    );
  }
}
