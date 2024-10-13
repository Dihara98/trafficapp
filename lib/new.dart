import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<String> getNameFromFirestore() async {
  try {
    // Reference to the Firestore collection 'users'
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Fetch the document containing the person's name
    DocumentSnapshot snapshot = await users.doc('personID').get(); // Replace 'personID' with your actual document ID

    // Retrieve the 'name' field from the document
    String name = snapshot['name'];

    return name;
  } catch (e) {
    throw e;
  }
}


/*class DataDisplayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Data'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('DrivingLicence').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data found'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var document = snapshot.data!.docs[index];
              return ListTile(
                title: Text(document['address'].toString()),
                subtitle: Text(document['bloodGroup'].toString()),
              );
            },
          );
        },
      ),
    );
  }
}*/
