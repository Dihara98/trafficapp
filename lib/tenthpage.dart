import 'package:flutter/material.dart';

class TenthPage extends StatefulWidget {
  @override
  _TenthPageState createState() => _TenthPageState();
}

class _TenthPageState extends State<TenthPage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    VehicleDetailsPage(),
    RevenueLicensePage(),
    InsurancePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Move the BottomNavigationBar to the top
          Container(
            color: Colors.blue,
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.directions_car),
                  label: 'Vehicle Details',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt),
                  label: 'Revenue License',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.security),
                  label: 'Insurance',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,
              backgroundColor: Colors.blue,
              onTap: _onItemTapped,
            ),
          ),
          // Display the selected page content
          Expanded(
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
        ],
      ),
    );
  }
}

class VehicleDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Text("Vehicle Registration No: NW BIJ 4812", style: TextStyle(fontSize: 16)),
              Text("Owner: Kahandugoda Manage Dilhara Madhushani", style: TextStyle(fontSize: 16)),
              Text("Address: No 550, Kudagama, Maho", style: TextStyle(fontSize: 16)),
              Text("Engine Number: 4D56T456789", style: TextStyle(fontSize: 16)),
              Text("Make: Toyota ", style: TextStyle(fontSize: 16)),
              Text("Model: Corolla", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        SizedBox(height: 300), // Increase space above the button
        ElevatedButton(
          onPressed: () {
            // Handle "FINE" button press
            print('FINE button pressed in Vehicle Details');
          },
          child: Text('FINE'),
        ),
      ],
    );
  }
}

class RevenueLicensePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Text("Vehicle Number: BIJ 4875", style: TextStyle(fontSize: 16)),
              Text("Owner's Name: Kahandugoda Manage Dilhara Madhushani", style: TextStyle(fontSize: 16)),
              Text("User Location: Kudagama, Maho", style: TextStyle(fontSize: 16)),
              Text("License Duration: 25.01.2024 - 25.01.2026", style: TextStyle(fontSize: 16)),
              Text("Amount: Rs. 600.00", style: TextStyle(fontSize: 16)),
              Text("Payment Type: Online Payment", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        SizedBox(height: 100), // Increase space above the button
        ElevatedButton(
          onPressed: () {
            // Handle "OK" button press
            print('OK button pressed in Revenue License');
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}

class InsurancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Text("Vehicle Number: BIJ 4875", style: TextStyle(fontSize: 16)),
              Text("Policy Number: LK5789212013265", style: TextStyle(fontSize: 16)),
              Text("Period of Cover: From 28th May 2019 To 27th May 2020", style: TextStyle(fontSize: 16)),
              Text("Policy Holder: Miss K M D Madhushani", style: TextStyle(fontSize: 16)),
              Text("Address: Kudagama, Maho", style: TextStyle(fontSize: 16)),
              Text("Issued Date: 23rd July 2020", style: TextStyle(fontSize: 16)),
              Text("Contract Type: Third Party", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        SizedBox(height: 100), // Increase space above the button
        ElevatedButton(
          onPressed: () {
            // Handle "OK" button press
            print('OK button pressed in Insurance');
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
