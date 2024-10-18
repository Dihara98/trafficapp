import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SixteenAndSeventeenPage extends StatefulWidget {
  final String dlNo;
  final String vehicleNo;
  final String contactNo;
  final String placeOffence;
  final String selectedFine;

  SixteenAndSeventeenPage({
    required this.vehicleNo,
    required this.contactNo,
    required this.dlNo,
    required this.placeOffence,
    required this.selectedFine,
  });

  @override
  _SixteenAndSeventeenPageState createState() => _SixteenAndSeventeenPageState();
}

class _SixteenAndSeventeenPageState extends State<SixteenAndSeventeenPage> {
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

  Future<void> _fetchDrivingLicence() async {
    try {

      QuerySnapshot driverDoc = await FirebaseFirestore.instance
          .collection('DrivingLicence')
          .where('dlNo', isEqualTo: widget.dlNo)
          .get();

      if (driverDoc.docs.isNotEmpty) {

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

      setState(() {
        isLoading = false;
      });
    }
  }


  void _getCurrentDateTime() {
    DateTime now = DateTime.now();
    setState(() {
      dateOfOffence = DateFormat('dd MMMM yyyy').format(now);
      timeOfOffence = DateFormat('hh:mm a').format(now);
    });
  }


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
      backgroundColor: Color(0xFF074D5E),
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
                color: Colors.white,
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
                    color: Colors.black, 
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
