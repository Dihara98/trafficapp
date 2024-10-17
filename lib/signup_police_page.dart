import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For Firestore

class SignupPolicePage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPolicePage> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController(); // Add email field

  bool _loading = false;
  String? _errorMessage;

  Future<void> _signUp() async {
    setState(() {
      _loading = true;
      _errorMessage = null; // Clear any previous error messages
    });

    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String email = _emailController.text.trim(); // Get email from the field

    try {
      // Add new user data to Firestore
      await FirebaseFirestore.instance
          .collection('TrafficPoliceOfficer') // Your Firestore collection
          .add({
        'userName': username,
        'password': password, // Store the password (consider hashing for security!)
        'email': email, // Store the email
      });

      // After successful signup, you might want to:
      // 1. Navigate back to the login page
      // 2. Display a success message

      setState(() {
        _loading = false;
        _errorMessage = null; // Clear any previous error messages
        // ... (Optional) Display success message
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _errorMessage = 'Error signing up: $e';
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose(); // Dispose email controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1b4a56),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo and introductory text
                Image.asset('assets/logo.png', height: 80),
                SizedBox(height: 20),
                Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),

                // Username field
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'User Name',
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white24,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Email field (add this)
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white24,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    }
                    // You can add more validation for email format here if needed
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Password field
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white24,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    // You can add more password validation here if needed
                    return null;
                  },
                ),
                SizedBox(height: 10),

                // Display error message if any
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),

                SizedBox(height: 20),

                // Sign Up button
                ElevatedButton(
                  onPressed: _loading ? null : _signUp, // Disable button when loading
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
                    'SIGN UP',
                    style: TextStyle(fontSize: 18, color: Colors.black),
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