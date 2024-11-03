import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sltrafficapp/fourth_page.dart';
import 'package:sltrafficapp/change_password_page.dart';

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;
  String? _errorMessage;

  bool _obscureText = true;

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    String username = _usernameController.text;
    String password = _passwordController.text;

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('TrafficPoliceOfficer')
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

      if (userData['password'] == password) {
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to previous screen
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png', height: 30), // Adjust height
          ),
        ],
        backgroundColor: Color(0xFF1b4a56),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'Ready to streamline\nthe road to safer\ndriving. Let\'s manage\nfines efficiently.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),

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

              TextField(
                controller: _passwordController,
                obscureText: _obscureText, // Add a state variable for obscuring text
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off, // Toggle icon
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText; // Toggle the state

                      });
                    },
                  ),
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

              ElevatedButton(
                onPressed: _loading ? null : _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: _loading
                    ? CircularProgressIndicator(color: Colors.black)
                    : const Text(
                  'LOGIN',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),

              SizedBox(height: 50),

              GestureDetector(
                onTap: () {
                  // Navigate to ChangePasswordPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePasswordPage(
                        username: _usernameController.text.trim(),
                      ),
                    ),
                  );
                },
                child: Text(
                  'Change Password',
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