import 'package:flutter/material.dart';
import 'third_page.dart';
import 'nineteen_page.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text("Choose Role"),
        backgroundColor: const Color(0xFF1b4a56),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Police Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20.0), backgroundColor: Colors.amber, // background color for button
                minimumSize: const Size(double.infinity, 80), // full-width button
              ),
              onPressed: () {
                // Navigate to Police Page
                Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdPage()));
              },
              child: Row(
                children: [
                  // Replace Icon with Image.asset
                  Image.asset(
                    'assets/police_loginlogo.jpg',
                    width: 50,  // Set width to match the size of the original icon
                    height: 50, // Set height
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    'Police',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),

            ),
            const SizedBox(height: 20),
            // Driver Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20.0), backgroundColor: Colors.amber, // background color for button
                minimumSize: const Size(double.infinity, 80), // full-width button
              ),
              onPressed: () {
                // Navigate to Driver Page
                Navigator.push(context, MaterialPageRoute(builder: (context) => NineteenPage()));
              },
              child: Row(
                children: [
                  // Replace Icon with Image.asset
                  Image.asset(
                    'assets/driver_loginlogo.jpg',
                    width: 50,  // Set width to match the size of the original icon
                    height: 50, // Set height
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    'Driver',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),

            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF1b4a56),
    );
  }
}
/*
// Dummy PolicePage
class PolicePage extends StatelessWidget {
  const PolicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Police Page")),
      body: const Center(child: Text("Police Dashboard")),
    );
  }
}*/

// Dummy DriverPage
class DriverPage extends StatelessWidget {
  const DriverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Driver Page")),
      body: const Center(child: Text("Driver Dashboard")),
    );
  }
}
