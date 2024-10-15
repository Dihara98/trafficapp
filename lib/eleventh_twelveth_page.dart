import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'fifteen_page.dart';

class EleventhPage extends StatefulWidget {
  final String vehicleNumber;

  EleventhPage({required this.vehicleNumber});

  @override
  _EleventhPageState createState() => _EleventhPageState();
}

class _EleventhPageState extends State<EleventhPage> {
  // Data to hold details from all three databases
  Map<String, dynamic>? vehicleDetails;
  Map<String, dynamic>? revenueLicenseDetails;
  Map<String, dynamic>? insuranceDetails;
  String? errorMessage;

  // Fetch data from all databases when the page loads
  @override
  void initState() {
    super.initState();
    _fetchVehicleDetails();
    _fetchRevenueLicenseDetails();
    _fetchInsuranceDetails();
  }

  Future<void> _fetchVehicleDetails() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('VehicleDetails') // Vehicle Details collection
          .where('vehicleNo', isEqualTo: widget.vehicleNumber) // Use 'vehicleNo' here
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          vehicleDetails = querySnapshot.docs.first.data() as Map<String, dynamic>;
          errorMessage = null;
        });
      } else {
        setState(() {
          vehicleDetails = null;
          errorMessage = 'No vehicle details found.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error retrieving vehicle data: $e';
        vehicleDetails = null;
      });
    }
  }

  Future<void> _fetchRevenueLicenseDetails() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('RevenueLicence') // Revenue Licence collection
          .where('vehicleNo', isEqualTo: widget.vehicleNumber) // Use 'vehicleNo' here
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          revenueLicenseDetails = querySnapshot.docs.first.data() as Map<String, dynamic>;
          errorMessage = null;
        });
      } else {
        setState(() {
          revenueLicenseDetails = null;
          errorMessage = 'No revenue license details found.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error retrieving revenue license data: $e';
        revenueLicenseDetails = null;
      });
    }
  }

  Future<void> _fetchInsuranceDetails() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Insurance') // Insurance collection
          .where('vehicleNo', isEqualTo: widget.vehicleNumber) // Use 'vehicleNo' here
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          insuranceDetails = querySnapshot.docs.first.data() as Map<String, dynamic>;
          errorMessage = null;
        });
      } else {
        setState(() {
          insuranceDetails = null;
          errorMessage = 'No insurance details found.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error retrieving insurance data: $e';
        insuranceDetails = null;
      });
    }
  }

  Widget _buildDataField(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value ?? 'N/A',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display Vehicle Details Section
              if (vehicleDetails != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDataField('Vehicle Registration No:', vehicleDetails!['vehicleNo']), // Change to 'vehicleNo'
                    _buildDataField('Name of the current owner:', vehicleDetails!['ownerName']),
                    _buildDataField('Address of the current owner:', vehicleDetails!['ownerAddress']),
                    _buildDataField('Engine number:', vehicleDetails!['engineNumber']),
                    _buildDataField('Vehicle class:', vehicleDetails!['vehicleClass']),
                    _buildDataField('Conditions and notes:', vehicleDetails!['conditions']),
                    _buildDataField('Make:', vehicleDetails!['make']),
                    _buildDataField('Model:', vehicleDetails!['model']),
                    _buildDataField('Year of manufacture:', vehicleDetails!['yearOfManufacture']),
                    _buildDataField('Date of registration:', vehicleDetails!['registrationDate']),
                    _buildDataField('Engine capacity:', vehicleDetails!['engineCapacity']),
                    _buildDataField('Fuel type:', vehicleDetails!['fuelType']),
                    _buildDataField('Status when registered:', vehicleDetails!['status']),
                    _buildDataField('CR Type:', vehicleDetails!['crType']),
                    _buildDataField('Type of Body:', vehicleDetails!['bodyType']),
                    SizedBox(height: 20),
                  ],
                )
              else
                Text('No vehicle details found.'),

              // Display Revenue License Details Section
              if (revenueLicenseDetails != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDataField('Revenue License Number:', revenueLicenseDetails!['revenueLicenseNumber']),
                    _buildDataField('Expiry Date:', revenueLicenseDetails!['expiryDate']),
                    SizedBox(height: 20),
                  ],
                )
              else
                Text('No revenue license details found.'),

              // Display Insurance Details Section
              if (insuranceDetails != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDataField('Insurance Policy Number:', insuranceDetails!['insurancePolicyNumber']),
                    _buildDataField('Expiry Date:', insuranceDetails!['expiryDate']),
                    SizedBox(height: 20),
                  ],
                )
              else
                Text('No insurance details found.'),

              // "FINES" Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to the fifteen.dart page (you'll need to create this page)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FifteenPage(),
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
                  'FINES',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder page for displaying fines information
class FinesPage extends StatelessWidget {
  final String vehicleNumber;

  FinesPage({required this.vehicleNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fines')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Fines Details for Vehicle: $vehicleNumber'),
            // ... Add UI elements to display fines details
          ],
        ),
      ),
    );
  }
}