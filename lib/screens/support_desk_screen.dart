import 'package:flutter/material.dart';

class SupportDeskScreen extends StatelessWidget {
  const SupportDeskScreen({super.key});

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
          "Support Desk", 
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
                  "Your voice matters. We are here to listen and act.", 
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Street vendors often face sudden challenges—harassment, eviction threats, disputes, or simply confusion about municipal rules. You don't have to face these problems alone.\n\nAapka Sathi’s Support Desk is your dedicated grievance redressal system. Whether it's a legal issue or a general query, our team is ready to intervene, guide, and resolve your concerns swiftly.", 
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
                    _buildBulletPoint("24/7 Helpline for emergency grievance reporting"), 
                    _buildBulletPoint("Direct connection to Legal Advocates"), 
                    _buildBulletPoint("Mediation support with Municipal Authorities/Police"), 
                    _buildBulletPoint("Complaint Tracking System (Ticket Number)"), 
                    _buildBulletPoint("Guidance on rights and responsibilities"), 
                    
                    const SizedBox(height: 25),

                    // --- SECTION: Why This Matters ---
                    _buildSectionTitle("Why This Matters"),
                    _buildBulletPoint("Protects you from illegal evictions and harassment"), 
                    _buildBulletPoint("Ensures your voice reaches the right officials"), 
                    _buildBulletPoint("Saves time and money on running around courts/offices"), 
                    _buildBulletPoint("Provides mental peace and business security"), 

                    const SizedBox(height: 25),

                    // --- SECTION: How It Works ---
                    _buildSectionTitle("How It Works"),
                    _buildNumberedList("1. Raise a ticket via the App 'Call Support' or Chat"), 
                    _buildNumberedList("2. Provide details of the incident (Photo/Audio evidence)"), 
                    _buildNumberedList("3. Our support team verifies and assigns a field agent"), 
                    _buildNumberedList("4. Legal aid or mediation is provided immediately"), 
                    _buildNumberedList("5. Issue is resolved and closed"), 

                    const SizedBox(height: 25),

                    // --- SECTION: Documents Required ---
                    _buildSectionTitle("Required for Complaints"),
                    _buildBulletPoint("Vendor ID / Certificate of Vending"), 
                    _buildBulletPoint("Photo/Video proof of incident (if applicable)"), 
                    _buildBulletPoint("Location details of the vending spot"), 
                    _buildBulletPoint("Any prior challan or notice received"), 

                    const SizedBox(height: 25),

                    // --- SECTION: Benefits for Vendors ---
                    _buildSectionTitle("Benefits for Vendors"),
                    _buildBulletPoint("Zero-cost legal guidance"), 
                    _buildBulletPoint("Quick response time"), 
                    _buildBulletPoint("Anonymous reporting option available"), 
                    _buildBulletPoint("Community support backup"), 

                    const SizedBox(height: 25),

                    // --- SECTION: Example Story ---
                    _buildSectionTitle("Example Story"),
                    const Text(
                      "Suresh faced daily harassment and demands for bribes to keep his fruit stall running. He used the Support Desk to report the issue anonymously. Our legal team intervened, spoke to the local Town Vending Committee, and ensured his spot was regularized without him paying any bribes.", 
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