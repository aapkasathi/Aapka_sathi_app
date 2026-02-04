import 'dart:async'; // Needed for the Timer
import 'package:flutter/material.dart';
import 'package:aapka_sathi/screens/start/language_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    
    
    Timer(const Duration(seconds: 3), () {
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LanguageSelectScreen()), 
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Image.asset('assets/images/app_icon.png',height: 200,),
                ],
            ),
          ),

          
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0, left: 70.0, right: 70.0), 
                child: const Text(
                  "Empowering Street Vendors & Shaping Their Future",
                  style: TextStyle(
                    fontFamily: 'Serif',
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

