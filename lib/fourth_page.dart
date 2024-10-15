import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'fifth_page.dart';

// This page will receive the user data fetched from Firestore
class FourthPage extends StatelessWidget {
  final Map<String, dynamic> userData;

  FourthPage({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1b4a56),
      body: SafeArea(  // Added SafeArea to ensure content is not obscured
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Back button in the top left corner
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: 20),

                // Displaying the user's logo or profile placeholder
                CircleAvatar(
                  radius: 80,  // Adjust the size of the circle avatar
                  backgroundColor: Colors.amber,  // Change the color as needed
                  child: Icon(Icons.person, size: 100, color: Colors.white),
                ),
                SizedBox(height: 20),

                // Displaying the fetched user data: name, rank, and location
                Text(
                  '${userData['name']}',  // Display full name from Firestore
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),

                Text(
                  '${userData['rank']}',  // Display rank from Firestore
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),

                Text(
                  '${userData['branch']}',  // Display location from Firestore
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 40),

                // Fines button, navigates to a new page
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FifthPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'FINES',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// New page that the user is navigated to when they press the FINES button
class FinesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fines Page'),
      ),
      body: Center(
        child: Text('This is the Fines Page'),
      ),
    );
  }
}
