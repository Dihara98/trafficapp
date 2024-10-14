import 'package:flutter/material.dart';
import 'firebase_service.dart';

class FifteenPage extends StatefulWidget {
  @override
  _FifteenPageState createState() => _FifteenPageState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _FifteenPageState extends State<FifteenPage> {
  final FirebaseService _firebaseService = FirebaseService();
  String driverName = '';
  String driverAddress = '';

  Future<void> fetchDriverDetails(String vehicleNumber) async {
    final driverData = await _firebaseService.fetchDriverDetails(vehicleNumber);
    if (driverData != null) {
      setState(() {
        driverName = driverData['fullName'] ?? '';
        driverAddress = driverData['address'] ?? '';
      });
    }
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
                DropdownMenuItem(
                  child: Text("5. Driving Special Purpose Vehicles without a license."),
                  value: "5",
                ),
                DropdownMenuItem(
                  child: Text("6. Driving a vehicle loaded with chemicals / hazardous waste without a license."),
                  value: "6",
                ),
                DropdownMenuItem(
                  child: Text("7. Not having a license to drive a specific class of vehicles."),
                  value: "7",
                ),
                DropdownMenuItem(
                  child: Text("8. Not carrying D.L."),
                  value: "8",
                ),
                DropdownMenuItem(
                  child: Text("9. Not having an instructor's license."),
                  value: "9",
                ),
                DropdownMenuItem(
                  child: Text("10. Contrvening Speed Limits."),
                  value: "10",
                ),
                DropdownMenuItem(
                  child: Text("11. Disobeying Road Rules"),
                  value: "11",
                ),
                DropdownMenuItem(
                  child: Text("12. Activities obstructing control of the motor vehicle."),
                  value: "12",
                ),
                DropdownMenuItem(
                  child: Text("13. Signals by Driver"),
                  value: "13",
                ),
                DropdownMenuItem(
                  child: Text("14. Reversing for a long Distance."),
                  value: "14",
                ),
                DropdownMenuItem(
                  child: Text("15. Sound or Light warnings"),
                  value: "15",
                ),
                DropdownMenuItem(
                  child: Text("16. Excessive emission of smoke, etc."),
                  value: "16",
                ),
                DropdownMenuItem(
                  child: Text("17. Riding on running boards"),
                  value: "17",
                ),
                DropdownMenuItem(
                  child: Text("18. No. of persons in front seats"),
                  value: "18",
                ),
                DropdownMenuItem(
                  child: Text("19. Non-use of seat belts."),
                  value: "19",
                ),
                DropdownMenuItem(
                  child: Text("20. Not wearing protective helmets"),
                  value: "20",
                ),
                DropdownMenuItem(
                  child: Text("Distribution of Advertisement"),
                  value: "21",
                ),
                DropdownMenuItem(
                  child: Text("Excessive use of Noise"),
                  value: "22",
                ),
                DropdownMenuItem(
                  child: Text("Disobeying Directions & Signals of Police Officers / Traffic Wardens"),
                  value: "23",
                ),
                DropdownMenuItem(
                  child: Text("Non-Compliance with Traffic Signals"),
                  value: "24",
                ),
                DropdownMenuItem(
                  child: Text("Failure to take precautions when discharging fuel into tank"),
                  value: "25",
                ),
                DropdownMenuItem(
                  child: Text("Halting or Parking"),
                  value: "26",
                ),
                DropdownMenuItem(
                  child: Text("Non-use of precations when parking"),
                  value: "27",
                ),
                DropdownMenuItem(
                  child: Text("Excessive carriage of persons in motor car or private coach"),
                  value: "28",
                ),
                DropdownMenuItem(
                  child: Text("Carriage of passengers in excess in omnibuses"),
                  value: "29",
                ),
                DropdownMenuItem(
                  child: Text("Carriage on lorry or Motor Tricycle van of goods in excess"),
                  value: "30",
                ),
                DropdownMenuItem(
                  child: Text("No. of persons carried in a lorry"),
                  value: "31",
                ),
                DropdownMenuItem(
                  child: Text("Violations of Regulations on motor vehicles"),
                  value: "32",
                ),
                DropdownMenuItem(
                  child: Text("Failure to carry the Emission certificate or the Fitness Certificate"),
                  value: "33",
                ),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Vehicle Number',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.white24,
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Contact Number',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.white24,
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE6A500), // Updated to backgroundColor
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                // Handle button press, e.g., navigate to next page
              },
              child: const Text(
                'NEXT',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF1b4a56), // Dark blue background
    );
  }
}
