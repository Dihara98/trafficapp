// this is for fifteen_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  Future<Map<String, dynamic>?> fetchDriverDetails(String vehicleNumber) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('DrivingLicence')
          .where('vehicleNumber', isEqualTo: vehicleNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final driverData = querySnapshot.docs.first.data() as Map<String, dynamic>;
        return driverData;
      }
    } catch (e) {
      print('Error fetching driver details: $e');
    }
    return null;
  }
}
