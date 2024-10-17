import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For Firestore
import 'eleventh_twelveth_page.dart'; // Import the EleventhPage

class TenthPage extends StatefulWidget {
  final String vehicleNumber;

  TenthPage({required this.vehicleNumber});

  @override
  _TenthPageState createState() => _TenthPageState();
}

class _TenthPageState extends State<TenthPage> {
  // Data to hold the vehicle details
  Map<String, dynamic>? vehicleDetails;
  Map<String, dynamic>? revenueLicenseDetails;
  Map<String, dynamic>? insuranceDetails;
  String? errorMessage;

  // Initial fetch of vehicle details
  @override
  void initState() {
    super.initState();
    _fetchVehicleDetails();
    _fetchRevenueLicenseDetails();
    _fetchInsuranceDetails();
  }

  Future<void> _fetchVehicleDetails() async {
    try {
      // Query Firestore to retrieve vehicle data
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Vehicles') // Replace with your Firestore collection
          .where('vehicleNumber', isEqualTo: widget.vehicleNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          vehicleDetails = querySnapshot.docs.first.data() as Map<String, dynamic>;
          errorMessage = null; // Clear the error message if data is found
        });
      } else {
        setState(() {
          vehicleDetails = null;
          errorMessage = 'No vehicle details found.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error retrieving data: $e';
        vehicleDetails = null;
      });
    }
  }

  Future<void> _fetchRevenueLicenseDetails() async {
    try {
      // Query Firestore to retrieve vehicle data
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('RevenueLicence') // Replace with your Firestore collection
          .where('vehicleNumber', isEqualTo: widget.vehicleNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          revenueLicenseDetails = querySnapshot.docs.first.data() as Map<String, dynamic>;
          errorMessage = null; // Clear the error message if data is found
        });
      } else {
        setState(() {
          revenueLicenseDetails = null;
          errorMessage = 'No revenue license details found.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error retrieving data: $e';
        revenueLicenseDetails = null;
      });
    }
  }

  Future<void> _fetchInsuranceDetails() async {
    try {
      // Query Firestore to retrieve vehicle data
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Insurance') // Replace with your Firestore collection
          .where('vehicleNumber', isEqualTo: widget.vehicleNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          insuranceDetails = querySnapshot.docs.first.data() as Map<String, dynamic>;
          errorMessage = null; // Clear the error message if data is found
        });
      } else {
        setState(() {
          insuranceDetails = null;
          errorMessage = 'No insurance details found.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error retrieving data: $e';
        insuranceDetails = null;
      });
    }
  }

  // Function to display vehicle details
  void _showVehicleDetails() {
    // Display vehicle details from 'vehicleDetails' in a new page or dialog
    // Example:
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Vehicle Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (vehicleDetails != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display vehicle details from 'vehicleDetails'
                  _buildDataField('Registration Number', vehicleDetails!['vehicleNumber']),
                  _buildDataField('Model', vehicleDetails!['model']),
                  // ... Add other fields as needed
                ],
              )
            else
              Text('No vehicle details found.'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  // Function to display revenue license details (similar to _showVehicleDetails)
  void _showRevenueLicenseDetails() {
    // Display revenue license details from 'vehicleDetails'
    // Example:
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Revenue License Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (revenueLicenseDetails != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display revenue license details from 'vehicleDetails'
                  _buildDataField('License Number', revenueLicenseDetails!['revenueLicenseNumber']),
                  _buildDataField('Expiry Date', revenueLicenseDetails!['revenueLicenseExpiry']),
                  // ... Add other fields as needed
                ],
              )
            else
              Text('No revenue license details found.'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  // Function to display insurance details (similar to _showVehicleDetails)
  void _showInsuranceDetails() {
    // Display insurance details from 'vehicleDetails'
    // Example:
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Insurance Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (insuranceDetails != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display insurance details from 'vehicleDetails'
                  _buildDataField('Policy Number', insuranceDetails!['insurancePolicyNumber']),
                  _buildDataField('Expiry Date', insuranceDetails!['insuranceExpiry']),
                  // ... Add other fields as needed
                ],
              )
            else
              Text('No insurance details found.'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1b4a56),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
        backgroundColor: Color(0xFF1b4a56),
        title: Image.asset(
          'assets/logo.png',
          height: 30,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the EleventhPage (combined details page)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EleventhPage(vehicleNumber: widget.vehicleNumber), // Pass the vehicle number
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Vehicle Details',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the EleventhPage (combined details page)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EleventhPage(vehicleNumber: widget.vehicleNumber), // Pass the vehicle number
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Revenue Licence',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the EleventhPage (combined details page)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EleventhPage(vehicleNumber: widget.vehicleNumber), // Pass the vehicle number
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Insurance',
                style: TextStyle(
                  color: Colors.black,
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