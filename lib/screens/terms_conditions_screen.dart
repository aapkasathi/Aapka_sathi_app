import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD54F), // Golden Yellow Background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          "Terms & Conditions",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF5D2), // Light Cream Box
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("1. Introduction & Acceptance of Terms"),
                  _buildNormalText(
                      'Welcome to Aapka Sarthi ("we," "our," "us"), a mobile application and platform dedicated to supporting street vendors and micro entrepreneurs. These Terms & Conditions ("Terms") govern your use of the Aapka Sarthi mobile application ("App") and related services. By downloading, accessing, or using the App, you agree to be bound by these Terms, our Privacy Policy, and any additional terms communicated to you. If you do not agree, please stop using the App immediately.'),

                  _buildSectionTitle("2. Eligibility"),
                  _buildBulletPoint("You must be at least 18 years old to use the App."),
                  _buildBulletPoint("If you are under 18, you may use the App only with verified parental or guardian consent, in compliance with the Digital Personal Data Protection Act, 2023."),
                  _buildBulletPoint("By using the App, you confirm that you meet these eligibility requirements."),

                  _buildSectionTitle("3. Description of Services"),
                  _buildNormalText("Aapka Sarthi provides services to empower street vendors, including but not limited to:"),
                  _buildBulletPoint("Registration Support: Assistance with vendor registration and licensing."),
                  _buildBulletPoint("Legal Aid: Guidance on government documentation and compliance."),
                  _buildBulletPoint("Training: Hygiene, safety, and skill development programs."),
                  _buildBulletPoint("Information Access: Updates on government schemes, policies, and market opportunities."),
                  _buildBulletPoint("Connections: Linking vendors to municipal bodies, NGOs, hospitals, and advocates."),
                  _buildNormalText("We reserve the right to add, modify, or discontinue any service at our discretion."),

                  _buildSectionTitle("4. User Responsibilities"),
                  _buildBulletPoint("Provide accurate, complete, and updated personal and legal information."),
                  _buildBulletPoint("Use the App lawfully and respectfully, without engaging in fraud, harassment, or illegal activities."),
                  _buildBulletPoint("Maintain the confidentiality of your login credentials and notify us immediately if you suspect unauthorized access."),
                  _buildBulletPoint("Refrain from attempting to hack, disrupt, or gain unauthorized access to any part of the App."),
                  _buildBulletPoint("Follow all applicable laws, including the Street Vendors (Protection of Livelihood and Regulation of Street Vending) Act, 2014."),

                  _buildSectionTitle("5. Intellectual Property Rights"),
                  _buildBulletPoint("All content, logos, graphics, designs, and materials on the App are the intellectual property of Aapka Sarthi and are protected under applicable copyright and trademark laws."),
                  _buildBulletPoint("You may not copy, modify, reproduce, distribute, or create derivative works without our prior written consent."),

                  _buildSectionTitle("6. Payment & Subscription Terms (If Applicable)"),
                  _buildBulletPoint("Certain services may be subject to subscription fees or service charges."),
                  _buildBulletPoint("Payment terms, including pricing, will be clearly disclosed before purchase."),
                  _buildBulletPoint("All payments are non-refundable unless otherwise stated by law."),

                  _buildSectionTitle("7. Limitation of Liability"),
                  _buildBulletPoint("Aapka Sarthi will not be liable for indirect, incidental, or consequential damages resulting from the use of the App."),
                  _buildBulletPoint("We do not guarantee uninterrupted or error-free service."),
                  _buildBulletPoint("We are not responsible for losses caused by third-party service providers, including government agencies or NGOs."),

                  _buildSectionTitle("8. Suspension or Termination"),
                  _buildNormalText("We may suspend or terminate your access to the App without notice if you:"),
                  _buildBulletPoint("Violate these Terms or applicable laws."),
                  _buildBulletPoint("Misuse the App or engage in fraudulent activities."),
                  _buildBulletPoint("Pose a security risk or disrupt the functioning of the App."),
                  _buildNormalText("Upon termination, your right to use the App will end immediately, but obligations related to payments, confidentiality, and liability will survive."),

                  _buildSectionTitle("9. Modifications to Terms"),
                  _buildNormalText("We may update these Terms from time to time. Updated Terms will be posted in the App, and your continued use after changes means you accept the new Terms."),

                  _buildSectionTitle("10. Privacy & Data Protection"),
                  _buildNormalText("Your use of the App is also governed by our Privacy Policy, which explains how we collect, use, and protect your data. By using the App, you consent to our data practices as described in the Privacy Policy."),

                  _buildSectionTitle("11. Dispute Resolution & Governing Law"),
                  _buildBulletPoint("These Terms shall be governed by and interpreted in accordance with the laws of India."),
                  _buildBulletPoint("Any disputes shall be subject to the exclusive jurisdiction of the courts in Gwalior, Madhya Pradesh."),
                  _buildBulletPoint("We encourage resolving disputes amicably before pursuing legal action."),

                  _buildSectionTitle("12. Contact Us"),
                  _buildNormalText("For any questions, feedback, or complaints regarding these Terms, please contact: contact@aapkasarthi.in."),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper Widget for Section Titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  // Helper Widget for Normal Paragraph Text
  Widget _buildNormalText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          height: 1.5,
        ),
      ),
    );
  }

  // Helper Widget for Aligned Bullet Points
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "• ",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}