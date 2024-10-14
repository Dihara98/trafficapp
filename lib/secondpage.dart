import 'package:flutter/material.dart';

void main() {
  runApp(TrafficApp());
}

class TrafficApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SL Traffic',
      theme: ThemeData(
        primaryColor: Color(0xFF1b4a56), // Blue color
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1b4a56), // Set blue background color
      appBar: AppBar(
        backgroundColor: Color(0xFF1b4a56), // Blue color for AppBar
        title: Text('SL Traffic', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center elements vertically
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20), // Adjust space from top for better centering
                // Police section
                GestureDetector(
                  onTap: () {
                    // Add navigation or action for police card
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFd5aa02), // Yellow color
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // Police Image with fixed size
                        SizedBox(
                          width: 100,
                          height:100,
                          child: Image.asset(
                            'assets/police.png', // Add the police image here
                            fit: BoxFit.cover, // Ensure the image fits
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Police',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // Driver section
                GestureDetector(
                  onTap: () {
                    // Add navigation or action for driver card
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFd5aa02), // Yellow color
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // Driver Image with fixed size
                        SizedBox(
                          width:100,
                          height:100,
                          child: Image.asset(
                            'assets/driver.png', // Add the driver image here
                            fit: BoxFit.cover, // Ensure the image fits
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Driver',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Logo at the top right corner
          Positioned(
            top: 20,
            right: 20,
            child: Image.asset(
              'assets/logo.png', // Add your logo image here
              height: 150,// Increase the height for a larger logo
            ),
          ),
        ],
      ),
    );
  }
}
