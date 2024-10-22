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
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                backgroundColor: Colors.amber, // background color for button
                minimumSize: const Size(double.infinity, 80), // full-width button
              ),
              onPressed: () {
                // Navigate to Police Page
                Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Padding(padding: const EdgeInsets.only(left: 20.0),
                  child: Image.asset(
                    'assets/police_loginlogo.png',
                    width: 50,  // Set width to match the size of the original icon
                    height: 50, // Set height
                  ),
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
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                backgroundColor: Colors.amber, // background color for button
                minimumSize: const Size(double.infinity, 80), // full-width button
              ),
              onPressed: () {
                // Navigate to Driver Page
                Navigator.push(context, MaterialPageRoute(builder: (context) => NineteenPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Padding(padding: const EdgeInsets.only(left: 20.0),
                  child: Image.asset(
                    'assets/driver_loginlogo.png',
                    width: 50,
                    height: 50,
                  ),
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

