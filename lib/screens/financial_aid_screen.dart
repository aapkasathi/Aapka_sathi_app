import 'package:flutter/material.dart';

class FinancialAidScreen extends StatelessWidget {
  const FinancialAidScreen({super.key});

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
          "Financial Aid", //
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
                  "Fueling vendor's dreams with financial freedom.", //
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Access to finance is a major barrier for street vendors. Most rely on daily cash sales, have no formal credit history, and are excluded from banks and financial institutions.\n\nAapka Sathi’s Financial Aid service solves this by connecting vendors with government loans, microfinance, and financial tools designed to grow and stabilize their businesses.", //
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
                    _buildBulletPoint("Loan Application Support (PM SVANidhi & More)"), //
                    _buildBulletPoint("Bank Account Opening & Linking"), //
                    _buildBulletPoint("Microfinance Guidance"), //
                    _buildBulletPoint("Financial Literacy Training"), //
                    _buildBulletPoint("Digital Payments Setup"), //
                    
                    const SizedBox(height: 25),

                    // --- SECTION: Why This Matters ---
                    _buildSectionTitle("Why This Matters"),
                    _buildBulletPoint("Most vendors don’t have credit scores or access to loans"), //
                    _buildBulletPoint("Microloans provide quick capital for daily needs or upgrades"), //
                    _buildBulletPoint("Without help, many fall into debt traps from private lenders"), //
                    _buildBulletPoint("Financial access ensures growth, security, and respect"), //

                    const SizedBox(height: 25),

                    // --- SECTION: How It Works ---
                    _buildSectionTitle("How It Works"),
                    _buildNumberedList("1. Join Aapka Sathi (online or via our field team)"), //
                    _buildNumberedList("2. Get guidance on the most suitable financial option"), //
                    _buildNumberedList("3. Complete documents with our help and apply"), //
                    _buildNumberedList("4. Track application through the app or get updates by SMS"), //
                    _buildNumberedList("5. Get disbursement directly into your bank account"), //

                    const SizedBox(height: 25),

                    // --- SECTION: Documents Required ---
                    _buildSectionTitle("Documents Required"),
                    _buildBulletPoint("Aadhar Card"), //
                    _buildBulletPoint("Bank Passbook"), //
                    _buildBulletPoint("Mobile Number (linked to Aadhar)"), //
                    _buildBulletPoint("Vendor ID / Any Business Proof"), //
                    _buildBulletPoint("Passport-size photo"), //

                    const SizedBox(height: 25),

                    // --- SECTION: Benefits for Vendors ---
                    _buildSectionTitle("Benefits for Vendors"),
                    _buildBulletPoint("Access to funds without middlemen"), //
                    _buildBulletPoint("Improved creditworthiness for future growth"), //
                    _buildBulletPoint("Easier savings and daily cash tracking"), //
                    _buildBulletPoint("Govt interest subsidy & cashback options"), //
                    _buildBulletPoint("Cashless payments reduce theft risk"), //

                    const SizedBox(height: 25),

                    // --- SECTION: Example Story ---
                    _buildSectionTitle("Example Story"),
                    const Text(
                      "Ashok, a chana vendor in Bhopal, was stuck using borrowed money from local moneylenders at high interest. Aapka Sathi helped him open a bank account, apply for a PM SVANidhi loan, and now he runs a cart with shade, LED lighting, and a QR payment board.", //
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