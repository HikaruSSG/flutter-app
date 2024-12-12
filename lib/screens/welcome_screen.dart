import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/bottom_navigation_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/screens/product_entry_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/auth_service.dart';
import 'dart:convert';

class WelcomeScreen extends StatefulWidget {
  final String? username;

  const WelcomeScreen({Key? key, this.username}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final AuthService _authService = AuthService();
  bool _isLoggedIn = false;
  String _username = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _checkLoginStatus();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    if (userData != null) {
      final user = jsonDecode(userData);
      setState(() {
        _username = user['username'] ?? '';
      });
    } else {
      setState(() {
        _username = widget.username ?? '';
      });
    }
  }

  Future<void> _checkLoginStatus() async {
    final isLoggedIn = await _authService.isLoggedIn();
    setState(() {
      _isLoggedIn = isLoggedIn;
      if (!_isLoggedIn) {
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(builder: (context) => BottomNavigationMenu()),
        // );
      }
    });
  }

  Future<void> _logout() async {
    await _authService.logout();
    _refreshUI();
  }

  void _refreshUI() {
    setState(() {
      _checkLoginStatus();
      _loadUsername();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Set AppBar background to black
        title: Text('Pantry CRUD App',
            style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Theme.of(context).primaryColorLight,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Welcome, ${_username.toUpperCase()}!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Stock your foods with your personal pantry app',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductEntryScreen()),
                      );
                    },
                    child: Text('Add Items'),
                  ),
                  SizedBox(height: 20),
                  if (!_isLoggedIn)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen(
                                    onLoginSuccess: _refreshUI,
                                  )),
                        );
                      },
                      child: Text('Login'),
                    ),
                  if (_isLoggedIn)
                    ElevatedButton(
                      onPressed: _logout,
                      child: Text('Logout'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
