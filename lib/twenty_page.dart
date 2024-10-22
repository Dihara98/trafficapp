import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For Firestore
import 'package:sltrafficapp/twenty_first_page.dart';
import 'package:sltrafficapp/twenty_third_page.dart';
import 'package:sltrafficapp/twenty_five_page.dart'; // Import TwentyFivePage
import 'package:sltrafficapp/twenty_seven_page.dart';
//import 'package:sltrafficapp/twenty_nine_page.dart';
//This is a comment

class TwentyPage extends StatelessWidget {
  final Map<String, dynamic> userData;
  TwentyPage({required this.userData});

  // Remove the TextEditingController here
  //final TextEditingController _vehicleNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String userName = userData['userName'] ?? '';

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

                // Driving Licence Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TwentyFirstPage(userName: userName)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Driving Licence',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Vehicle Number Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TwentyThirdPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
                SizedBox(height: 20),

                // Revenue Number Button
                ElevatedButton(
                  onPressed: () {
                    // Pass vehicleNo when navigating to TwentyFivePage
                    // Remove this section since we're not getting the vehicle number
                    //String vehicleNumber = _vehicleNoController.text.trim();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TwentyFivePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Revenue Number',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Insurance Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TwentySevenPage(userData: userData)), // Pass userData
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Insuarance',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Fine History Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TwentyNinePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Fine History',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Remove this part - You're not getting the vehicle number here.
                //SizedBox(height: 20),
                //TextField(
                //  controller: _vehicleNoController,
                //  decoration: const InputDecoration(
                //    labelText: 'Enter Vehicle Number',
                //    labelStyle: TextStyle(color: Colors.white),
                //    filled: true,
                //    fillColor: Colors.white24,
                //  ),
                //),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TwentyNinePage extends StatelessWidget {
  const TwentyNinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Police Page")),
      body: const Center(child: Text("Police Dashboard")),
    );
  }
}

/*
class TwentySevenPage extends StatelessWidget {
  const TwentySevenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Police Page")),
      body: const Center(child: Text("Police Dashboard")),
    );
  }
}
class TwentyFivePage extends StatelessWidget {
  const TwentyFivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Police Page")),
      body: const Center(child: Text("Police Dashboard")),
    );
  }
}

class TwentyThreePage extends StatelessWidget {
  const TwentyThreePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Police Page")),
      body: const Center(child: Text("Police Dashboard")),
    );
  }
}

class TwentyOnePage extends StatefulWidget {
  final Map<String, dynamic> userData;
  final String userName;
  TwentyOnePage({required this.userData, required this.userName});

  @override
  _TwentyOnePageState createState() => _TwentyOnePageState();
}

class _TwentyOnePageState extends State<TwentyOnePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driving Licence'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Driver Name: ${widget.userName}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            // ... (Other details like NIC, DL Number, etc.)
          ],
        ),
      ),
    );
  }
}*/