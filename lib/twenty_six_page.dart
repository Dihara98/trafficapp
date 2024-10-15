import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TwentySixPage extends StatelessWidget {
  final String vehicleNo;

  TwentySixPage({required this.vehicleNo});

  Future<Map<String, dynamic>?> _fetchVehicleDetails() async {
    try {

      var snapshot = await FirebaseFirestore.instance
          .collection('RevenueLicence')
          .doc(vehicleNo)
          .get();

      if (snapshot.exists) {
        return snapshot.data();
      }
    } catch (e) {
      print('Error fetching vehicle details: $e');
    }
    return null;
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
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _fetchVehicleDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text('Error fetching vehicle details.'));
          }

          var vehicleData = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                InfoRow(label: 'Vehicle Number', value: vehicleNo),
                InfoRow(label: "Owner's Name", value: vehicleData['ownerName']),
                InfoRow(label: 'User Location', value: vehicleData['userLocation']),
                InfoRow(label: 'Reference Number', value: vehicleData['referenceNumber']),
                InfoRow(label: 'License Duration', value: vehicleData['licenseDuration']),
                InfoRow(label: 'Amount', value: 'Rs. ${vehicleData['amount']}'),
                InfoRow(label: 'Payment Type', value: vehicleData['paymentType']),
                InfoRow(label: 'Approval Code', value: vehicleData['approvalCode']),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE6A500), // Yellow color
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      backgroundColor: const Color(0xFF074D5E), // Dark blue background
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

