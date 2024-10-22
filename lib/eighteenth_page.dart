import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'fifth_page.dart';
//This is a comment


class EighteenthPage extends StatefulWidget {
  @override
  _EighteenthPageState createState() => _EighteenthPageState();
}

class _EighteenthPageState extends State<EighteenthPage> {
  bool _isSuccess = false; // Variable to track submission success
  String _errorMessage = ''; // Variable to store the error message

  @override
  void initState() {
    super.initState();
    _submitData(); // Call the submission function when the page loads
  }

  // Push the data to Firestore and handle the result
  Future<void> _submitData() async {
    try {
      // Get the data from the previous page (you'll need to pass this data)
      String fullName = 'John Doe'; // Example: Pass this data from the previous page
      String address = '123 Main Street'; // Example: Pass this data from the previous page
      String vehicleNo = 'ABC 123'; // Example: Pass this data from the previous page
      String contactNo = '555-123-4567'; // Example: Pass this data from the previous page
      String placeOffence = 'Downtown'; // Example: Pass this data from the previous page
      String selectedFine = 'Over Speeding'; // Example: Pass this data from the previous page
      String dateOfOffence = '16 August 2024'; // Example: Pass this data from the previous page
      String timeOfOffence = '10:30 AM'; // Example: Pass this data from the previous page
      String courtDate = '30 August 2024'; // Example: Pass this data from the previous page

      await FirebaseFirestore.instance.collection('GotFine').add({
        'fullName': fullName,
        'address': address,
        'vehicleNo': vehicleNo,
        'contactNo': contactNo,
        'placeOffence': placeOffence,
        'selectedFine': selectedFine,
        'dateOfOffence': dateOfOffence,
        'timeOfOffence': timeOfOffence,
        'courtDate': courtDate // Add the courtDate to the data
      });
      print('Data submitted successfully!');
      setState(() {
        _isSuccess = true;
        _errorMessage = ''; // Clear any existing error message
      });
    } catch (e) {
      print('Error submitting data: $e');
      setState(() {
        _isSuccess = false;
        _errorMessage = 'Error submitting data. Please try again.'; // Set the error message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF074D5E), // Dark blue background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display "Status: Successful"
            Text(
              'Status:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            if (_isSuccess) // Show successful message
              Text(
                'Successful',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green, // Use green for successful status
                ),
              )
            else // Show error message if submission fails
              Text(
                _errorMessage,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red, // Use red for error message
                ),
              ),
            SizedBox(height: 20),

            // Display "Reference Number"
            Text(
              'Reference Number:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '20240816245644', // Replace with a dynamic reference number
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40),

            // "MAKE ANOTHER FINE" Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE6A500),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                // Navigate to the FifthPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FifthPage()),
                );
              },
              child: Text(
                'MAKE ANOTHER FINE',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            SizedBox(height: 20),

            // "EXIT" Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE6A500),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                // Show the confirmation dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Exit App'),
                      content: Text('Are you sure you want to exit?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Exit the app
                            SystemNavigator.pop(); // Close the dialog
                            // Implement the actual exit logic here (e.g., SystemNavigator.pop())
                            // Be aware of platform differences for exiting.
                          },
                          child: Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                'EXIT',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
