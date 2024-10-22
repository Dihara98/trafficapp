//use this code for the fine history


/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//This is a comment

class TwentyNinePage extends StatefulWidget {
  final Map<String, dynamic> userData; // Pass the user data
  TwentyNinePage({required this.userData});

  @override
  _TwentyNinePageState createState() => _TwentyNinePageState();
}

class _TwentyNinePageState extends State<TwentyNinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF074D5E), // Your background color
      appBar: AppBar(
        backgroundColor: Color(0xFF074D5E),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('GotFine')
            .where('dlNo', isEqualTo: widget.userData['dlNo']) // Query by dlNo
            .orderBy('dateOfOffence', descending: true) // Order by date of offence
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              // Get the fine amount from the Fines collection
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('Fines')
                    .where('fineName', isEqualTo: data['selectedFine'])
                    .limit(1)
                    .get(), // No need to use 'then' here
                builder: (context, fineSnapshot) {
                  if (fineSnapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (fineSnapshot.hasData && fineSnapshot.data != null) {
                    Map<String, dynamic> fineData = fineSnapshot.data!.data() as Map<String, dynamic>;
                    return Card(
                      child: ListTile(
                        title: Text(data['selectedFine']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Vehicle No: ${data['vehicleNo']}'),
                            Text('Date of Offence: ${data['dateOfOffence']}'),
                            Text('Time of Offence: ${data['timeOfOffence']}'),
                            Text('Place of Offence: ${data['placeOffence']}'),
                            Text('Fine Amount: Rs. ${fineData['fineAmount'] ?? 'N/A'}'), // Access the fine amount
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Card(
                      child: ListTile(
                        title: Text(data['selectedFine']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Vehicle No: ${data['vehicleNo']}'),
                            Text('Date of Offence: ${data['dateOfOffence']}'),
                            Text('Time of Offence: ${data['timeOfOffence']}'),
                            Text('Place of Offence: ${data['placeOffence']}'),
                            Text('Fine Amount: N/A'),
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}*/