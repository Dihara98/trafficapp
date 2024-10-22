import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sltrafficapp/twenty_fourth_page.dart';
//This is a comment

class TwentyThirdPage extends StatefulWidget {
  @override
  _TwentyThirdPageState createState() => _TwentyThirdPageState();
}

class _TwentyThirdPageState extends State<TwentyThirdPage> {
  final _formKey = GlobalKey<FormState>();
  String? name, nicNo, contactNo, vehicleNo;
  String? errorMessage;

  Future<void> _checkVehicleRegistration() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('VehicleDetails')
          .where('vehicleNo', isEqualTo: vehicleNo)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TwentyFourthPage(vehicleNo: vehicleNo!),
          ),
        );
      } else {
        setState(() {
          errorMessage = 'Vehicle Registration Number not found!';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error checking registration: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF074D5E),
      appBar: AppBar(
        backgroundColor: Color(0xFF074D5E),
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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name', labelStyle: TextStyle(color: Colors.white)),
                style: TextStyle(color: Colors.white),
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                onSaved: (value) => name = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'NIC No', labelStyle: TextStyle(color: Colors.white)),
                style: TextStyle(color: Colors.white),
                validator: (value) => value!.isEmpty ? 'Please enter your NIC No' : null,
                onSaved: (value) => nicNo = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact No', labelStyle: TextStyle(color: Colors.white)),
                style: TextStyle(color: Colors.white),
                validator: (value) => value!.isEmpty ? 'Please enter your Contact No' : null,
                onSaved: (value) => contactNo = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Vehicle Registration No', labelStyle: TextStyle(color: Colors.white)),
                style: TextStyle(color: Colors.white),
                validator: (value) => value!.isEmpty ? 'Please enter the Vehicle Registration No' : null,
                onSaved: (value) => vehicleNo = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _checkVehicleRegistration();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'SUBMIT',
                  style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
