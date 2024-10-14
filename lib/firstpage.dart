import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1b4a56), // Background color
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between top and bottom
        children: <Widget>[
          const SizedBox(height: 50), // Adding a bit of space from the top
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/logo.png', // Adjust this path according to your image location
                  width: 150, // Adjust the size of the logo
                  height: 150,
                ),
                const SizedBox(height: 20), // Space between the logo and text
                const Text(
                  "Simplifying Road Safety",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFFFFFFFF), // White text color
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 30.0), // Padding from bottom
            child: Text(
              "Powered by Android",
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF000000), // Black text color
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: const Center(
        child: Text("This is the main screen after the splash screen."),
      ),
    );
  }
}
