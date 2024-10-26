import 'package:flutter/material.dart';

class TwentyNinePage extends StatelessWidget {
  final String userData;

  const TwentyNinePage({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF074D5E),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome, $userData', style: TextStyle(color: Colors.white, fontSize: 24)),
                // Other UI elements can be added here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
