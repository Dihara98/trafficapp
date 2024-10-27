import 'package:bcrypt/bcrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'nineteen_page.dart'; // For Firestore
//import 'package:bcrypt/bcrypt.dart' as bcrypt; // Import the bcrypt package
//This is a comment

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nicController = TextEditingController();
  final TextEditingController _dlNoController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      try {

        // Check if the driving license number already exists in Firestore
        final QuerySnapshot dlNoSnapshot = await _firestore
            .collection('Driver')
            .where('dlNo', isEqualTo: _dlNoController.text.trim())
            .get();

        if (dlNoSnapshot.docs.isNotEmpty) {
          // Show error if the driving license number is already registered
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('This driving license number is already registered.')),
          );
          return;
        }

        final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        final String hashedPassword = BCrypt.hashpw(_passwordController.text.trim(), BCrypt.gensalt());


        // Save the username with email to Firestore
        await _firestore.collection('Driver').doc(userCredential.user!.uid).set({
          'userName': _usernameController.text.trim(),
          'email': _emailController.text.trim(),
          'address': _addressController.text.trim(),
          'fullName': _fullNameController.text.trim(),
          'dlNo': _dlNoController.text.trim(),
          'nic': _nicController.text.trim(),
          'password': hashedPassword,

        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //content: Text('Registered successfully: ${userCredential.user!.email}'),
          content: Text('Registered successfully with Driving License Number: ${_dlNoController.text.trim()}'),

        ));

        // Navigate to login page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NineteenPage()),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${e.message}'),
        ));
      }
    }
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
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password should be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: _register,
                    child: Text('Sign Up'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
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
