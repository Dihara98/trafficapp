import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'sixteen_and_seventeen_page.dart';
//This is a comment

class FifteenPage extends StatefulWidget {
  final String dlNo;
  final String vehicleNo;

  FifteenPage({required this.dlNo, required this.vehicleNo});

  @override
  _FifteenPageState createState() => _FifteenPageState();
}

class _FifteenPageState extends State<FifteenPage> {
  final TextEditingController _contactNo = TextEditingController();
  final TextEditingController _placeOffence = TextEditingController();
  //String? _selectedItem;
  String? _selectedFineId;
  String? _errorMessage;
  Map<String, dynamic>? driverDetails;
  Map<String, dynamic>? vehicleDetails;
  String? errorMessage;

  List<Map<String, dynamic>> fines = [];

  @override
  void initState() {
    super.initState();
    _fetchDriverDetails();
    _fetchVehicleDetails();
    _fetchFines();
  }

  Future<void> _fetchDriverDetails() async {
    try {

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('DrivingLicence')
          .where('dlNo', isEqualTo: widget.dlNo)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {

          driverDetails = querySnapshot.docs.first.data() as Map<String, dynamic>?;
          errorMessage = null;
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



  Future<void> _fetchVehicleDetails() async {
    try {

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('VehicleDetails')
          .where('vehicleNo', isEqualTo: widget.vehicleNo)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {

          vehicleDetails = querySnapshot.docs.first.data() as Map<String, dynamic>?;
          errorMessage = null;
        });
      } else {
        setState(() {
          vehicleDetails = null;
          errorMessage = 'No details found for the entered Vehicle Number.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error retrieving data: $e';
        driverDetails = null;
      });
    }
  }

  Future<void> _fetchFines() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Fines')
          .get();

      setState(() {
        fines = querySnapshot.docs.map((doc) {
          return {
            'fineId': doc['fineId'],
            'fineName': doc['fineName'],
          };
        }).toList();
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error retrieving fines: $e';
      });
    }
  }


  void _goToNextPage() {
    //String vehicleNo = _vehicleNo.text;
    String contactNo = _contactNo.text;
    String placeOffence = _placeOffence.text;

    if (_selectedFineId == null || contactNo.isEmpty || placeOffence.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill all fields';
      });
      return;
    }


    Navigator.push(
      context,
      MaterialPageRoute(

        builder: (context) => SixteenAndSeventeenPage(
          dlNo: widget.dlNo,
          vehicleNo: widget.vehicleNo,
          selectedFineId: _selectedFineId!,
          contactNo: contactNo,
          placeOffence: placeOffence,
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
              onChanged: (value) {
                setState(() {
                  _selectedFineId = value;
                });
              },
              items: fines.map<DropdownMenuItem<String>>((fine) {
                return DropdownMenuItem<String>(
                  value: fine['fineId'].toString(),
                  child: Text(fine['fineName']),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            /*TextField(
              controller: _vehicleNo,
              decoration: InputDecoration(
                labelText: 'Vehicle Number',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.white24,
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),*/
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
              controller: _placeOffence,
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