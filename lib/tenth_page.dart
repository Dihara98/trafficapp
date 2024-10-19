import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'fifteen_page.dart';

class TenthPage extends StatefulWidget {
  final String vehicleNo;
  final String dlNo;

  TenthPage({required this.vehicleNo, required this.dlNo});

  @override
  _TenthPageState createState() => _TenthPageState();
}

class _TenthPageState extends State<TenthPage> {
  Map<String, dynamic>? vehicleDetails;
  Map<String, dynamic>? revenueLicenseDetails;
  Map<String, dynamic>? insuranceDetails;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchVehicleDetails();
    _fetchRevenueLicenseDetails();
    _fetchInsuranceDetails();
  }

  Future<void> _fetchVehicleDetails() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('VehicleDetails')
          .where('vehicleNo', isEqualTo: widget.vehicleNo)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          vehicleDetails = querySnapshot.docs.first.data() as Map<String, dynamic>;
        });
      } else {
        setState(() {
          vehicleDetails = null;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error retrieving vehicle details: $e';
      });
    }
  }

  Future<void> _fetchRevenueLicenseDetails() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('RevenueLicence')
          .where('vehicleNo', isEqualTo: widget.vehicleNo)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          revenueLicenseDetails = querySnapshot.docs.first.data() as Map<String, dynamic>;
        });
      } else {
        setState(() {
          revenueLicenseDetails = null;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error retrieving revenue license details: $e';
      });
    }
  }

  Future<void> _fetchInsuranceDetails() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Insuarance')
          .where('vehicleNo', isEqualTo: widget.vehicleNo)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          insuranceDetails = querySnapshot.docs.first.data() as Map<String, dynamic>;
        });
      } else {
        setState(() {
          insuranceDetails = null;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error retrieving insurance details: $e';
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1b4a56),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFF1b4a56),
        title: Image.asset(
          'assets/logo.png',
          height: 30,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),

            _buildSectionCard(
              title: "Vehicle Details",
              details: vehicleDetails,
              fields: [
                _buildDataField("Registration Number", vehicleDetails?['vehicleNo']),
                _buildDataField("Name of the current owner", vehicleDetails?['fullName']),
                _buildDataField("Address of the current owner", vehicleDetails?['address']),
                _buildDataField("Engine number", vehicleDetails?['engineNo']),
                _buildDataField("Vehicle class", vehicleDetails?['vehicleClass']),
                _buildDataField("Conditions and notes", vehicleDetails?['conditionsAndNotes']),
                _buildDataField("Make", vehicleDetails?['make']),
                _buildDataField("Year of manufacture", vehicleDetails?['yearOfManufacture']),
                _buildDataField("Date of registration", formatTimestamp(vehicleDetails?['dateOfRegistrationVehicle'])),
                _buildDataField("Engine capacity", vehicleDetails?['engineCapacity']),
                _buildDataField("Fuel type", vehicleDetails?['fuelType']),
                _buildDataField("Status when registered", vehicleDetails?['status']),
                _buildDataField("CR Type", vehicleDetails?['crType']),
                _buildDataField("Type of Body", vehicleDetails?['typeOfBody']),

              ],
            ),

            SizedBox(height: 20),

            _buildSectionCard(
              title: "Revenue License Details",
              details: revenueLicenseDetails,
              fields: [
                _buildDataField("Vehicle Number", revenueLicenseDetails?['vehicleNo']),
                _buildDataField("Owner’s Name", revenueLicenseDetails?['ownerName']),
                _buildDataField("User Location", revenueLicenseDetails?['userLocation']),
                _buildDataField("Reference Number", revenueLicenseDetails?['referenceNumber']),
                _buildDataField("License Duration", revenueLicenseDetails?['licenseDuration']),
                _buildDataField("Amount", revenueLicenseDetails?['amount']),
                _buildDataField("Payment Type", revenueLicenseDetails?['paymentType']),
                _buildDataField("Approval Code", revenueLicenseDetails?['approvalCode']),

              ],
            ),

            SizedBox(height: 20),

            // Insurance Details Section
            _buildSectionCard(
              title: "Insurance Details",
              details: insuranceDetails,
              fields: [
                _buildDataField("Vehicle Number", insuranceDetails?['vehicleNo']),
                _buildDataField("Policy Number", insuranceDetails?['policyNo']),
                _buildDataField("Period of Cover", _buildPeriodOfCover()),
                _buildDataField("Policy Holder", insuranceDetails?['fullName']),
                _buildDataField("Address", insuranceDetails?['address']),
                _buildDataField("Issued Date", formatTimestamp(insuranceDetails?['dateOfIssueInsuarance'])),
                _buildDataField("Contract Type", insuranceDetails?['contractType']),
                _buildDataField("Vehicle Use", insuranceDetails?['vehicleUse']),
              ],
            ),
            // "FINES" Button
            ElevatedButton(
              onPressed: () {
                // Navigate to the fifteen.dart page (you'll need to create this page)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FifteenPage(dlNo: widget.dlNo,vehicleNo: widget.vehicleNo),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.yellow, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'FINES',
                style: TextStyle(
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

  Widget _buildSectionCard({required String title, Map<String, dynamic>? details, required List<Widget> fields}) {
    return Card(
      color: Color(0xFF12343b),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: details != null
                ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: fields)
                : Text("No details found", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return 'N/A';
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return DateFormat('dd MMMM yyyy').format(date);
  }


  String _buildPeriodOfCover() {
    if (insuranceDetails != null) {
      Timestamp? fromTimestamp = insuranceDetails!['from'];
      Timestamp? toTimestamp = insuranceDetails!['to'];

      if (fromTimestamp != null && toTimestamp != null) {
        DateTime fromDate = fromTimestamp.toDate();
        DateTime toDate = toTimestamp.toDate();

        String formattedFrom = DateFormat('dd MMMM yyyy').format(fromDate);
        String formattedTo = DateFormat('dd MMMM yyyy').format(toDate);

        return '$formattedFrom - $formattedTo';
      }
    }
    return 'N/A';
  }

}
