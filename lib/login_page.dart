import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sltrafficapp/fourth_page.dart'; // Import home page or another page after login

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _usernameController = TextEditingController();  // Define username controller
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;
  bool _loading = false;  // Define loading variable

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _errorMessage = null;  // Clear any previous error messages
    });

    String username = _usernameController.text;
    String password = _passwordController.text;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Navigate to another page or show a success message
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();  // Use _errorMessage
      });
    } finally {
      setState(() {
        _loading = false;  // Stop loading
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
                onPressed: _loading ? null : _login,  // Disable button when loading
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _loading
                    ? CircularProgressIndicator(color: Colors.black)  // Show loading spinner
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
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPolicePage()));
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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}
