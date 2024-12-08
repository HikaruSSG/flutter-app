import 'package:flutter/material.dart';
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
    WelcomeScreen(),
    ProductListScreen(),
    ProductEntryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black, // Set background color to black
        selectedItemColor: Colors.white, // Set selected icon color to white
        unselectedItemColor: Colors.white, // Set unselected icon color to white
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Welcome'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: 'Product List'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add), label: 'Product Entry'),
        ],
      ),
    );
  }
}
