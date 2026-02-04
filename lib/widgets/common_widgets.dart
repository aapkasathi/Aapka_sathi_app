import 'package:flutter/material.dart';
import '../theme.dart';

// --- 1. Standard Text Field ---
class CustomTextField extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final TextInputType? keyboardType;
  final int maxLines;

  const CustomTextField({
    super.key, 
    required this.hint, 
    this.isPassword = false, 
    this.keyboardType, 
    this.maxLines = 1
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextField(
        obscureText: isPassword,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(hintText: hint),
      ),
    );
  }
}

// --- 2. Primary Button (Blue or Amber) ---
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final IconData? icon;

  const PrimaryButton({
    super.key, 
    required this.text, 
    required this.onPressed, 
    this.color, 
    this.textColor,
    this.icon
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55, // Taller button as per prototype
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.primaryBlue,
          foregroundColor: textColor ?? Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            if (icon != null) ...[const SizedBox(width: 10), Icon(icon, color: textColor ?? Colors.white)]
          ],
        ),
      ),
    );
  }
}

// --- 3. Upload Button Placeholder (Grey box) ---
class UploadButtonSquare extends StatelessWidget {
  final String label;
  const UploadButtonSquare({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[100],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud_upload_outlined, color: Colors.grey, size: 30),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}

// --- 4. Upload Button Pill (Gold/Olive colored) ---
class UploadButtonPill extends StatelessWidget {
  final String text;
  const UploadButtonPill({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        // The specific gold/olive color
        color: const Color(0xFFAFA060), 
        borderRadius: BorderRadius.circular(25)
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(width: 10),
            const Icon(Icons.upload_file, color: Colors.white)
          ],
        ),
      ),
    );
  }
}