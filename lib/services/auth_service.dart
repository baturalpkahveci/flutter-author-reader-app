import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/models/firestore_user.dart';
import 'package:flutter_author_reader_app/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_author_reader_app/pages/login.dart';

class AuthService {
  Future<String?> signup({
    required String email,
    required String password,
    required String username,
    String? fullName
  }) async {
    String? message;
    try {
      print("Signing up as $email...");

      final _firestore = FirebaseFirestore.instance;
      final userService = UserService();

      // Check if the username already exists
      final usernameDoc = await _firestore.collection('users').where('username', isEqualTo: username).limit(1).get();

      if (usernameDoc.docs.isNotEmpty) {
        // If the username is already taken, prompt the user to pick a different one
        print('Username already exists. Please choose a different username.');
        return 'Username already exists!'; // Handle this appropriately in your UI
      }

      if (username.length > 10) {
        //This is due to keyword limitations for the search function.
        return 'Enter a username shorter than 10 characters!';
      }

      // Create user with Firebase Authentication
      final authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (authResult.user != null) {
        // User successfully created
        final firebaseUser = authResult.user!;

        // Create the Firestore user
        final newUser = FirestoreUser(
          id: firebaseUser.uid,
          bio: 'Hello, i am new to the Readdict!',
          createdAt: DateTime.now(),
          email: firebaseUser.email ?? '',
          fullName: fullName ?? '',
          username: username,
        );

        await userService.addUser(newUser);
        print('New Firestore user created with username: $username.');
      }
    } on FirebaseException catch(e) {
      if (e.code == 'weak-password'){
        message = 'The password provided is too weak!';
      }else if(e.code == 'email-already-in-use'){
        message = 'An account already exist with the same email!';
      }else{
        message = 'An error occured $e';
      }
    }
    if (message == null) { //If successfully signed-up
      // Save user data for auto-login next time
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setString('password', password);
      await prefs.setBool('isLoggedIn', true);
    }
    return message; //Return the message if failed
  }

  Future<String?> login({
    required String email,
    required String password
  }) async {
    String? message;
    try {
      print("Logging in as $email...");
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseException catch(e) {
      if (e.code == 'user-not-found'){
        message = 'There is no user found for this email!';
      }else if(e.code == 'wrong-password'){
        message = 'The password is wrong!';
      }else{
        message = 'An error occured $e';
      }
    }
    if (message == null) { //If successfully logged in
      // Save user data for auto-login next time
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setString('password', password);
      await prefs.setBool('isLoggedIn', true);
    }
    return message; //Return the message if failed
  }

  Future<bool> checkAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final String? message;

    if (isLoggedIn) {
      final email = prefs.getString('email');
      final password = prefs.getString('password');
      if (email != null && password != null) {
        message = await login(email: email, password: password);
        if (message != null) {
          return false; //Error occured
        }
        return true;
      }
    }
    return false;
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigate to login screen and remove all previous screens
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false, // This removes all previous routes
    );
  }
}