import 'package:flutter/material.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD54F), // Golden Yellow Background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          "Disclaimer",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFFFF5D2), // Light Cream Box
              borderRadius: BorderRadius.circular(20), // Curved edges
            ),
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                '''

Aapka Sarthi is a private initiative and is not affiliated, associated, authorized, or endorsed by any government department or agency. 

All government information and links provided in the app are for public awareness and convenience only, and users should verify details from official government sources (e.g., .gov.in websites).''',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5, // Better line spacing for reading
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}