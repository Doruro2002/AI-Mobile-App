import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed( const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/landing');
    });

    return Scaffold(
      body: Center(
         
        child: Image.asset('assets/images/logo.png')
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        
    );
  }
}
