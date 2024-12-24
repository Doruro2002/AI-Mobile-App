import 'package:flutter/material.dart';
import 'screens/Splash_screen.dart';
import 'screens/Landing_screen.dart';
import 'screens/Login_screen.dart';
import 'screens/Signup_screen.dart';
import 'screens/Home_screen.dart';
import 'screens/Scan.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/landing': (context) => LandingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/scan': (context) => ScanScreen(),
        // Ajoute les autres routes
      },
    );
  }
}