import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insuarance Details',
      home: Page28(),
    );
  }
}

class Page28 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insuarance Details'),
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
                  _buildDetailRow("Policy Number", "LK5789212012365"),
                  _buildDetailRow("Period of Cover", "From 28th May 2019\nTo 27th May 2020"),
                  _buildDetailRow("Policy Holder", "Miss K M D Madushani"),
                  _buildDetailRow("Address", "Kudagama, Maho"),
                  _buildDetailRow("Issued Date", "23rd July 2020"),
                  _buildDetailRow("Contract Type", "Third Party"),
                  _buildDetailRow("Vehicle Use", "Private"),
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
