import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_author_reader_app/models/firestore_user.dart';
import 'package:flutter_author_reader_app/services/user_service.dart';

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
          bio: 'Hello, i am new to the bookify!',
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
    return message;
  }

  Future<String?> signin({
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
    return message;
  }
}