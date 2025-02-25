import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';

class ProfileSettingsPage extends StatefulWidget {
  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _biographyController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process the form data (e.g., send to database)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Form Submitted!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Settings")),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Username Field
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a username";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Full Name Field
              TextFormField(
                controller: _fullnameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your full name";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Biography Field (Multiline)
              TextFormField(
                controller: _biographyController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Biography",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
