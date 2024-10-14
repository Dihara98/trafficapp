import 'package:flutter/material.dart';
import 'driving_license.dart';

class SixthPage extends StatelessWidget {
  final TextEditingController _licenseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF074D5E), // Background color matching your design
      appBar: AppBar(
        backgroundColor: Color(0xFF074D5E),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png', width: 40), // Replace with your logo
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Driving License Number',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _licenseController,
              decoration: InputDecoration(
                hintText: 'Enter your driving license number',
                hintStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                String licenseNumber = _licenseController.text.trim();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DrivingLicensePage(licenseNumber: licenseNumber),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.yellow, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'SUBMIT',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
