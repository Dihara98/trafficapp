import 'package:flutter/material.dart';
import 'tenth_page.dart';

class NinethPage extends StatefulWidget {
  final String dlNo;
  NinethPage({required this.dlNo});
  @override
  _NinthPageState createState() => _NinthPageState();
}

class _NinthPageState extends State<NinethPage> {
  final TextEditingController _vehicleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1b4a56), // Your background color
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
        backgroundColor: Color(0xFF1b4a56), // Matches your background
        title: Image.asset(
          'assets/logo.png', // Replace with your logo asset path
          height: 30,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Vehicle Number',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _vehicleController,
                decoration: InputDecoration(
                  hintText: 'Enter Vehicle Number',
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
                  String vehicleNo = _vehicleController.text.trim();
                  // Navigate to the vehicle details page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TenthPage(vehicleNo: vehicleNo),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.yellow, // Text color
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
      ),
    );
  }
}