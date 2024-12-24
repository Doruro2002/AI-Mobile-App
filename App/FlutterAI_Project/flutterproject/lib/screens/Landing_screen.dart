
import 'package:flutter/material.dart';
import 'package:flutterproject/screens/Login_screen.dart';
import 'package:flutterproject/screens/Signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingScreen(),
    );
  }
}

 class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image en arrière-plan
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          // Contenu principal avec séparation diagonale
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start, // Aligner les enfants à gauche
            children: [
              // Boutons empilés verticalement
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 75.0),
                child: Column(
                  children: [
                    // Bouton Login
                    ElevatedButton(
                      onPressed: () {
                         // Naviguer vers la page Login
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F1F45),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Log in', style: TextStyle(fontSize: 18)),
                    ),
                    const SizedBox(height: 15),
                    // Bouton Sign Up
                    ElevatedButton(
                      onPressed: () {
                         // Naviguer vers la page SignUP
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor:  const Color.fromARGB(255, 15, 31, 69),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: const BorderSide(color: Color.fromARGB(255, 15, 31, 69), width: 2),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Sign Up', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 130),
            ],
          ),
        ],
      ),
    );
  }
}
