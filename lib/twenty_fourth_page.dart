import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//This is a comment

class TwentyFourthPage extends StatelessWidget {
  final String vehicleNo;

  TwentyFourthPage({required this.vehicleNo});

  Future<Map<String, dynamic>?> _fetchVehicleDetails() async {
    try {

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('VehicleDetails')
          .where('vehicleNo', isEqualTo: vehicleNo)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data() as Map<String, dynamic>?;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching vehicle details: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF074D5E),
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
            child: Image.asset('assets/logo.png', width: 40),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _fetchVehicleDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error fetching vehicle details',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text(
                'No details found for this vehicle number',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          }


          Map<String, dynamic> vehicleDetails = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailField('Vehicle Registration No', vehicleDetails['vehicleNo']),
                _buildDetailField('Engine Number', vehicleDetails['engineNo']),
                _buildDetailField('Vehicle Class', vehicleDetails['vehicleClass']),
                _buildDetailField('Conditions and Notes', vehicleDetails['conditionsAndNotes']),
                _buildDetailField('Make', vehicleDetails['make']),
                _buildDetailField('Model', vehicleDetails['model']),
                _buildDetailField('Year of Manufacture', vehicleDetails['yearOfManufacture']),
              ],
            ),
          );
        },
      ),
    );
  }


  Widget _buildDetailField(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        '$label: ${value ?? 'N/A'}',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
