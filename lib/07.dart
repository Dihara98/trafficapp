import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LicenseDetailsScreen(),
    );
  }
}

class LicenseDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[800], // Background color
      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LicenseDetailItem(
              label: 'Number of the Licence:',
              value: 'B3185356',
            ),
            LicenseDetailItem(
              label: 'NIC No:',
              value: '986511768V',
            ),
            LicenseDetailItem(
              label: 'Full Name:',
              value: 'Kahandugoda Manage Dilhara Madhushani',
            ),
            LicenseDetailItem(
              label: 'Address:',
              value: 'No 550, Kudagama, Maho',
            ),
            LicenseDetailItem(
              label: 'Date of Birth:',
              value: '30th August 1998',
            ),
            LicenseDetailItem(
              label: 'Date of Issue of the Licence:',
              value: '12th of May 2018',
            ),
            LicenseDetailItem(
              label: 'Date of Expiry of the Licence:',
              value: '12th of May 2026',
            ),
            LicenseDetailItem(
              label: 'Blood Group:',
              value: 'O+',
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow[700],
                  onPrimary: Colors.black,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Define the action when 'FINES' button is pressed
                },
                child: Text(
                  'FINES',
                  style: TextStyle(
                    fontSize: 18,
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

class LicenseDetailItem extends StatelessWidget {
  final String label;
  final String value;

  const LicenseDetailItem({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
