import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//this is for third_page.dart

class ChangePasswordPage extends StatefulWidget {
  final String username; // Pass the username from ThirdPage

  const ChangePasswordPage({Key? key, required this.username}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  final _otpController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  String? _errorMessage;
  String? _verificationId;

  // Send OTP function
  Future<void> _sendOTP() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    String email = _emailController.text.trim();

    try {
      // Send OTP using Firebase Authentication
      //await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());

      // Display a success message or navigate to the OTP verification page
      setState(() {
        _isLoading = false;
        _errorMessage = 'OTP sent to $email';
        // You might want to navigate to an OTP verification page here
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error sending OTP: $e';
      });
    }
  }

  // Verify OTP function
  Future<void> _verifyOTP() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    String otp = _otpController.text.trim();

    try {
      // Create PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      // Sign in the user with the credential
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Update the password in Firestore (you'll need the username here)
      await _updateFirestorePassword();

      // Navigate to the success page or handle the password change
      setState(() {
        _isLoading = false;
        _errorMessage = 'Password updated successfully!';
        // You might want to navigate to a success page here
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error verifying OTP: $e';
      });
    }
  }

  // Function to update the password in Firestore
  Future<void> _updateFirestorePassword() async {
    String newPassword = _newPasswordController.text.trim();

    try {
      // Find the user's document in Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('TrafficPoliceOfficer')
          .where('userName', isEqualTo: widget.username)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        setState(() {
          _errorMessage = 'User not found';
          _isLoading = false;
        });
        return;
      }

      // Update the password in Firestore
      await querySnapshot.docs[0].reference.update({
        'password': newPassword,
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error updating password: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmNewPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isLoading ? null : _sendOTP,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Send OTP'),
              ),
              const SizedBox(height: 16),
              // Add OTP verification section
              TextFormField(
                controller: _otpController,
                decoration: const InputDecoration(
                  labelText: 'OTP',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the OTP';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isLoading ? null : _verifyOTP,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Verify OTP'),
              ),
              const SizedBox(height: 16),
              // Display error message if any
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}