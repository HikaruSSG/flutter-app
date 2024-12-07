import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/welcome_screen.dart';
import '../screens/product_list_screen.dart';
import '../screens/product_entry_screen.dart';

class BottomNavigationMenu extends StatefulWidget {
  @override
  _BottomNavigationMenuState createState() => _BottomNavigationMenuState();
}

class _BottomNavigationMenuState extends State<BottomNavigationMenu> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    LoginScreen(),
    SignUpScreen(),
    WelcomeScreen(),
    ProductListScreen(),
    ProductEntryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.login, color: Colors.blue), label: 'Login'),
          BottomNavigationBarItem(
              icon: Icon(Icons.app_registration, color: Colors.blue),
              label: 'Signup'),
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.blue), label: 'Welcome'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list, color: Colors.blue),
              label: 'Product List'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add, color: Colors.blue),
              label: 'Product Entry'),
        ],
      ),
    );
  }
}
