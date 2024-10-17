import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'sixteen_page.dart';

class FifteenPage extends StatefulWidget {
  final String dlNo; // Accepts license number as a parameter

  FifteenPage({required this.dlNo});

  @override
  _FifteenPageState createState() => _FifteenPageState();
}

class _FifteenPageState extends State<FifteenPage> {
  final TextEditingController _vehicleNo = TextEditingController();
  final TextEditingController _contactNo = TextEditingController();
  final TextEditingController _placeOffence = TextEditingController(); // Place of offence text field
  String? _selectedItem;
  String? _errorMessage;
  Map<String, dynamic>? driverDetails;
  String? errorMessage;

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
          .where('dlNo', isEqualTo: widget.dlNo) // Query using the dlNo field
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

  // Function to push data to the next page
  void _goToNextPage() {
    String vehicleNo = _vehicleNo.text;
    String contactNo = _contactNo.text;
    String placeOffence = _placeOffence.text; // Get place of offence

    if (_selectedItem == null || vehicleNo.isEmpty || contactNo.isEmpty || placeOffence.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill all fields';
      });
      return;
    }

    // Navigate to the SixteenPage with all the data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SixteenPage(
          dlNo: widget.dlNo, // Use widget.dlNo
          selectedFine: _selectedItem!,
          vehicleNo: vehicleNo,
          contactNo: contactNo,
          placeOffence: placeOffence, // Pass the place of offence
        ),
      ),
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
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Select Fine',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.white24,
              ),
              items: const [
                DropdownMenuItem(
                  child: Text("1. Identification Plates"),
                  value: "1",
                ),
                DropdownMenuItem(
                  child: Text("2. Not Carrying R.L"),
                  value: "2",
                ),
                DropdownMenuItem(
                  child: Text("3. Contravening R.L provisions"),
                  value: "3",
                ),
                DropdownMenuItem(
                  child: Text("4. Driving Emergency Service Vehicles & Public Service Vehicles without D.L."),
                  value: "4",
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedItem = value;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _vehicleNo,
              decoration: InputDecoration(
                labelText: 'Vehicle Number',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.white24,
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _contactNo,
              decoration: InputDecoration(
                labelText: 'Contact Number',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.white24,
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _placeOffence, // Input for place of offence
              decoration: InputDecoration(
                labelText: 'Place of Offence',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.white24,
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE6A500),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: _goToNextPage,
              child: Text(
                'NEXT',
                style: TextStyle(fontSize: 18),
              ),
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(
                    color: _errorMessage == 'Data submitted successfully!' ? Colors.green : Colors.red,
                  ),
                ),
              ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF1b4a56),
    );
  }
}
