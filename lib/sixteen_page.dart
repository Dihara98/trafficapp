import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SixteenPage extends StatefulWidget {
  final String dlNo;
  final String vehicleNo;
  final String contactNo;
  final String placeOffence;
  final String selectedFine; // Accept the selected fine

  SixteenPage({
    required this.vehicleNo,
    required this.contactNo,
    required this.dlNo,
    required this.placeOffence,
    required this.selectedFine, // Accept the selected fine
  });

  @override
  _SixteenPageState createState() => _SixteenPageState();
}

class _SixteenPageState extends State<SixteenPage> {
  String fullName = '';
  String address = '';
  String dateOfOffence = '';
  String timeOfOffence = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDrivingLicence();
    _getCurrentDateTime();
  }

  // Fetch Name and Address from Firebase using the dlNo
  Future<void> _fetchDrivingLicence() async {
    try {
      // Query Firestore to find documents with the matching dlNo field
      QuerySnapshot driverDoc = await FirebaseFirestore.instance
          .collection('DrivingLicence')
          .where('dlNo', isEqualTo: widget.dlNo) // Query using the dlNo field
          .get();

      if (driverDoc.docs.isNotEmpty) {
        // If documents are found, take the first document
        setState(() {
          fullName = driverDoc.docs.first['fullName'];
          address = driverDoc.docs.first['address'];
        });
      } else {
        print('Driver not found!');
      }
    } catch (e) {
      print('Error fetching driver info: $e');
    } finally {
      // Always set isLoading to false, whether the document was found or not
      setState(() {
        isLoading = false;
      });
    }
  }

  // Get Current Date and Time
  void _getCurrentDateTime() {
    DateTime now = DateTime.now();
    setState(() {
      dateOfOffence = DateFormat('dd MMMM yyyy').format(now);
      timeOfOffence = DateFormat('hh:mm a').format(now);
    });
  }

  // Push the data to Firestore
  Future<void> _submitData() async {
    try {
      await FirebaseFirestore.instance.collection('GotFine').add({
        'fullName': fullName,
        'address': address,
        'vehicleNo': widget.vehicleNo,
        'contactNo': widget.contactNo,
        'placeOffence': widget.placeOffence,
        'selectedFine': widget.selectedFine,
        'dateOfOffence': dateOfOffence,
        'timeOfOffence': timeOfOffence,
      });
      print('Data submitted successfully!');
    } catch (e) {
      print('Error submitting data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF074D5E), // Set background color
      appBar: AppBar(
        title: Text('Confirmation'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Full Name and Address of the Driver:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white, // Set text color to white
              ),
            ),
            Text(
              fullName.isEmpty
                  ? 'Driver info not available'
                  : '$fullName\n$address',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              'Vehicle No:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(widget.vehicleNo, style: TextStyle(color: Colors.white)),
            SizedBox(height: 16),
            Text(
              'Date of Offence:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(dateOfOffence, style: TextStyle(color: Colors.white)),
            SizedBox(height: 16),
            Text(
              'Time of Offence:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(timeOfOffence, style: TextStyle(color: Colors.white)),
            SizedBox(height: 16),
            Text(
              'Place of Offence:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(widget.placeOffence, style: TextStyle(color: Colors.white)),
            SizedBox(height: 16),
            Text(
              'Nature of Offence:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(widget.selectedFine, style: TextStyle(color: Colors.white)),
            SizedBox(height: 16),
            Text(
              'Contact No:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(widget.contactNo, style: TextStyle(color: Colors.white)),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _submitData, // Call the submit function
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE6A500),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  'CONFIRM',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black, // Black bold text
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
