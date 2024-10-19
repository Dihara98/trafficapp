import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'nineth_page.dart';

class DrivingLicensePage extends StatefulWidget {
  final String dlNo;


  DrivingLicensePage({required this.dlNo});

  @override
  _DrivingLicensePageState createState() => _DrivingLicensePageState();
}

class _DrivingLicensePageState extends State<DrivingLicensePage> {
  String? errorMessage;
  Map<String, dynamic>? driverDetails;

  @override
  void initState() {
    super.initState();
    _fetchDriverDetails();
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            if (driverDetails != null)
              Expanded(
                child: SingleChildScrollView(
                 child: Card(
                  color: Color(0xFF074D5E),
                  margin: EdgeInsets.only(top: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDataField('Driving License Number', widget.dlNo),
                        _buildDataField('NIC No', driverDetails!['NIC']),
                        _buildDataField('Full Name', driverDetails!['fullName']),
                        _buildDataField('Address', driverDetails!['address']),
                        _buildDataField('Date of Birth', formatTimestamp(driverDetails!['dateOfBirth'])),
                        _buildDataField('Date of Issue of the License', formatTimestamp(driverDetails!['dateOfIssue'])),
                        _buildDataField('Date of Expiry of the License', formatTimestamp(driverDetails!['dateOfExpiry'])),
                        _buildDataField('Blood Group', driverDetails!['bloodGroup']),
                        SizedBox(height: 16.0), // Add some space
                        Text(
                          'Vehicle Categories:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        _buildVehicleCategoriesTable(driverDetails!['vehicleCategories']),
                      ],
                    ),
                  ),
                ),
               ),
              ),
            ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NinethPage(dlNo: widget.dlNo),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Vehicle Number',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildDataField(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        '$label: $value',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }


  Widget _buildVehicleCategoriesTable(Map<String, dynamic> vehicleCategories) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 10.0,
        columns: const [
          DataColumn(label: Text('Category', style: TextStyle(color: Colors.white))),
          DataColumn(label: Text('Date of Issue', style: TextStyle(color: Colors.white))),
          DataColumn(label: Text('Date of Expiry', style: TextStyle(color: Colors.white))),
        ],
        rows: vehicleCategories.entries.map((entry) {
          Map<String, dynamic> categoryData = entry.value;
          return DataRow(cells: [
            DataCell(Text(entry.key, style: TextStyle(color: Colors.white))),
            DataCell(Text(categoryData['dateOfIssue'] != null
                ? formatTimestamp(categoryData['dateOfIssue'])
                : 'N/A', style: TextStyle(color: Colors.white))),
            DataCell(Text(categoryData['dateOfExpiry'] != null
                ? formatTimestamp(categoryData['dateOfExpiry'])
                : 'N/A', style: TextStyle(color: Colors.white))),
          ]);
        }).toList(),
      ),
    );
  }

  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return 'N/A';
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return DateFormat('dd MMMM yyyy').format(date); // Only show date
  }
}
