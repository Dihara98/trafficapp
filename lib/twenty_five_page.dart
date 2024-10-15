import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sltrafficapp/twenty_six_page.dart';

class TwentyFivePage extends StatefulWidget {
  @override
  _TwentyFivePageState createState() => _TwentyFivePageState();
}

class _TwentyFivePageState extends State<TwentyFivePage> {
  final TextEditingController vehicleController = TextEditingController();
  final TextEditingController chassisController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _validateAndNavigate() async {
    String vehicleNo = vehicleController.text.trim();
    String chassisNo = chassisController.text.trim();

    if (vehicleNo.isEmpty || chassisNo.isEmpty) {
      _showErrorDialog('Please fill in both fields.');
      return;
    }

    // Query Firestore for matching document
    try {
      var querySnapshot = await _firestore
          .collection('RevenueLicence')
          .where('vehicleNo', isEqualTo: vehicleNo)
          .where('chassisNo', isEqualTo: chassisNo)
          .get();

      if (querySnapshot.docs.isNotEmpty) {

        _navigateToNextPage(vehicleNo);
      } else {
        _showErrorDialog('No matching vehicle found.');
      }
    } catch (e) {
      _showErrorDialog('Error fetching data: $e');
    }
  }

  void _navigateToNextPage(String vehicleNo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TwentySixPage(vehicleNo: vehicleNo),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: vehicleController,
              decoration: const InputDecoration(
                labelText: 'Vehicle Registration Number',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.white24,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: chassisController,
              decoration: const InputDecoration(
                labelText: 'Chassis Number (Last Six Characters)',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.white24,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE6A500), // Yellow color
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: _validateAndNavigate,
              child: const Text(
                'SUBMIT',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF074D5E), // Dark blue background
    );
  }
}


