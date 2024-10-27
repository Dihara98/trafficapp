import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Firestore package
import 'package:sltrafficapp/twenty_seven_page.dart';
//This is a comment

class BetweenTwentyTwentySevenPage extends StatefulWidget {
  @override
  _BetweenTwentyTwentySevenPageState createState() => _BetweenTwentyTwentySevenPageState();
}

class _BetweenTwentyTwentySevenPageState extends State<BetweenTwentyTwentySevenPage> {
  final TextEditingController _vehicleController = TextEditingController();
  final TextEditingController _policyNoController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _validateAndNavigate() async {
    String vehicleNo = _vehicleController.text.trim();
    String policyNo = _policyNoController.text.trim();

    if (vehicleNo.isEmpty || policyNo.isEmpty) {
      _showErrorDialog('Please fill in both fields.');
      return;
    }

    // Query Firestore for matching document
    try {
      var querySnapshot = await _firestore
          .collection('Insuarance')
          .where('vehicleNo', isEqualTo: vehicleNo)
          .where('policyNo', isEqualTo: policyNo)
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
        builder: (context) => TwentySevenPage(vehicleNo: vehicleNo),
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
              controller: _vehicleController,
              decoration: const InputDecoration(
                labelText: 'Vehicle Registration Number',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.white24,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _policyNoController,
              decoration: const InputDecoration(
                labelText: 'Policy Number',
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