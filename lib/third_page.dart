import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B3A4B), // Background color
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo and Text
              Image.asset(
                'assets/logo.png', // logo path
                height: 80,
              ),
              SizedBox(height: 20),
              Text(
                'Ready to streamline the road to safer driving.\nLet\'s manage fines efficiently..',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              // Username Field
              TextField(
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
              // Password Field
              TextField(
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
              // Remember Me and Forgot Password Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (value) {}),
                      Text('Remember Me', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Forgot Password?', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Login Button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              // Sign Up Link
              GestureDetector(
                onTap: () {
                  // Handle Sign Up navigation
                },
                child: Text(
                  'Don\'t have an account? Sign up',
                  style: TextStyle(color: Colors.amber, decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
