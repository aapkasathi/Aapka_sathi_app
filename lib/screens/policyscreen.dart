import 'package:flutter/material.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

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
          "Policy & Schemes Info.",
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
                  "Stay informed. Unlock your benefits.",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Street vendors are eligible for various government schemes—like PM SVANidhi, e-SHRAM, PMJJBY, PMSBY, and more—but most miss out due to lack of awareness, misinformation, or complicated application processes. \n\nAapka Sarthi bridges this gap by keeping vendors updated and guiding them step-by-step through accessing the benefits they rightfully deserve.",
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
                // The specific yellow color from your image
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
                    _buildBulletPoint("Timely Updates on central and state government welfare schemes."),
                    _buildBulletPoint("Awareness Sessions in local languages about eligibility, benefits, and deadlines."),
                    _buildBulletPoint("Form-Filling Support for scheme applications like PM SVANidhi loan, insurance, pensions, and housing."),
                    _buildBulletPoint("Notifications through the app/SMS when new schemes are launched or reopened."),
                    _buildBulletPoint("Assistance in Document Preparation like Aadhaar linking, bank passbook, vendor ID, etc."),
                    
                    const SizedBox(height: 25),

                    // --- SECTION: Key Schemes ---
                    _buildSectionTitle("Key Government Schemes Covered"),
                    _buildBulletPoint("PM SVANidhi: ₹10k–₹50k loan with 7% interest subsidy."),
                    _buildBulletPoint("e-SHRAM Card: Accident insurance & national database."),
                    _buildBulletPoint("PMJJBY & PMSBY: Life and accident insurance schemes."),
                    _buildBulletPoint("Street Vendors Act, 2014: Proof of legal vending."),

                    const SizedBox(height: 25),

                    // --- SECTION: How It Helps Vendors ---
                    _buildSectionTitle("How It Helps Vendors"),
                    _buildBulletPoint("Access low-interest loans for business growth."),
                    _buildBulletPoint("Get life and accident insurance at very low cost."),
                    _buildBulletPoint("Ensure financial security in emergencies or old age."),
                    _buildBulletPoint("Avoid middlemen and save on application fees."),
                    _buildBulletPoint("Build long-term trust with authorities."),

                    const SizedBox(height: 25),

                    // --- SECTION: Documents Required ---
                    _buildSectionTitle("Documents Required"),
                    _buildBulletPoint("Aadhar Card"),
                    _buildBulletPoint("Bank Passbook"),
                    _buildBulletPoint("Vendor ID / Certificate"),
                    _buildBulletPoint("Photograph"),
                    _buildBulletPoint("Mobile Number (Linked with Aadhaar)"),

                    const SizedBox(height: 25),

                    // --- SECTION: How to Use ---
                    _buildSectionTitle("How to Use This Service"),
                    _buildNumberedList("1. Register with Aapka Sarthi (online or with our team)"),
                    _buildNumberedList("2. Get a personal advisor for schemes you qualify"),
                    _buildNumberedList("3. Submit documents and fill forms"),
                    _buildNumberedList("4. Track your app via SMS or app"),
                    _buildNumberedList("5. Receive funds directly in your bank account"),

                    const SizedBox(height: 25),

                    // --- SECTION: Example Story ---
                    _buildSectionTitle("Example Story"),
                    const Text(
                      "Geeta, a vegetable vendor, never knew she could get ₹10,000 to expand her stall. With Aapka Sarthi’s help, she applied for PM SVANidhi, bought a new cart, and increased her daily income by 40%.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF424242),
                        fontStyle: FontStyle.italic,
                        height: 1.4,
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

  // Helper Widget for Section Titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1A237E), // Dark Blue color from your content images
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