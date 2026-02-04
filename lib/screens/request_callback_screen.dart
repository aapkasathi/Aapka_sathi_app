import 'package:flutter/material.dart';

class RequestCallbackScreen extends StatelessWidget {
  const RequestCallbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
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
        title: const Text(
          "Request Callback",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "We are here to help.",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Fill out the form below and one of our support agents (Saathi's) will reach out to you shortly.",
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFFFD54F), 
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    _buildFieldLabel("Your Name*"),
                    _buildInputBox(hint: "Enter your full name"),

                    const SizedBox(height: 20),

                    _buildFieldLabel("Phone Number*"),
                    _buildInputBox(
                      hint: "+91 XXXXX XXXXX", 
                      keyboardType: TextInputType.phone
                    ),

                    const SizedBox(height: 20),

                    _buildFieldLabel("Subject*"),
                    _buildInputBox(hint: "e.g., ID Renewal, Harassment"),

                    const SizedBox(height: 20),

                    _buildFieldLabel("Message*"),
                    _buildInputBox(
                      hint: "Describe your issue briefly...", 
                      maxLines: 5
                    ),

                    const SizedBox(height: 40),

                    // --- SUBMIT BUTTON ---
                    Center(
                      child: SizedBox(
                        width: double.infinity, // Full width button
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Callback Requested Successfully!")),
                            );
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A237E), // Navy Blue
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 4,
                          ),
                          child: const Text(
                            "Submit Request",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 40), // Bottom padding
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper: Label Text ---
  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF424242), // Dark grey for contrast on yellow
        ),
      ),
    );
  }

  // --- Helper: Input Box (White on Yellow) ---
  Widget _buildInputBox({
    required String hint, 
    int maxLines = 1, 
    TextInputType? keyboardType
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // White box to pop against yellow background
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      // Clip.hardEdge ensures text doesn't bleed out of rounded corners
      clipBehavior: Clip.hardEdge, 
      child: TextField(
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}