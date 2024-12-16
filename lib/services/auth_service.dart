import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<String?> signup({
    required String email,
    required String password
  }) async {
    String? message;
    try {
      print("Signing up as $email...");
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
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