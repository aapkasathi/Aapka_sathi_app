import 'package:flutter/material.dart';

class DigitalAccessScreen extends StatelessWidget {
  const DigitalAccessScreen({super.key});

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
          "Digital Access", //
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
                  "Bringing vendors into the digital age—step by step.", //
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "In today’s world, digital skills aren’t optional—they’re essential. Yet, many vendors lack access or knowledge to use digital tools effectively.\n\nAapka Sarthi’s Digital Empowerment service ensures every vendor can confidently use smartphones, apps, UPI, QR codes, and social media to grow their business, track finances, and connect with customers.", //
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
                    _buildBulletPoint("Training in Smartphone Basics"), //
                    _buildBulletPoint("UPI, QR Code, and Wallet Setup"), //
                    _buildBulletPoint("WhatsApp & Social Media Use"), //
                    _buildBulletPoint("Digital Finance Tracking & Literacy"), //
                    _buildBulletPoint("Assistance in Using Apps for Services & Schemes"), //
                    
                    const SizedBox(height: 25),

                    // --- SECTION: Why This Matters ---
                    _buildSectionTitle("Why This Matters"),
                    _buildBulletPoint("Cashless payments reduce theft and increase sales"), //
                    _buildBulletPoint("Social media boosts customer reach"), //
                    _buildBulletPoint("Digital records help with loans and subsidies"), //
                    _buildBulletPoint("Empowers vendors to self-manage business growth"), //

                    const SizedBox(height: 25),

                    // --- SECTION: How It Works ---
                    _buildSectionTitle("How It Works"),
                    _buildNumberedList("1. Enroll through app or field volunteer"), //
                    _buildNumberedList("2. Get digital skill sessions (group or 1-on-1)"), //
                    _buildNumberedList("3. Set up UPI/QR with help"), //
                    _buildNumberedList("4. Join local WhatsApp vendor groups"), //
                    _buildNumberedList("5. Continue learning via tutorials or support"), //

                    const SizedBox(height: 25),

                    // --- SECTION: Documents Required ---
                    _buildSectionTitle("Documents Required"),
                    _buildBulletPoint("Smartphone (or family member’s device)"), //
                    _buildBulletPoint("Aadhar Card"), //
                    _buildBulletPoint("Bank Account with mobile-linked number"), //
                    _buildBulletPoint("Vendor ID (optional)"), //

                    const SizedBox(height: 25),

                    // --- SECTION: Benefits for Vendors ---
                    _buildSectionTitle("Benefits for Vendors"),
                    _buildBulletPoint("Digital confidence and independence"), //
                    _buildBulletPoint("Access to digital payment and finance tools"), //
                    _buildBulletPoint("Stronger connection with customers online"), //
                    _buildBulletPoint("Better visibility for support and schemes"), //

                    const SizedBox(height: 25),

                    // --- SECTION: Example Story ---
                    _buildSectionTitle("Example Story"),
                    const Text(
                      "Sunil, a momo vendor in Gwalior, didn’t know how to use UPI or QR payments. With Aapka Sarthi’s help, he set up a QR code, joined WhatsApp groups, and began posting updates. His customer base expanded by 35%.", //
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