import 'package:flutter/material.dart';

class LanguagesOptions extends StatefulWidget {
  const LanguagesOptions({super.key});

  @override
  State<LanguagesOptions> createState() => _LanguagesOptionState();
}

class _LanguagesOptionState extends State<LanguagesOptions> {
  String _selectedLanguage = 'en'; 

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFFFFFDE7); 
    const Color activeColor = Color(0xFFFFC107); 
    const Color inactiveColor = Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        centerTitle: false, 
        titleSpacing: 0, 
        title: const Text(
          "Select your Language",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hindi Option
                _buildLanguageOption(
                  id: 'hi',
                  symbol: 'ह',
                  label: 'हिंदी',
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                ),
                
                const SizedBox(width: 50), 

                // English Option
                _buildLanguageOption(
                  id: 'en',
                  symbol: 'E',
                  label: 'English',
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                ),
              ],
            ),

            const SizedBox(height: 40), 

            // --- Row 2: Marathi (Centered) ---
            _buildLanguageOption(
              id: 'mr',
              symbol: 'म',
              label: 'मराठी',
              activeColor: activeColor,
              inactiveColor: inactiveColor,
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widget to Build Language Circle ---
  Widget _buildLanguageOption({
    required String id,
    required String symbol,
    required String label,
    required Color activeColor,
    required Color inactiveColor,
  }) {
    bool isSelected = _selectedLanguage == id;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = id;
        });
      },
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? activeColor : inactiveColor,
              border: Border.all(color: Colors.black, width: 1),
              boxShadow: isSelected
                  ? [ 
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ]
                  : null,
            ),
            alignment: Alignment.center,
            child: Text(
              symbol,
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          
          const SizedBox(height: 15),
          
          Text(
            label,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}