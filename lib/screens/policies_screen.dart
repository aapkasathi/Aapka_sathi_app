import 'package:flutter/material.dart';

class PoliciesScreen extends StatefulWidget {
  const PoliciesScreen({super.key});

  @override
  State<PoliciesScreen> createState() => _PoliciesScreenState();
}

class _PoliciesScreenState extends State<PoliciesScreen> {
  // Used to manage the expanded state of the tiles so only one opens at a time
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
          "Policies Information",
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
          // 1
          _buildPolicyItem(0, "PM SVANidhi (Prime Minister Street Vendor's AtmaNirbhar Nidhi)"),
          const SizedBox(height: 15), // Space between items
          // 2
          _buildPolicyItem(1, "Street Vendors (Protection of Livelihood and regulation of Street Vending) ACT 2014"),
          const SizedBox(height: 15),
          // 3
          _buildPolicyItem(2, "NULM-Support to Urban Street Vendors (SUSV)"),
          const SizedBox(height: 15),
          // 4
          _buildPolicyItem(3, "PM Jan Dhan Yojana - Financial Access for All"),
          const SizedBox(height: 15),
          // 5
          _buildPolicyItem(4, "e-Shram - National Database for Unorganized Workers"),
          const SizedBox(height: 15),
          // 6
          _buildPolicyItem(5, "PM Suraksha Bima Yojana (PMSBY)"),
          const SizedBox(height: 15),
          // 7
          _buildPolicyItem(6, "PM Jeevan Jyoti Bima Yojana (PMJJBY)"),
          const SizedBox(height: 15),
          // 8
          _buildPolicyItem(7, "Atal Pension Yojana (APY)"),
          const SizedBox(height: 15), 
          //9
          _buildPolicyItem(8, "Madhya Pradesh Street Vendors (Protection of Livelihood and Regulation of Street Vending) Scheme, 2020"),
          const SizedBox(height: 15), 
          //10
          _buildPolicyItem(9, "Mukhyamantri Jan Kalyan (Sambal 2.0) Scheme"),
          const SizedBox(height: 15),
          //11
          _buildPolicyItem(10, "Mukhyamantri Swarozgar / Self-Employment Schemes (Madhya Pradesh)"),
          const SizedBox(height: 15),
          //12
          _buildPolicyItem(11, "MP Urban & Rural Livelihood Promotion Programs (ULBs & Panchayats)"),
          const SizedBox(height: 30), // Extra space at bottom
        ],
      ),
    );
  }

  // Widget for each expandable policy item structure
  Widget _buildPolicyItem(int index, String title) {
    bool isExpanded = _expandedIndex == index;

    return Container(
      decoration: BoxDecoration(
        // Rounded corners for the whole card
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          // Optional: slight shadow for depth
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
            
            // --- COLORS MATCHING YOUR IMAGE ---
            collapsedBackgroundColor: const Color(0xFFFFD54F), // Yellow Button
            backgroundColor: const Color(0xFFFFD54F), // Header stays Yellow when open
            
            // --- ICONS & TEXT ---
            iconColor: Colors.black,
            collapsedIconColor: Colors.black,
            // Custom trailing icon to match standard dropdown feel
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
                fontSize: 15,
              ),
            ),
            onExpansionChanged: (expanded) {
              setState(() {
                _expandedIndex = expanded ? index : null;
              });
            },
            children: [
              // The Content Box (Light Cream)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF5D2), // Light Cream content background
                ),
                child: _buildPolicyContent(index),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function containing the EXACT text for 8 policies (Content Unchanged)
  Widget _buildPolicyContent(int index) {
    switch (index) {
      case 0: // pm savnidhi
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            _buildNormalText("Collateral-free loan scheme to help street vendors restart, grow, and digitize their businesses."),
            
            _buildSectionTitle("Key Highlights:"),
            _buildBulletPoint("Loan in 3 stages: ₹10,000 → ₹20,000 → ₹50,000"),
            _buildBulletPoint("7% interest subsidy on timely repayment"),
            _buildBulletPoint("Cashback up to ₹1,200/year for digital transactions"),
            _buildBulletPoint("No guarantor required; linked to credit scores"),

            _buildSectionTitle("Eligibility:"),
            _buildBulletPoint("Street vendors active before 24 March 2020"),
            _buildBulletPoint("Must have Certificate of Vending (CoV) or Letter of Recommendation (LoR)"),

            _buildSectionTitle("Why It's Important:"),
            _buildBulletPoint("Boosts financial inclusion, self-employment, and digital payment adoption"),
          ],
        );
      case 1: //street vendors act 2014
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNormalText("This Act provides legal protection and regulation for street vending through licensing, zoning, and grievance redressal."),
            
            _buildSectionTitle("Key Highlights:"),
            _buildBulletPoint("Formation of Town Vending Committees (TVCs)"),
            _buildBulletPoint("Issuance of Certificate of Vending (CoV)"),
            _buildBulletPoint("Cities must define vending zones"),
            _buildBulletPoint("Promotes dignity and protection for vendors"),

            _buildSectionTitle("Eligibility:"),
            _buildBulletPoint("Urban street vendors in government surveys"),
            _buildBulletPoint("Vendors recommended by RWAs or associations"),

            _buildSectionTitle("Why It's Important:"),
            _buildBulletPoint("Provides vendors with legal status, regulation, and security"),
          ],
        );
      case 2: // NULM SUSV
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNormalText("Part of DAY-NULM, it supports vendors with identity, training, infrastructure, and financial linkages."),
            
            _buildSectionTitle("Key Highlights:"),
            _buildBulletPoint("Smart ID or with QR codes"),
            _buildBulletPoint("Training on hygiene,POS and waste management"),
            _buildBulletPoint("95% grant for carts, kiosks, solar lights"),
            _buildBulletPoint("Vendor zones and market support"),
            _buildBulletPoint("PM SAVNidhi helpdesk"),

            _buildSectionTitle("Eligibility:"),
            _buildBulletPoint("Recognized street vendors or surveyed by ULBS"),
            _buildBulletPoint("Holders of CoV or Letter of Recommendation"),

            _buildSectionTitle("Why It's Important:"),
            _buildBulletPoint("Empowers vendors with formal identity, skills, and financial inclusion"),
          ],
        );
      case 3: // PM Jan Dhan Yojana - Financial Access for All
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNormalText("A financial inclusion scheme offering zero-balance accounts and access to essential banking services."),
            
            _buildSectionTitle("Key Highlights:"),
            _buildBulletPoint("Zero-balance savings account with RuPay card"),
            _buildBulletPoint("Accident insurance cover up to 2 lakh"),
            _buildBulletPoint("DBT-enabled for government subsidies"),
            _buildBulletPoint("Overdraft facility up to ₹10,000"),
          

            _buildSectionTitle("Eligibility:"),
            _buildBulletPoint("Indian citizens aged 10 years and above"),
            _buildBulletPoint("No existing basic savings account"),

            _buildSectionTitle("Why It's Important:"),
            _buildBulletPoint("Enables access to government benefits, loans, and insurance for vendors"),
          ],
        );
      case 4: // e-Shram - National Database for Unorganized Workers 
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNormalText("This Act provides legal protection and regulation for street vending through licensing, zoning, and grievance redressal."),
            
            _buildSectionTitle("Key Highlights:"),
            _buildBulletPoint("e-Shram card with 12-digit Universal Account Number (UAN)"),
            _buildBulletPoint("Free accident insurance up to 2 lakh"),
            _buildBulletPoint("Access to pensions, ration cards, DBT, etc."),
            _buildBulletPoint("Aadhaar-linked for easy verification"),

            _buildSectionTitle("Eligibility:"),
            _buildBulletPoint("Age 16-59 years"),
            _buildBulletPoint("Unorganized workers not covered under EPFO/ESIC"),
            _buildBulletPoint("Aadhaar, bank account, and mobile number required"),

            _buildSectionTitle("Why It's Important:"),
            _buildBulletPoint("Enables street vendors to receive identity, security, and welfare benefits"),
          ],
        );
      case 5: // PM Suraksha Bima Yojana (PMSBY)
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNormalText("A low-cost accident insurance scheme offering protection against death or disability due to accidents."),
            
            _buildSectionTitle("Key Highlights:"),
            _buildBulletPoint("Annual premium: ₹20 only"),
            _buildBulletPoint("2 lakh for death or full disability"),
            _buildBulletPoint("1 lakh for partial disability"),
            _buildBulletPoint("Auto-renewed from bank account every June"),

            _buildSectionTitle("Eligibility:"),
            _buildBulletPoint("Age 18-70 years"),
            _buildBulletPoint("Must have savings account linked to Aadhaar"),

            _buildSectionTitle("Why It's Important:"),
            _buildBulletPoint("Offers financial protection in case of accident for low-income groups"),
          ],
        );
      case 6: // PM Jeevan Jyoti Bima Yojana (PMJJBY)
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNormalText("A life insurance scheme offering financial protection to families in case of death of the insured person."),
            
            _buildSectionTitle("Key Highlights:"),
            _buildBulletPoint("Annual premium: ₹436"),
            _buildBulletPoint("2 lakh cover on death (natural or accidental)"),
            _buildBulletPoint("Auto-debited yearly on 31st May"),

            _buildSectionTitle("Eligibility:"),
            _buildBulletPoint("Age 18-50 years"),
            _buildBulletPoint("Must have Aadhaar and savings account"),

            _buildSectionTitle("Why It's Important:"),
            _buildBulletPoint("Ensures life cover and stability for vendor families"),
          ],
        );
      case 7: // Atal Pension Yojana (APY)
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNormalText("A pension scheme to provide guaranteed monthly income after retirement for unorganized workers."),
            
            _buildSectionTitle("Key Highlights:"),
            _buildBulletPoint("Pension: ₹1,000 to ₹5,000 per month after age 60"),
            _buildBulletPoint("Contributions auto-debited from bank account"),
            _buildBulletPoint("Government-backed with tax benefits"),

            _buildSectionTitle("Eligibility:"),
            _buildBulletPoint("Age 18-40 years"),
            _buildBulletPoint("Aadhaar-linked savings account"),
            _buildBulletPoint("Aadhaar-linked savings account"),

            _buildSectionTitle("Why It's Important:"),
            _buildBulletPoint("Provides old-age income security for vendors in the informal sector"),
          ],
        );
        case 8: // Madhya Pradesh Street Vendors (Protection of Livelihood and Regulation of Street Vending) Scheme, 2020
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNormalText("Implements the Street Vendors Act, 2014 at the state level to protect livelihoods and regulate street vending across Madhya Pradesh."),
            
            _buildSectionTitle("Key Highlights:"),
            _buildBulletPoint(" State-level implementation of Street Vendors Act, 2014"),
            _buildBulletPoint("Mandatory survey and identification of street vendors"),
            _buildBulletPoint("Issuance of Certificate of Vending (CoV)"),
            _buildBulletPoint("Formation of Town Vending Committees (TVCs)"),
            _buildBulletPoint("Protection from harassment and forced eviction"),

            _buildSectionTitle("Eligibility:"),
            _buildBulletPoint("Street vendors identified in ULB / municipal surveys"),
            _buildBulletPoint("Vendors operating in urban and semi-urban areas"),
            _buildBulletPoint("Vendors recommended by Town Vending Committees"),

            _buildSectionTitle("Why It's Important:"),
            _buildBulletPoint("Provides legal recognition to street vendors in MP"),
            _buildBulletPoint("Ensures safe and regulated vending spaces"),
            _buildBulletPoint("Prevents illegal eviction and loss of livelihood"),
            _buildBulletPoint("Integrates vendors into urban planning"),
            _buildBulletPoint("Strengthens vendor rights at the state level")

          ],
        );
        
        case 10: // Mukhyamantri Swarozgar / Self-Employment Schemes (Madhya Pradesh)
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNormalText("Promotes self-employment and small business development by providing financial assistance and support to eligible individuals, including street vendors, in Madhya Pradesh."),
            
            _buildSectionTitle("Key Highlights:"),
            _buildBulletPoint("State government self-employment promotion scheme"),
            _buildBulletPoint("Financial assistance for small businesses and vendors"),
            _buildBulletPoint("Support for business expansion and formalisation"),
            _buildBulletPoint("Subsidy / margin money support (scheme-specific)"),
            _buildBulletPoint("Implemented through district administrations and ULBs"),
            _buildBulletPoint("Encourages entrepreneurship among informal workers"),

            _buildSectionTitle("Eligibility:"),
            _buildBulletPoint("Resident of Madhya Pradesh"),
            _buildBulletPoint("Individuals engaged in self-employment or small business"),
            _buildBulletPoint("Street vendors and micro-entrepreneurs eligible"),
            _buildBulletPoint("Must have basic identity documents and bank account"),
            _buildBulletPoint("Eligibility may vary as per scheme variant and district"),

            _buildSectionTitle("Why It's Important:"),
            _buildBulletPoint("Helps street vendors upgrade their livelihood"),
            _buildBulletPoint("Reduces dependency on informal loans"),
            _buildBulletPoint("Encourages transition from informal to formal business"),
            _buildBulletPoint("Supports sustainable income generation"),
            _buildBulletPoint("Strengthens the state’s self-employment ecosystem"),

          ],
        );
        case 11: // MP Urban & Rural Livelihood Promotion Programs (ULBs & Panchayats)
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNormalText("Supports livelihood development of street vendors and informal workers through training, market access, and local-level support in urban and rural areas of Madhya Pradesh."),
            
            _buildSectionTitle("Key Highlights:"),
            _buildBulletPoint("Implemented through Urban Local Bodies (ULBs) and Gram Panchayats"),
            _buildBulletPoint("Focus on livelihood promotion and income generation"),
            _buildBulletPoint("Skill development and capacity building programs"),
            _buildBulletPoint("Support for digital payments and formal inclusion"),
            _buildBulletPoint("Market linkage through local fairs, haats, and vending areas"),
            _buildBulletPoint("Vendor awareness on hygiene, safety, and compliance"),

            _buildSectionTitle("Eligibility:"),
            _buildBulletPoint("Street vendors and informal workers"),
            _buildBulletPoint("Operating in urban, semi-urban, or rural areas"),
            _buildBulletPoint("Identified by ULBs, Nagar Panchayats, or Gram Panchayats"),
            _buildBulletPoint("Must have basic identity documents and bank account"),

            _buildSectionTitle("Why It's Important:"),
            _buildBulletPoint("Reaches vendors at the local governance level"),
            _buildBulletPoint("Improves business skills and income stability"),
            _buildBulletPoint("Encourages formalisation and digital adoption"),
            _buildBulletPoint("Strengthens urban and rural local economies"),
            _buildBulletPoint("Complements state and central vendor schemes"),

          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  // Helper for normal body text
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

  // Helper for bold section titles
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

  // Helper for bullet point list items
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