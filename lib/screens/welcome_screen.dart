import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/product_entry_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
            child: CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Welcome to Our Platform!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'We are excited to have you on board. Explore and enjoy our services.',
            style: TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductEntryScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              textStyle: TextStyle(
                fontSize: 18,
              ),
            ),
            child: Text('Add Items'),
          ),
        ],
      ),
    );
  }
}
