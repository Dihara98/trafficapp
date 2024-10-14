import 'package:flutter/material.dart';
import 'dart:async';
import 'second_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  FirstPageState createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    super.initState();
    // Navigate to SixthPage after 10 seconds or any other page
    Timer(const Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SecondPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1b4a56),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const SizedBox(height: 50),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/logo.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Simplifying Road Safety",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: Text(
              "Powered by Android",
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF000000),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: const Center(
        child: Text("This is the main screen after the splash screen."),
      ),
    );
  }
}*/
