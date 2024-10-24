import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sltrafficapp/twenty_seven_page.dart';
//import 'package:sltrafficapp/twenty_five_page.dart';
import 'package:sltrafficapp/twenty_six_page.dart';
import 'package:sltrafficapp/twenty_third_page.dart';
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

                SizedBox(height: 80),

                // Revenue Number Button
                ElevatedButton(
                  onPressed: () {
                    // Pass vehicleNo when navigating to TwentyFivePage
                    // Remove this section since we're not getting the vehicle number
                    //String vehicleNumber = _vehicleNoController.text.trim();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TwentySixPage(vehicleNo: vehicleNo)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Revenue Number',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Insurance Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TwentySevenPage(vehicleNo: vehicleNo), // Pass userData
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Insuarance',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
