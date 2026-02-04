import 'package:flutter/material.dart';

class LicensesInfoScreen extends StatefulWidget {
  const LicensesInfoScreen({super.key});

  @override
  State<LicensesInfoScreen> createState() => _LicensesInfoScreenState();
}

class _LicensesInfoScreenState extends State<LicensesInfoScreen> {
  // This helps to keep only one panel open at a time
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Clean background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 28),
            onPressed: () => Navigator.pop(context, true),
          ),
        ),
        title: const Text(
          "Licenses & Documentation",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          _buildLicenseItem(0, "Certificate of Vending (CoV)"),
          const SizedBox(height: 15), // Spacing between cards
          _buildLicenseItem(1, "FSSAI Food Safety Registration"),
          const SizedBox(height: 15),
          _buildLicenseItem(2, "Trade License / Shop Establishment License"),
          const SizedBox(height: 15),
          _buildLicenseItem(3, "Hawker License"),
          const SizedBox(height: 15),
          _buildLicenseItem(4, "No Objection Certificate (NOC)"),
          const SizedBox(height: 15),
          _buildLicenseItem(5, "Labour Card / Unorganized Worker ID"),
          const SizedBox(height: 30), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildLicenseItem(int index, String title) {
    bool isExpanded = _expandedIndex == index;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Theme(
          // Removes the default divider lines
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            key: Key(index.toString()),
            initiallyExpanded: isExpanded,
            
             
            collapsedBackgroundColor: const Color(0xFFFFD54F), // Yellow Button
            backgroundColor: const Color(0xFFFFD54F), // Header stays Yellow when open
            
            // --- ICONS & TEXT ---
            iconColor: Colors.black,
            collapsedIconColor: Colors.black,
            trailing: Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.black,
            ),
            
            tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),

            title: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            onExpansionChanged: (expanded) {
              setState(() {
                _expandedIndex = expanded ? index : null;
              });
            },
            children: [
              // Content Box (Light Cream)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF5D2), // Light Cream content background
                ),
                child: _buildLicenseContent(index),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLicenseContent(int index) {
    switch (index) {
      case 0: // Certificate of Vending (CoV)
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNormalText("This is the primary legal license for street vendors, issued under the Street Vendors Act, 2014, giving them official permission to operate in specific vending zones."),
            _buildSectionTitle("Purpose:"),
            _buildBulletPoint("Grants legal recognition and protection from eviction"),
            _buildBulletPoint("Required for schemes like PM SVANidhi and SUSV"),
            _buildBulletPoint("Helps in getting loans, setting up stalls in vending zones, and avoiding penalties"),
            _buildSectionTitle("Eligibility:"),
            _buildBulletPoint("Street vendors who participated in the government's vendor survey conducted by the Urban Local Body (ULB)"),
            _buildBulletPoint("Those who can obtain a Letter of Recommendation (LoR) from local authorities or Residents' Associations"),
            _buildSectionTitle("Documents:"),
            _buildBulletPoint("Aadhaar card"),
            _buildBulletPoint("Passport-size photograph"),
            _buildBulletPoint("Proof of vending (site photo, self-declaration)"),
            _buildBulletPoint("Address proof"),
            _buildBulletPoint("Vending category (e.g. food, clothing, electronics)"),
          ],
        );
      case 1: // FSSAI Food Safety Registration
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNormalText("This license is mandatory for any vendor selling food or beverages, ensuring their practices meet basic food safety and hygiene standards."),
            _buildSectionTitle("Purpose:"),
            _buildBulletPoint("Legally required under FSS Act, 2006"),
            _buildBulletPoint("Boosts consumer trust and hygiene standards"),
            _buildBulletPoint("Enables participation in food festivals, delivery platforms, or ULB markets"),
            _buildBulletPoint("Required for food-related training and branding support by NULM"),
            _buildSectionTitle("Eligibility:"),
            _buildBulletPoint("Any vendor preparing, serving, or selling food–like tea stalls, juice counters, pani puri sellers, fast food vendors, etc."),
            _buildBulletPoint("Businesses with annual turnover below ₹12 lakh qualify for the Basic FSSAI Registration"),
            _buildSectionTitle("Documents:"),
            _buildBulletPoint("Aadhar card"),
            _buildBulletPoint("CoV (if available)"),
            _buildBulletPoint("Passport-size photo"),
            _buildBulletPoint("Business address"),
            _buildBulletPoint("Food category/type"),
            _buildBulletPoint("Declaration of food safety practices"),
          ],
        );
      case 2: // Trade License / Shop Establishment License
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNormalText("This license allows vendors to legally operate a fixed business (stall, kiosk, or semi-permanent space) within a city."),
            _buildSectionTitle("Purpose:"),
            _buildBulletPoint("Required to prevent fines and shutdowns by the local authority"),
            _buildBulletPoint("Helps vendors become fully compliant for tax or hygiene approvals"),
            _buildBulletPoint("Often needed for electricity, water, signage, or waste disposal permissions"),
            _buildSectionTitle("Eligibility:"),
            _buildBulletPoint("Vendors with semi-permanent shops, stalls, kiosks, or food carts in one location"),
            _buildBulletPoint("Typically issued by the Municipal Corporation under local by laws"),
            _buildSectionTitle("Documents:"),
            _buildBulletPoint("Aadhaar card"),
            _buildBulletPoint("CoV or LoR"),
            _buildBulletPoint("Site photo or location proof"),
            _buildBulletPoint("Owner/NOC letter (if on private property)"),
            _buildBulletPoint("Passport-size photo"),
            _buildBulletPoint("Rent agreement or stall permission (if any)"),
          ],
        );
      case 3: // Hawker License
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNormalText("Authorizes mobile vendors to sell goods or services on foot, bicycle, or handcarts within designated areas or city routes."),
            _buildSectionTitle("Purpose:"),
            _buildBulletPoint("Grants right to roam and vend in selected city zones"),
            _buildBulletPoint("Prevents harassment, seizure of goods, or police fines"),
            _buildBulletPoint("Promotes livelihood mobility for small daily earners"),
            _buildSectionTitle("Eligibility:"),
            _buildBulletPoint("Vendors selling on the move (e.g., ice-cream sellers, flower vendors, balloon sellers)"),
            _buildBulletPoint("Often combined with CoV for urban route permissions"),
            _buildSectionTitle("Documents:"),
            _buildBulletPoint("Aadhaar card"),
            _buildBulletPoint("CoV or LoR"),
            _buildBulletPoint("Site photo (if applicable)"),
            _buildBulletPoint("Passport-size photo"),
            _buildBulletPoint("Proof of mobile vending setup (e.g., cart/cycle photo)"),
          ],
        );
      case 4: // No Objection Certificate (NOC)
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNormalText("A written approval from a property owner or local authority allowing the vendor to operate near or on a private/public space."),
            _buildSectionTitle("Purpose:"),
            _buildBulletPoint("Prevents future eviction or legal complaints"),
            _buildBulletPoint("Supports application for trade or food licenses"),
            _buildBulletPoint("Helps vendors maintain peace with local residents and authorities"),
            _buildSectionTitle("Eligibility:"),
            _buildBulletPoint("Vendors operating near private institutions (schools, hospitals, parks, societies, etc.)"),
            _buildBulletPoint("Required where the land is not managed by ULB or TVC"),
            _buildSectionTitle("Documents:"),
            _buildBulletPoint("Aadhaar card"),
            _buildBulletPoint("CoV or LoR"),
            _buildBulletPoint("Site location photo"),
            _buildBulletPoint("Written permission letter from landowner / RWA / authority"),
            _buildBulletPoint("Address proof"),
          ],
        );
      case 5: // Labour Card / Unorganized Worker ID
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNormalText("Registers street vendors as unorganized sector workers to access insurance, pension, maternity, and accident benefits."),
            _buildSectionTitle("Purpose:"),
            _buildBulletPoint("Gives access to accident insurance, PM pension schemes, and e-Shram benefits"),
            _buildBulletPoint("Helps in disaster-relief, government aid, or COVID-type cash transfers"),
            _buildBulletPoint("Increases policy inclusion for street vendors"),
            _buildSectionTitle("Eligibility:"),
            _buildBulletPoint("Street vendors between 16–59 years"),
            _buildBulletPoint("Not registered under EPFO/ESIC (organized sector)"),
            _buildBulletPoint("Must be working in informal conditions (no fixed employer)"),
            _buildSectionTitle("Documents:"),
            _buildBulletPoint("Aadhaar card"),
            _buildBulletPoint("Bank account details"),
            _buildBulletPoint("Mobile number"),
            _buildBulletPoint("Passport-size photo"),
            _buildBulletPoint("CoV or LoR (if required by state)"),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  // Helper for normal text
  Widget _buildNormalText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Helper for section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Helper for bullet points
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, left: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}