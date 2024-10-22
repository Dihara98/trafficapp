import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For Firestore
//import 'package:sltrafficapp/twenty_nine_page.dart'; // Import the TwentyNinePage
//This is a comment

class TwentyEightPage extends StatefulWidget {
  final Map<String, dynamic> userData; // Pass the user data
  TwentyEightPage({required this.userData});

  @override
  _TwentyEightPageState createState() => _TwentyEightPageState();
}

class _TwentyEightPageState extends State<TwentyEightPage> {
  int pendingFinesCount = 0;
  String pendingFineAmount = 'Rs. 0.00';

  @override
  void initState() {
    super.initState();
    _fetchFineData();
  }

  Future<void> _fetchFineData() async {
    try {
      // Fetch fine data from Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('GotFine')
          .where('dlNo', isEqualTo: widget.userData['dlNo']) // Query by the logged-in user's dlNo
          .get();

      int fineCount = querySnapshot.docs.length;
      double totalFineAmount = 0;

      for (var doc in querySnapshot.docs) {
        totalFineAmount += doc['fineAmount'].toDouble(); // Assuming a 'fineAmount' field exists
      }

      setState(() {
        pendingFinesCount = fineCount;
        pendingFineAmount = 'Rs. ${totalFineAmount.toStringAsFixed(2)}';
      });
    } catch (e) {
      print('Error fetching fine data: $e');
    }
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
              mainAxisAlignment: MainAxisAlignment.center,
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
                Text(
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
                SizedBox(height: 40),

                // History Button
                ElevatedButton(
                  onPressed: () {
                    //Navigator.push(
                      //context,
                      //MaterialPageRoute(builder: (context) => TwentyNinePage(userData: widget.userData)),
                    //);
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ... (Your other pages) ...