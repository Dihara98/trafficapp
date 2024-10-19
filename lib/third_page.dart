import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Firestore package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sltrafficapp/fourth_page.dart';


class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;
  String? _errorMessage;

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _errorMessage = null; // Clear any previous error messages
    });

    String username = _usernameController.text;
    String password = _passwordController.text;

    try {
      // Query Firestore to get user data
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('TrafficPoliceOfficer') // Your Firestore collection
          .where('userName', isEqualTo: username)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        setState(() {
          _errorMessage = 'User not found';
          _loading = false;
        });
        return;
      }

      var userData = querySnapshot.docs[0].data() as Map<String, dynamic>;

      // Check if the password matches
      if (userData['password'] == password) {
        // Password matches, navigate to another page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FourthPage(userData: userData)),
        );
      } else {
        setState(() {
          _errorMessage = 'Incorrect password';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1b4a56),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo and introductory text
              Image.asset('assets/logo.png', height: 80),
              SizedBox(height: 20),
              Text(
                'Ready to streamline the road to safer driving.\nLet\'s manage fines efficiently.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),

              // Username field
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'User Name',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                ),
              ),
              SizedBox(height: 20),

              // Password field
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  suffixIcon: Icon(Icons.visibility),
                ),
              ),
              SizedBox(height: 10),

              // Display error message if any
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),

              SizedBox(height: 20),

              // Login button
              ElevatedButton(
                onPressed: _loading ? null : _login, // Disable button when loading
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _loading
                    ? CircularProgressIndicator(color: Colors.black) // Show loading spinner
                    : Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),

              SizedBox(height: 20),

              // Sign Up link
              GestureDetector(
                onTap: () {
                  // Navigate to the SignupPage
                  //Navigator.push(
                    //context,
                    //MaterialPageRoute(builder: (context) => SignupPolicePage()),
                  //);
                },
                child: Text(
                  'Don\'t have an account? Sign up',
                  style: TextStyle(
                    color: Colors.amber,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}