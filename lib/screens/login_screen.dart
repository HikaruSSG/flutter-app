import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'signup_screen.dart'; // Import the sign up screen
import 'welcome_screen.dart'; // Import the welcome screen
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse('https://flutter-api-sd0r.onrender.com/api/auth/local'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'identifier': _usernameController.text,
            'password': _passwordController.text,
          }),
        );

        if (response.statusCode == 200) {
          // Login successful
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLoggedIn', true); // Store login status
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
          );
        } else {
          // Login failed
          setState(() {
            _errorMessage = 'Invalid username or password';
          });
        }
      } catch (e) {
        // Network error
        setState(() {
          _errorMessage = 'Network error';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueGrey[200],
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.pinkAccent,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Login to Your Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your username',
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text('Login'),
              ),
              const SizedBox(height: 10),
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                child: const Text('Don\'t have an account? Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
