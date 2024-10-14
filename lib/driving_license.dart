//this page is used for the sixth_page.dart
//this is the seventh and eighth page
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DrivingLicensePage extends StatefulWidget {
  final String licenseNumber; // Accept the license number as a parameter

  DrivingLicensePage({required this.licenseNumber});

  @override
  _DrivingLicensePageState createState() => _DrivingLicensePageState();
}

class _DrivingLicensePageState extends State<DrivingLicensePage> {
  String? errorMessage;
  Map<String, dynamic>? driverDetails;

  @override
  void initState() {
    super.initState();
    _fetchDriverDetails(); // Fetch the details when the page loads
  }

  Future<void> _fetchDriverDetails() async {
    try {
      // Query Firestore to find a document with the matching dlNo field
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('DrivingLicence') // Replace with your collection name in Firestore
          .where('dlNo', isEqualTo: widget.licenseNumber) // Query using the dlNo field
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          // Assuming that dlNo is unique and you get one document
          driverDetails = querySnapshot.docs.first.data() as Map<String, dynamic>?;
          errorMessage = null; // Clear the error message if data is found
        });
      } else {
        setState(() {
          driverDetails = null;
          errorMessage = 'No details found for the entered Driving License Number.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error retrieving data: $e';
        driverDetails = null;
      });
    }
  }


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
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            if (driverDetails != null)
              Expanded(
                child: Card(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        _buildDataField('Driving License Number', widget.licenseNumber),
                        _buildDataField('NIC No', driverDetails!['NIC']),
                        _buildDataField('Full Name', driverDetails!['fullName']),
                        _buildDataField('Address', driverDetails!['address']),
                        _buildDataField('Date of Birth', driverDetails!['dateOfBirth']),
                        _buildDataField('Date of Issue of the License', driverDetails!['dateOfIssue']),
                        _buildDataField('Date of Expiry of the License', driverDetails!['dateOfExpiry']),
                        _buildDataField('Blood Group', driverDetails!['bloodGroup']),

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

  //build the data field with label and value
  Widget _buildDataField(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        '$label: $value',
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}