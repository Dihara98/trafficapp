import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For Firestore
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'dart:io';

class TwentyEightPage extends StatefulWidget {
  final String userName; // Pass the user data
  TwentyEightPage({required this.userName});

  @override
  _TwentyEightPageState createState() => _TwentyEightPageState();
}

class _TwentyEightPageState extends State<TwentyEightPage> {
  List<Map<String, dynamic>> fineDataList = []; // List to store fine data

  Future<void> fetchGotFineData(String userName) async {
    try {
      QuerySnapshot driverLicenceSnapshot = await FirebaseFirestore.instance
          .collection('DrivingLicence')
          .where('userName', isEqualTo: userName)
          .get();

      if (driverLicenceSnapshot.docs.isNotEmpty) {
        String dlNo = driverLicenceSnapshot.docs.first['dlNo'];
        print('Fetched dlNo: $dlNo');

        QuerySnapshot gotFineSnapshot = await FirebaseFirestore.instance
            .collection('GotFine')
            .where('dlNo', isEqualTo: dlNo)
            .get();

        if (gotFineSnapshot.docs.isNotEmpty) {
          setState(() {
            fineDataList = gotFineSnapshot.docs
                .map((doc) => {
              'fullName': doc['fullName'] ?? 'N/A',
              'vehicleNo': doc['vehicleNo'] ?? 'N/A',
              'dateOfOffence': doc['dateOfOffence'] ?? 'N/A',
              'timeOfOffence': doc['timeOfOffence'] ?? 'N/A',
              'placeOffence': doc['placeOffence'] ?? 'N/A',
              'selectedFine': doc['selectedFine'] ?? 'N/A',
              'courtDate': doc['courtDate'] ?? 'N/A',
            })
                .toList();
          });
        } else {
          print('No fines found for this dlNo.');
        }
      } else {
        print('Driver not found for this userName.');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> generatePdf(Map<String, dynamic> fineData) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Fine Details", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text("Full Name: ${fineData['fullName']}"),
            pw.Text("Vehicle No: ${fineData['vehicleNo']}"),
            pw.Text("Date of Offence: ${fineData['dateOfOffence']}"),
            pw.Text("Time of Offence: ${fineData['timeOfOffence']}"),
            pw.Text("Place of Offence: ${fineData['placeOffence']}"),
            pw.Text("Selected Fine: ${fineData['selectedFine']}"),
            pw.Text("Court Date: ${fineData['courtDate']}"),
          ],
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/fine_details_${fineData['vehicleNo']}.pdf");
    await file.writeAsBytes(await pdf.save());

    // Open the PDF file after saving it
    await OpenFilex.open(file.path);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("PDF downloaded and opened successfully for ${fineData['vehicleNo']}!")),
    );
  }

  Future<void> uploadPdf(Map<String, dynamic> fineData) async {
    // Implement your PDF upload logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Upload PDF feature is not implemented yet for ${fineData['vehicleNo']}.")),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchGotFineData(widget.userName); // Call the fetch method on initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF074D5E),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: fineDataList.length,
                    itemBuilder: (context, index) {
                      final fine = fineDataList[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Full Name: ${fine['fullName']}', style: TextStyle(color: Colors.white)),
                          Text('Vehicle No: ${fine['vehicleNo']}', style: TextStyle(color: Colors.white)),
                          Text('Date of Offence: ${fine['dateOfOffence']}', style: TextStyle(color: Colors.white)),
                          Text('Time of Offence: ${fine['timeOfOffence']}', style: TextStyle(color: Colors.white)),
                          Text('Place of Offence: ${fine['placeOffence']}', style: TextStyle(color: Colors.white)),
                          Text('Selected Fine: ${fine['selectedFine']}', style: TextStyle(color: Colors.white)),
                          Text('Court Date: ${fine['courtDate']}', style: TextStyle(color: Colors.white)),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  await generatePdf(fine);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                ),
                                child: Text(
                                  'Download PDF',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await uploadPdf(fine);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                ),
                                child: Text(
                                  'Upload PDF',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
