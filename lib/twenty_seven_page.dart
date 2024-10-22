import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For Firestore
import 'package:intl/intl.dart'; // For formatting timestamps

class TwentySevenPage extends StatefulWidget {
  final Map<String, dynamic> userData; // Receive the user data

  TwentySevenPage({required this.userData});

  @override
  _TwentySevenPageState createState() => _TwentySevenPageState();
}

class _TwentySevenPageState extends State<TwentySevenPage> {
  Map<String, dynamic>? insuranceDetails;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchInsuranceDetails(); // Fetch details when the page loads
  }

  Future<void> _fetchInsuranceDetails() async {
    try {
      // Query Firestore to find a document with the matching vehicleNo field
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Insuarance') // Replace with your collection name in Firestore
          .where('vehicleNo', isEqualTo: widget.userData['vehicleNo']) // Query using the vehicleNo field
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          // Assuming that vehicleNo is unique and you get one document
          insuranceDetails = querySnapshot.docs.first.data() as Map<String, dynamic>?;
          errorMessage = null; // Clear the error message if data is found
        });
      } else {
        setState(() {
          insuranceDetails = null;
          errorMessage = 'No insurance details found for this vehicle.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error retrieving data: $e';
        insuranceDetails = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF074D5E), // Your background color
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
            child: Image.asset('assets/logo.png', width: 40),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            if (insuranceDetails != null)
              Expanded(
                child: Card(
                  color: Color(0xFF074D5E),
                  margin: EdgeInsets.only(top: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDataField('Vehicle Number:', insuranceDetails!['vehicleNo']),
                        _buildDataField('Policy Number:', insuranceDetails!['policyNo']),
                        _buildDataField('Period of Cover:',
                            'From ${formatTimestamp(insuranceDetails!['from'])} To ${formatTimestamp(insuranceDetails!['to'])}'),
                        _buildDataField('Policy Holder:', insuranceDetails!['fullName']),
                        _buildDataField('Address:', insuranceDetails!['address']),
                        _buildDataField('Issued Date:', formatTimestamp(insuranceDetails!['dateOfIssue'])),
                        _buildDataField('Contract Type:', insuranceDetails!['contractType']),
                        _buildDataField('Vehicle Use:', insuranceDetails!['vehicleUse']),
                        SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE6A500), // Yellow color
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: const Text(
                              'OK',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataField(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        '$label: $value',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  // Helper function to format timestamps
  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return 'N/A';
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return DateFormat('dd MMMM yyyy').format(date); // Only show date
  }
}