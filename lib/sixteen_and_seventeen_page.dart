import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Firestore package
import 'package:intl/intl.dart';
import 'eighteenth_page.dart';

class SixteenAndSeventeenPage extends StatefulWidget {
  final String dlNo;
  final String vehicleNo;
  //final String fullName;
  //final String address;
  final String contactNo;
  final String placeOffence;
  final String selectedFine; // Accept the selected fine

  SixteenAndSeventeenPage({
    required this.vehicleNo,
   // required this.fullName,
   // required this.address,
    required this.contactNo,
    required this.dlNo,
    required this.placeOffence,
    required this.selectedFine, // Accept the selected fine
  });

  @override
  _SixteenPageState createState() => _SixteenPageState();
}

class _SixteenPageState extends State<SixteenAndSeventeenPage> {
  String fullName= '';
  String address= '';
  String dateOfOffence = '';
  String timeOfOffence = '';
  String courtDate = '';
  bool isLoading = true;
  late String vehicleNo;

  @override
  void initState() {
    super.initState();
    _fetchDrivingLicence();
    _getCurrentDateTime();
    _fetchVehicleDetails();
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


  Future<void> _fetchVehicleDetails() async {
    try {
      // Query Firestore to find documents with the matching dlNo field
      QuerySnapshot vehicleDoc = await FirebaseFirestore.instance
          .collection('VehicleDetails')
          .where('VehicleNo', isEqualTo: widget.vehicleNo) // Query using the dlNo field
          .get();

      if (vehicleDoc.docs.isNotEmpty) {
        // If documents are found, take the first document
        setState(() {
          vehicleNo = vehicleDoc.docs.first['vehicleNo'];
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
      // Calculate Court Date
      DateTime courtDateDateTime = now.add(Duration(days: 14));
      courtDate = DateFormat('dd MMMM yyyy').format(courtDateDateTime);
    });
  }

  // Push the data to Firestore
  Future<void> _submitAndNavigate() async {
    try {
      await FirebaseFirestore.instance.collection('GotFine').add({
        'fullName': fullName,
        'address': address,
        'dlNo': widget.dlNo,
        'vehicleNo': widget.vehicleNo,
        'contactNo': widget.contactNo,
        'placeOffence': widget.placeOffence,
        'selectedFine': widget.selectedFine,
        'dateOfOffence': dateOfOffence,
        'timeOfOffence': timeOfOffence,
        'courtDate': courtDate
      });
      print('Data submitted successfully!');
      // Navigate to EighteenthPage after successful submission
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EighteenthPage()),
      );
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
              'Driving No:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(widget.dlNo, style: TextStyle(color: Colors.white)),
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
            SizedBox(height: 16),
            Text(
              'Court Date:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(courtDate, style: TextStyle(color: Colors.white)), // Display courtDate
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _submitAndNavigate,
                /*onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => EighteenthPage()),
                  );
                },*/
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