import 'package:flutter/material.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key});

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
          "Legal Aid & Rights", 
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
                  "Know your rights. Protect your livelihood.", 
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Street vendors are protected by the 'Street Vendors Act, 2014', yet many face illegal evictions, heavy fines, and harassment. Lack of legal knowledge often leads to loss of income and dignity.\n\nAapka Sarthi provides dedicated legal support to ensure no vendor is unfairly targeted. We connect you with advocates and legal experts who fight for your right to vend fearlessly.", 
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
                    _buildBulletPoint("Legal Counseling on Street Vendors Act, 2014"), 
                    _buildBulletPoint("Assistance with Challan/Fine settlements"), 
                    _buildBulletPoint("Defense against Illegal Evictions/Seizure of Goods"), 
                    _buildBulletPoint("Representation in Town Vending Committees (TVC)"), 
                    _buildBulletPoint("Filing of Grievances with Municipal Corporations"), 
                    
                    const SizedBox(height: 25),

                    // --- SECTION: Why This Matters ---
                    _buildSectionTitle("Why This Matters"),
                    _buildBulletPoint("The law protects you from being evicted without notice"), 
                    _buildBulletPoint("Legal aid stops the cycle of bribery and harassment"), 
                    _buildBulletPoint("Retrieving seized goods quickly saves business loss"), 
                    _buildBulletPoint("Empowers you to stand ground with authorities"), 

                    const SizedBox(height: 25),

                    // --- SECTION: How It Works ---
                    _buildSectionTitle("How It Works"),
                    _buildNumberedList("1. Click 'Get Legal Help' or call our hotline"), 
                    _buildNumberedList("2. Upload photo of Challan/Notice or describe the incident"), 
                    _buildNumberedList("3. Case is reviewed by our legal volunteers"), 
                    _buildNumberedList("4. An advocate or representative is assigned to you"), 
                    _buildNumberedList("5. We represent you until the issue is resolved"), 

                    const SizedBox(height: 25),

                    // --- SECTION: Documents Required ---
                    _buildSectionTitle("Documents Required"),
                    _buildBulletPoint("Aadhar Card"), 
                    _buildBulletPoint("Vendor Certificate (CoV) / ID Card"), 
                    _buildBulletPoint("Copy of Challan / Notice (if any)"), 
                    _buildBulletPoint("Photos/Videos of the spot (evidence)"), 

                    const SizedBox(height: 25),

                    // --- SECTION: Benefits for Vendors ---
                    _buildSectionTitle("Benefits for Vendors"),
                    _buildBulletPoint("Professional legal defense at little to no cost"), 
                    _buildBulletPoint("Education about your legal zones and rights"), 
                    _buildBulletPoint("Protection of your vending equipment"), 
                    _buildBulletPoint("Confidential support system"), 

                    const SizedBox(height: 25),

                    // --- SECTION: Example Story ---
                    _buildSectionTitle("Example Story"),
                    const Text(
                      "Raju, a vegetable seller, had his cart seized by municipal authorities despite having a valid certificate. He contacted Aapka Sarthi. Our legal team filed a petition citing Section 19 of the Street Vendors Act. Within 48 hours, his cart was returned without him paying any bribe.", 
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