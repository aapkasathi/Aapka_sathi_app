import 'package:flutter/material.dart';

class DoorToScreen extends StatelessWidget {
  const DoorToScreen({super.key});

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
          "Door to Door", 
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
          // --- 1. TOP WHITE SECTION (Intro) ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Service at your doorstep. No vendor left behind.", 
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "For many vendors, leaving their stall to visit a government office or a bank means losing a day's income. That is why Aapka Sathi brings the service to you.\n\nOur 'Door-to-Door' initiative is a network of field volunteers (Sathi's) who visit markets, vendor zones, and homes to provide on-spot registration, documentation, and digital training.", 
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

          // --- 2. BOTTOM YELLOW SECTION (Scrollable Content) ---
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF5D2), 
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
                    
                    // --- SECTION: What We Offer ---
                    _buildSectionTitle("What We Offer"),
                    _buildBulletPoint("On-spot Registration for Government Schemes"), 
                    _buildBulletPoint("Mobile number linking & Document updates"), 
                    _buildBulletPoint("QR Code installation at your cart"), 
                    _buildBulletPoint("Health & Insurance enrollment camps"), 
                    _buildBulletPoint("Survey & Data Collection for policy benefits"), 
                    
                    const SizedBox(height: 25),

                    // --- SECTION: Why This Matters ---
                    _buildSectionTitle("Why This Matters"),
                    _buildBulletPoint("Saves your daily earnings (no need to close shop)"), 
                    _buildBulletPoint("Ideal for elderly or differently-abled vendors"), 
                    _buildBulletPoint("Ensures 100% accurate data entry by trained volunteers"), 
                    _buildBulletPoint("Builds trust through face-to-face interaction"), 

                    const SizedBox(height: 25),

                    // --- SECTION: How It Works ---
                    _buildSectionTitle("How It Works"),
                    _buildNumberedList("1. Request a visit via the App or Helpline"), 
                    _buildNumberedList("2. A 'Sathi' volunteer is assigned to your area"), 
                    _buildNumberedList("3. They visit your location at a time that suits you"), 
                    _buildNumberedList("4. Complete digital or paper work on the spot"), 
                    _buildNumberedList("5. Receive instant confirmation SMS/Receipt"), 

                    const SizedBox(height: 25),

                    // --- SECTION: Documents Required ---
                    _buildSectionTitle("Documents to Keep Ready"),
                    _buildBulletPoint("Aadhar Card (Original)"), 
                    _buildBulletPoint("Bank Passbook"), 
                    _buildBulletPoint("Active Mobile Phone (for OTP)"), 
                    _buildBulletPoint("Family Details (for insurance/ration cards)"), 

                    const SizedBox(height: 25),

                    // --- SECTION: Benefits for Vendors ---
                    _buildSectionTitle("Benefits for Vendors"),
                    _buildBulletPoint("Zero travel cost"), 
                    _buildBulletPoint("No standing in long queues"), 
                    _buildBulletPoint("Personalized attention to your problem"), 
                    _buildBulletPoint("Quick resolution of pending applications"), 

                    const SizedBox(height: 25),

                    // --- SECTION: Example Story ---
                    _buildSectionTitle("Example Story"),
                    const Text(
                      "Lakshmi Amma, an elderly flower seller, couldn't walk to the municipal office to renew her ID card. Aapka Sathi volunteer visited her stall, used a tablet to scan her documents, and submitted her renewal application right there. She got her new ID within a week without missing a single day of work.", 
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF424242),
                        fontStyle: FontStyle.italic,
                        height: 1.4,
                      ),
                    ),
                    
                    const SizedBox(height: 40), 
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget for Section Titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1A237E), 
        ),
      ),
    );
  }

  // Helper Widget for Bullet Points
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF424242),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget for Numbered Lists
  Widget _buildNumberedList(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF424242),
          height: 1.4,
        ),
      ),
    );
  }
}