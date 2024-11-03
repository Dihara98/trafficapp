import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For Firestore

class TwentyEightPage extends StatefulWidget {
  final String userName; // Pass the user data
  TwentyEightPage({required this.userName});


  @override
  _TwentyEightPageState createState() => _TwentyEightPageState();
}

class _TwentyEightPageState extends State<TwentyEightPage> {
  //int pendingFinesCount = 0;
  //String pendingFineAmount = 'Rs. 0.00';
  List<Map<String, dynamic>> fineDataList = []; // List to store fine data

  Future<void> fetchGotFineData(String userName) async {
    try {
      // Step 1: Fetch Driver details to get dlNo
      QuerySnapshot driverLicenceSnapshot = await FirebaseFirestore.instance
          .collection('DrivingLicence')
          .where('userName', isEqualTo: userName)
          .get();


      if (driverLicenceSnapshot.docs.isNotEmpty) {
        // Assuming the first document contains the relevant data
        String dlNo = driverLicenceSnapshot.docs.first['dlNo'];
        print('Fetched dlNo: $dlNo');

        // Step 2: Fetch Gotfine data using dlNo
        QuerySnapshot gotFineSnapshot = await FirebaseFirestore.instance
            .collection('GotFine')
            .where('dlNo', isEqualTo: dlNo)
            .get();

        if (gotFineSnapshot.docs.isNotEmpty) {


          Future<int> countDocumentsWithDlNo(String dlNo) async {
            QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                .collection('GotFine')
                .where('dlNo', isEqualTo: dlNo)
                .get();

            return querySnapshot.docs.length;
          }

          int count = await countDocumentsWithDlNo('dlNo');
          print('Number of documents with dlNo ABC123: $count');



          // Store all fines in fineDataList
          setState(() {
            // pendingFinesCount = gotFineSnapshot.docs.length; // Count of pending fines
            //pendingFineAmount = 'Rs. ${(gotFineSnapshot.docs.fold(0.0, (sum, doc) {
            //var fineAmount = doc['fineAmount'];
            /*&if (fineAmount is num) {
                return sum + fineAmount; // If it's a number, add it to the sum
              } else if (fineAmount is String) {
                // Try parsing the string to a double, default to 0.0 if parsing fails
                return sum + (double.tryParse(fineAmount) ?? 0.0);
              }
              return sum; // If neither num nor valid string, ignore the value
            })).toStringAsFixed(2)}'   */

            // Collect fine data for display
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
                // Back button in the top left corner
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

                // Display Pending Fines
                /*   Text(
                  'Pending Fines: $pendingFinesCount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),

                // Display Pending Fine Amount
                Text(
                 'Pending Fine Amount: $pendingFineAmount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
*/
                // Display Pending Fines Details
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
                          SizedBox(height: 10), // Add some space between fines
                        ],
                      );
                    },
                  ),
                ),

                SizedBox(height: 20),

                // History Button
                /*ElevatedButton(
                  onPressed: () {
                    // Navigate to the history page
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => TwentyNinePage(userData: widget.userData)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'History',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}