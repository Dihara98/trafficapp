import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Firestore package
import 'package:intl/intl.dart';
import 'eighteenth_page.dart';

class SixteenAndSeventeenPage extends StatefulWidget {
  final String dlNo;
  final String vehicleNo;
  final String contactNo;
  final String placeOffence;
  final String selectedFineId; // Accept the selected fine

  SixteenAndSeventeenPage({
    required this.vehicleNo,
    required this.contactNo,
    required this.dlNo,
    required this.placeOffence,
    required this.selectedFineId,
  });

  @override
  _SixteenPageState createState() => _SixteenPageState();
}

class _SixteenPageState extends State<SixteenAndSeventeenPage> {
  String fullName = '';
  String address = '';
  String dateOfOffence = '';
  String timeOfOffence = '';
  String courtDate = '';
  bool isLoading = true;
  late String vehicleNo;
  String? fineName;
  double? fineValue;
  Timestamp? validFromDate;
  Timestamp? validToDate;
  bool cleared = false;
  String pdfUrl = '';

  @override
  void initState() {
    super.initState();
    _fetchDrivingLicence();
    _getCurrentDateTime();
    _fetchVehicleDetails();
    _fetchFineDetails();
  }

  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return 'N/A';
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return DateFormat('dd MMMM yyyy').format(date); // Only show date
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
          validFromDate = driverDoc.docs.first['dateOfIssue'] as Timestamp?;
          validToDate = driverDoc.docs.first['dateOfExpiry'] as Timestamp?;
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

  Future<void> _fetchVehicleDetails() async {
    try {
      QuerySnapshot vehicleDoc = await FirebaseFirestore.instance
          .collection('VehicleDetails')
          .where('VehicleNo', isEqualTo: widget.vehicleNo)
          .get();

      if (vehicleDoc.docs.isNotEmpty) {
        setState(() {
          vehicleNo = vehicleDoc.docs.first['vehicleNo'];
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

  Future<void> _fetchFineDetails() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Fines')
          .where('fineId', isEqualTo: widget.selectedFineId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          fineName = querySnapshot.docs.first['fineName'];
          fineValue = querySnapshot.docs.first['fineValue'].toDouble();
        });
      }
    } catch (e) {
      setState(() {
        fineName = 'Error retrieving fine name';
        fineValue = 0.0;
      });
    }
  }

  void _getCurrentDateTime() {
    DateTime now = DateTime.now();
    setState(() {
      dateOfOffence = DateFormat('dd MMMM yyyy').format(now);
      timeOfOffence = DateFormat('hh:mm a').format(now);
      DateTime courtDateDateTime = now.add(Duration(days: 14));
      courtDate = DateFormat('dd MMMM yyyy').format(courtDateDateTime);
    });
  }

  Future<void> _submitAndNavigate() async {
    try {
      await FirebaseFirestore.instance.collection('GotFine').add({
        'fullName': fullName,
        'address': address,
        'dlNo': widget.dlNo,
        'vehicleNo': widget.vehicleNo,
        'contactNo': widget.contactNo,
        'placeOffence': widget.placeOffence,
        'selectedFine': widget.selectedFineId,
        'dateOfOffence': dateOfOffence,
        'timeOfOffence': timeOfOffence,
        'courtDate': courtDate,
        'cleared':false,
        'pdfUrl':'',
      });
      print('Data submitted successfully!');
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
          : SingleChildScrollView(
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
              fullName.isEmpty ? 'Driver info not available' : '$fullName\n$address',
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
            Text(
              fineName != null ? fineName! : '',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Amount:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              fineValue != null ? fineValue!.toString() : 'N/A',
              style: TextStyle(color: Colors.white),
            ),
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
              'Valid:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'From ${validFromDate != null ? formatTimestamp(validFromDate) : 'N/A'}',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'To ${validToDate != null ? formatTimestamp(validToDate) : 'N/A'}',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              'Court Date:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(courtDate, style: TextStyle(color: Colors.white)),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _submitAndNavigate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  fixedSize: Size(100, 50),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  'CONFIRM',
                  style: TextStyle(
                    color: Colors.white,
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
