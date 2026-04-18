import 'package:flutter/material.dart';

class LanguageSelectScreen extends StatelessWidget {
  const LanguageSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5D2),
      body: SafeArea(
        bottom: false, 
        child: Column(
          children: [
            // --- TOP SECTION: Avatar Illustration ---
            Expanded(
              flex: 4, 
              child: Container(
                width: double.infinity,
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'assets/images/language_bg.png',
                  fit: BoxFit.contain, 
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(Icons.image, 
                        size: 80, 
                        color: Colors.white.withOpacity(0.5)
                      ),
                    );
                  },
                ),
              ),
            ),

            // --- BOTTOM SECTION: White Card ---
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TOP PART OF THE CARD
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "Select Your Language",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Understand Everything, In Your Language.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 25),

                        // --- Language Buttons ---
                        Row(
                          children: [
                            _buildLanguageButton(
                              text: "हिंदी",
                              backgroundColor: const Color(0xFFFFF9C4),
                              borderColor: Colors.orange,
                              isSelected: true,
                              onTap: () {},
                            ),
                            const SizedBox(width: 16),
                            _buildLanguageButton(
                              text: "English",
                              backgroundColor: const Color(0xFFFFF9C4),
                              borderColor: Colors.orange,
                              isSelected: false,
                              onTap: () {},
                            ),
                            
                            const SizedBox(width: 16),
                            _buildLanguageButton(
                              text: "Marathi",
                              backgroundColor: const Color(0xFFFFF9C4),
                              borderColor: Colors.orange,
                              isSelected: false,
                              onTap: () {},
                            ),
                          
                          ],
                        ),
                      ],
                    ),
                    SafeArea(
                      top: false,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFC107),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Next",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageButton({
    required String text,
    required Color backgroundColor,
    required Color borderColor,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}