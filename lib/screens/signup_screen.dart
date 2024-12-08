import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'welcome_screen.dart'; // Import the welcome screen

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _userController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Your Account'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.lightBlue[100],
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _userController,
                decoration: InputDecoration(
                  labelText: 'User',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final response = await http.post(
                    Uri.parse(
                        'https://flutter-api-sd0r.onrender.com/api/auth/local/register'),
                    headers: {
                      'Content-Type': 'application/json',
                      'Authorization':
                          'Bearer a20bd0cff00f48c31b0ca158c3951dcd9654a0a0935158985d624c57e5a42930f924362ff452255a096294994509ac63bba8f5bc19cce4f248d4a71328583c08dd9fb35899855b0ee830d8125113a585d4c7c089f824cb4f4e58204f6d8de97eb7472ca02fe9f1aa346cfd316caada77e278cc6b0aae850cfc8a29cca80e63a1',
                    },
                    body: jsonEncode({
                      'username': _userController.text,
                      'email': _emailController.text,
                      'password': _passwordController.text,
                    }),
                  );

                  print('Response status: ${response.statusCode}');
                  print('Response body: ${response.body}');

                  if (response.statusCode == 200) {
                    print('User created successfully');
                  } else {
                    print('Error creating user');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text('Sign Up', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
