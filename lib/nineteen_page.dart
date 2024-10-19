import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For Firestore
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sltrafficapp/twenty_page.dart';
import 'package:sltrafficapp/signup_page.dart'; // Import the SignupPage
//import 'package:bcrypt/bcrypt.dart' as bcrypt; // Import the bcrypt package

class NineteenPage extends StatefulWidget {
  @override
  _NineteenPageState createState() => _NineteenPageState();
}

class _NineteenPageState extends State<NineteenPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;
  String? _errorMessage;

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    String username = _usernameController.text;
    String password = _passwordController.text;

    try {
      // Get the user data from Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Driver')
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

      // Compare the entered password with the hashed password in Firestore
      //if (await bcrypt.checkpw(password.codeUnits, userData['password'] as String)) { // Use bcrypt.checkpw for comparison
      if (password == userData['password']) {
      // Passwords match - proceed with login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TwentyPage(userData: userData)),
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
      backgroundColor: Color(0xFF074D5E),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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


              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),

              SizedBox(height: 20),


              ElevatedButton(
                onPressed: _loading ? null : _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _loading
                    ? CircularProgressIndicator(color: Colors.black)
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );
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