void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LicenseInfoScreen(),
    );
  }
}

class LicenseInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF124248), // Dark background color
      appBar: AppBar(
        backgroundColor: Color(0xFF124248),
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
            Text(
              'Number of the Licence:',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              'B3185356',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'NIC No:',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '986511768V',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Full Name:',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              'Kahandugoda Manage Dilhara Madhushani',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Address:',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              'No 550, Kudagama, Maho',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Date of Birth:',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '30th August 1998',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Date of Issue of the Licence:',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '12th of May 2018',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Date of Expiry of the Licence:',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '12th of May 2026',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Blood Group:',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              'O+',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                  primary: Color(0xFFF2C200), // Yellow button color
                ),
                onPressed: () {
                  // Handle button press
                },
                child: Text(
                  'FINES',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

