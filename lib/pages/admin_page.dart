import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_author_reader_app/common/widgets/create_book_form.dart';
import 'package:flutter_author_reader_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    userProvider.fetchCurrentUser();
    var currentUser = userProvider.currentUser;

    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: 10
                ),
                child: Text(
                  "Hello ${currentUser?.username}. How is your day?",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontFamily: 'liberation_sans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Divider(
                  color: AppColors.primaryColor,
                  thickness: 1,
                  indent: 15,
                  endIndent: 15,
                ),
              ),
              ListTile(
                leading: Icon(CupertinoIcons.book),
                trailing: Icon(Icons.add),
                title: Text('Create new book'),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateBookForm(),)
                ),
              ),
              ListTile(
                leading: Icon(CupertinoIcons.square_grid_2x2_fill),
                title: Text("Create a new category"),
                trailing: Icon(Icons.add),
                onTap: () => null,
              ),
          
            ],
          ),
        )
    );
  }
}