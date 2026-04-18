import 'package:flutter/material.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

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
          "Training & Skills", 
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
                  "Upskill today. Grow your business tomorrow.", 
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Running a successful street business requires more than just hard work—it requires smart skills. From food safety and hygiene to customer interaction and digital tools, modern skills can double your income.\n\nAapka Sarthi offers specialized workshops and training sessions designed to help street vendors modernize their business, comply with government rules, and win customer trust.", 
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
                    
                    // --- SECTION: What We Offer ---
                    _buildSectionTitle("What We Offer"),
                    _buildBulletPoint("Food Safety & Hygiene Workshops (FSSAI standards)"), 
                    _buildBulletPoint("Customer Interaction & Soft Skills Training"), 
                    _buildBulletPoint("Digital Literacy (Using Apps & Payments)"), 
                    _buildBulletPoint("Financial Management & Savings Planning"), 
                    _buildBulletPoint("Waste Management & Eco-friendly Vending"), 
                    
                    const SizedBox(height: 25),

                    // --- SECTION: Why This Matters ---
                    _buildSectionTitle("Why This Matters"),
                    _buildBulletPoint("Hygiene certification builds huge trust with customers"), 
                    _buildBulletPoint("Better behavior leads to loyal, repeat customers"), 
                    _buildBulletPoint("Digital skills prevent fraud and simplify accounting"), 
                    _buildBulletPoint("Compliance avoids fines from municipal authorities"), 

                    const SizedBox(height: 25),

                    // --- SECTION: How It Works ---
                    _buildSectionTitle("How It Works"),
                    _buildNumberedList("1. Register for upcoming training batches via app"), 
                    _buildNumberedList("2. Attend offline workshops or watch online videos"), 
                    _buildNumberedList("3. Complete simple assessments or quizzes"), 
                    _buildNumberedList("4. Receive a valid Completion Certificate"), 
                    _buildNumberedList("5. Display certificate on your cart to attract customers"), 

                    const SizedBox(height: 25),

                    // --- SECTION: Documents Required ---
                    _buildSectionTitle("Documents Required"),
                    _buildBulletPoint("Aadhar Card (for registration)"), 
                    _buildBulletPoint("Vendor ID (if available)"), 
                    _buildBulletPoint("Passport-size photo"), 
                    
                    const SizedBox(height: 25),

                    // --- SECTION: Benefits for Vendors ---
                    _buildSectionTitle("Benefits for Vendors"),
                    _buildBulletPoint("Official Certificate to display on your stall"), 
                    _buildBulletPoint("Increased sales due to better service & hygiene"), 
                    _buildBulletPoint("Recognition from local authorities"), 
                    _buildBulletPoint("Networking with other successful vendors"), 

                    const SizedBox(height: 25),

                    // --- SECTION: Example Story ---
                    _buildSectionTitle("Example Story"),
                    const Text(
                      "Ramesh, a pani-puri vendor, used to face issues with hygiene complaints. After attending Aapka Sarthi’s 'Safe Food' workshop, he started using gloves, caps, and clean water dispensers. He displayed his training certificate on his cart, and within 3 months, his daily sales doubled as customers trusted him more.", 
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