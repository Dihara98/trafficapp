import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Revenue Details',
      home: Page26(),
    );
  }
}

class Page26 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Revenue Details'),
        backgroundColor: Color(0xFF006d77), // Dark blue color
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Back icon
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Color(0xFF003847), // Background dark blue color
                borderRadius: BorderRadius.circular(0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDetailRow("Vehicle Number", "BIJ 4875"),
                  _buildDetailRow("Owner's Name", "Kahandugoda Manage Dilhara"),
                  _buildDetailRow("User Location", "Kudagama, Maho"),
                  _buildDetailRow("Reference Number", "GDDGHSJ56578"),
                  _buildDetailRow("License Duration", "25.01.2024 - 25.01.2026"),
                  _buildDetailRow("Amount", "Rs.600" ),
                  _buildDetailRow("Payment Type", "Online Payment"),
                  _buildDetailRow("Approval Code", "456756777"),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.8, // 90% from top
            left: MediaQuery.of(context).size.width / 2 - 60, // Center horizontally
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE0A912), // Yellow button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              child: Text('OK', style: TextStyle(fontSize: 18 , color: Color(0xFF003847), fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$title:",
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
