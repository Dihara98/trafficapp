import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'nineteen_page.dart'; // For Firestore
//import 'package:bcrypt/bcrypt.dart' as bcrypt; // Import the bcrypt package

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  final _nicController = TextEditingController();
  final _dlNoController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;
  String? _errorMessage;

  Future<void> _signUp() async {
    setState(() {
      _loading = true;
      _errorMessage = null; // Clear any previous error messages
    });

    String nic = _nicController.text.trim();
    String dlNo = _dlNoController.text.trim();
    String fullName = _fullNameController.text.trim();
    String address = _addressController.text.trim();
    String email = _emailController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    try {
      // Hash the password using bcrypt
      //String hashedPassword = await bcrypt.hashpw(password.codeUnits, bcrypt.gensalt());

      // Add new user data to Firestore with the hashed password
      await FirebaseFirestore.instance
          .collection('Driver') // Your Firestore collection
          .add({
        'NIC': nic,
        'dlNo': dlNo,
        'fullName': fullName,
        'address': address,
        'email': email,
        'userName': username,
        'password': password, // Store the hashed password
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

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Successfully Signed Up!'),
          content: Text('Do you want to log in?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => NineteenPage()),
                ); // Navigate to the login page
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                // Exit the app
                Navigator.of(context).popUntil((route) => route.isFirst); // Close the dialog and exit the app
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // ... (Your logic to exit the app)
              },
              child: Text('Exit App'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nicController.dispose();
    _dlNoController.dispose();
    _fullNameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF074D5E),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView( // Wrap in SingleChildScrollView for scrolling
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

                  // National Identity Card Number field
                  TextFormField(
                    controller: _nicController,
                    decoration: InputDecoration(
                      labelText: 'National Identity Card Number',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white24,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your NIC number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  // Driving License Number field
                  TextFormField(
                    controller: _dlNoController,
                    decoration: InputDecoration(
                      labelText: 'Driving License Number',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white24,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your driving license number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  // Full Name field
                  TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white24,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  // Address field
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white24,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  // Email field
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

                  // User Name field
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
      ),
    );
  }
}