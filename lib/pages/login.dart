import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_author_reader_app/pages/home.dart';
import 'package:flutter_author_reader_app/services/auth_service.dart';

//THESE ARE FOR TESTING, JUST FOR NOW
const users =  {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
  '1234@gmail.com':'1234'
};

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var _authService = AuthService();
  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async{
      String? message = await _authService.signin(email: data.name, password: data.password);
      return message;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      String? message = await _authService.signup(email: data.name ?? '', password: data.password ?? '' , username:  data.additionalSignupData?['username'] ?? '' , fullName: data.additionalSignupData?['fullName']);
      return message;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return "null"; //MANAGE RECOVER PASSWORD LATER
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Readdict',
      logo: null,
      theme: LoginTheme(
        primaryColor: AppColors.highlightColor,
        accentColor: AppColors.secondaryColor,
        titleStyle: const TextStyle(
          fontFamily: 'holen_vintage',
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      onLogin: _authUser,
      onSignup: _signupUser,
      additionalSignupFields: [
        UserFormField(
          keyName: "username",
          displayName: "Username",
          icon: Icon(Icons.person),
          userType: LoginUserType.firstName,
          fieldValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'Username is required';
            }
            if (value.length < 3 || value.length > 15) {
              return 'Username must be between 3 and 15 characters';
            }
            final validCharacters = RegExp(r'^[a-zA-Z0-9_]+$');
            if (!validCharacters.hasMatch(value)) {
              return 'Username can only contain letters, numbers, and underscores';
            }
            return null;
          },

        ),
        UserFormField(
          keyName: "fullName",
          displayName: "Full name",
          icon: Icon(Icons.person),
          userType: LoginUserType.firstName,
        ),
      ],
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}