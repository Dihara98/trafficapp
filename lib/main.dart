import 'package:flutter/material.dart';
import 'tenthpage.dart'; // Import the tenthpage.dart file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehicle Info App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TenthPage(), // Direct to TenthPage
    );
  }
}
