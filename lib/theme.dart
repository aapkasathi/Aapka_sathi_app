import 'package:flutter/material.dart';

class AppColors {
  // Official Dark Blue for headers, primary buttons
  static const Color primaryBlue = Color(0xFF1A237E);
  // Bright Amber/Yellow for highlights, accents, "Next" buttons
  static const Color primaryAmber = Color(0xFFFDD835);
  // Warm Cream background for registration forms
  static const Color backgroundCream = Color(0xFFFFF9C4);
  // Slightly darker yellow for input fields
  static const Color inputFill = Color(0xFFFFF59D);
  // Background for the Language Selection screen
  static const Color langBackground = Color(0xFFFFE082);
  // Grey for secondary text
  static const Color textGrey = Color(0xFF757575);
}

final ThemeData appTheme = ThemeData(
  primaryColor: const Color.fromARGB(255, 4, 11, 80),
  // Default background is white (for Dashboard), overridden in forms to Cream
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Roboto', // Clean, official sans-serif
  useMaterial3: true,
  
  // App Bar theme to be transparent by default with dark icons
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
  ),

  // Global Input Field Styling to match prototype
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.inputFill.withOpacity(0.5),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    hintStyle: TextStyle(color: Colors.brown[300]),
  ),
);