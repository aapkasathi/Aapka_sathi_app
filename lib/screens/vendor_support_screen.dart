import 'package:flutter/material.dart';

class VendorSupportScreen extends StatelessWidget {
  const VendorSupportScreen({super.key});

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
          "Vendor Support", 
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
                  "From registration to recognition — we’re with you at every step.", 
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Getting started as a street vendor can be overwhelming—especially when faced with unfamiliar paperwork, online forms, and unclear processes.\n\nAapka Sathi’s Vendor Support service ensures that every vendor receives complete, personalized assistance from day one. From registration and documentation to technical help and field guidance, we make sure no vendor is left behind.", 
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
                    
                    _buildSectionTitle("What We Offer"),//
                    _buildBulletPoint("Onboarding Assistance for registration on app/platform"), //
                    _buildBulletPoint("Document Collection & Upload Help"), //
                    _buildBulletPoint("Service Navigation Help to access all services"), //
                    _buildBulletPoint("Field & Technical Support in markets and areas"), //
                    _buildBulletPoint("Personalized Follow-Up for renewals & updates"), //
                    
                    const SizedBox(height: 25),

                    // --- SECTION: Why This Matters ---
                    _buildSectionTitle("Why This Matters"), // Section title updated
                    _buildBulletPoint("Many vendors don’t know how to begin"), //
                    _buildBulletPoint("Support ensures they get the maximum benefits"), //
                    _buildBulletPoint("Enables trust and comfort with formal systems"), //
                    _buildBulletPoint("Guides them to access training, legal aid, and financial support"), //

                    const SizedBox(height: 25),

                    // --- SECTION: How It Works ---
                    _buildSectionTitle("How It Works"), // Section title updated
                    _buildNumberedList("1. Meet our team in your market area or via app/website"), //
                    _buildNumberedList("2. Provide basic documents (Aadhar, photo, etc.)"), //
                    _buildNumberedList("3. We complete your registration on the platform"), //
                    _buildNumberedList("4. Get guidance on the services you qualify for"), //
                    _buildNumberedList("5. Receive regular updates and ongoing support"), //

                    const SizedBox(height: 25),

                    // --- SECTION: Documents Required ---
                    _buildSectionTitle("Documents Required"), // Section title updated
                    _buildBulletPoint("Aadhar Card"), //
                    _buildBulletPoint("Passport-size Photograph"), //
                    _buildBulletPoint("Mobile Number"), //
                    _buildBulletPoint("Any existing vendor ID (if available)"), //
                    _buildBulletPoint("Bank Passbook (for financial access)"), //

                    const SizedBox(height: 25),

                    // --- SECTION: Benefits for Vendors ---
                    _buildSectionTitle("Benefits for Vendors"), // Section title updated
                    _buildBulletPoint("Friendly onboarding & guidance"), //
                    _buildBulletPoint("No confusion about documents or online forms"), //
                    _buildBulletPoint("Support in local language"), //
                    _buildBulletPoint("Access to all services from day one"), //
                    _buildBulletPoint("Peace of mind with regular assistance"), //

                    const SizedBox(height: 25),

                    // --- SECTION: Example Story ---
                    _buildSectionTitle("Example Story"), // Section title updated
                    const Text(
                      "Farida, a street vendor in Bhopal, couldn't read or write well and had never used a smartphone. Aapka Sathi's local volunteer visited her, helped her upload her documents, register her on the app, and apply for a vendor certificate. Today, she confidently uses UPI, checks scheme updates, and refers other vendors.", // Story text updated
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