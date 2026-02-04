import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          "Privacy Policy",
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
                  _buildSectionTitle("1. Introduction"),
                  _buildNormalText(
                      'Aapka Sathi ("we," "our," "us") is committed to safeguarding your privacy and ensuring the protection of your personal information. This Privacy Policy explains how we collect, use, store, and share your data in compliance with the Digital Personal Data Protection Act, 2023 (India), the Information Technology Act, 2000, and applicable data protection regulations.\n\nBy downloading, accessing, or using our mobile application ("App"), you agree to the terms of this Privacy Policy. If you do not agree, please refrain from using the App.'),

                  _buildSectionTitle("2. Information We Collect"),
                  _buildBulletPoint("Personal Information: Name, mobile number, email address, residential/business address."),
                  _buildBulletPoint("Identity & Supporting Documents: ID proofs, certificates, licenses, photographs."),
                  _buildBulletPoint("Location Data: Real-time or approximate location (only with your explicit consent)."),
                  _buildBulletPoint("Usage Data: Information about your interaction with the App (pages visited, features used)."),
                  _buildBulletPoint("Device & Technical Data: IP address, device type, operating system, and app version."),
                  _buildNormalText("If you provide personal data about another person, you confirm that you have obtained their consent to share it with us."),

                  _buildSectionTitle("3. Purpose of Data Processing"),
                  _buildBulletPoint("Assisting in official registration, documentation, and licensing."),
                  _buildBulletPoint("Notifying you about new schemes, policies, and updates."),
                  _buildBulletPoint("Improving the App's functionality and personalizing your experience."),
                  _buildBulletPoint("Connecting you with verified support services, such as NGOs, hospitals, and legal aid."),
                  _buildBulletPoint("Ensuring compliance with legal obligations."),
                  _buildNormalText("We will not process your personal data for purposes not stated in this Privacy Policy without obtaining your prior consent."),

                  _buildSectionTitle("4. Lawful Basis for Processing"),
                  _buildBulletPoint("Consent: You have given clear permission for processing your personal data."),
                  _buildBulletPoint("Contractual Necessity: Processing is required to fulfill our service agreement with you."),
                  _buildBulletPoint("Legal Obligation: To comply with applicable laws and regulations."),

                  _buildSectionTitle("5. Information Sharing & Disclosure"),
                  _buildBulletPoint("Government Authorities: For application processing, verification, and licensing (only with your consent unless legally required)."),
                  _buildBulletPoint("Verified Partners: NGOs, advocates, hospitals, or financial institutions, solely for your benefit."),
                  _buildBulletPoint("Service Providers: Technology, hosting, and analytics partners (e.g., Firebase Authentication, database hosting)."),
                  _buildNormalText("All third parties are contractually bound to maintain confidentiality and comply with applicable data protection laws."),

                  _buildSectionTitle("6. Data Retention"),
                  _buildNormalText("We retain your personal data only as long as necessary to fulfill the purposes outlined in this policy or as required by law. Upon your request for deletion, or when retention is no longer necessary, we will securely erase or anonymize your data."),

                  _buildSectionTitle("7. Data Security"),
                  _buildBulletPoint("Encrypted data storage (AES-256 encryption)."),
                  _buildBulletPoint("Secure authentication via Firebase Authentication."),
                  _buildBulletPoint("Access restricted to authorized personnel only."),
                  _buildNormalText("In case of a data breach, we will promptly notify affected users and relevant authorities in accordance with applicable laws."),

                  _buildSectionTitle("8. Your Rights"),
                  _buildBulletPoint("Access and obtain a copy of your personal data."),
                  _buildBulletPoint("Request correction of inaccurate or incomplete data."),
                  _buildBulletPoint("Request deletion of your data (\"Right to be Forgotten\")."),
                  _buildBulletPoint("Withdraw consent for data processing."),
                  _buildBulletPoint("Lodge a complaint with a data protection authority."),
                  _buildNormalText("Requests can be made at contact@aapkasathi.in. We will respond within the timelines required by law."),

                  _buildSectionTitle("9. Children's Privacy"),
                  _buildNormalText("In compliance with the DPDP Act, 2023, our App is not intended for individuals under 18 years of age without verified parental or guardian consent. If we learn we have collected data from a minor without consent, we will delete it immediately."),

                  _buildSectionTitle("10. Use of Cookies & Tracking"),
                  _buildNormalText("If the App uses cookies, analytics tools, or similar tracking technologies, we will notify you and obtain consent where required."),

                  _buildSectionTitle("11. Policy Updates"),
                  _buildNormalText("We may update this Privacy Policy periodically. Changes will be notified via the App, email, or our website. Your continued use of the App after updates constitutes acceptance of the revised policy."),

                  _buildSectionTitle("12. Contact Us"),
                  _buildNormalText("If you have questions or concerns about this Privacy Policy or our data handling practices, please contact: contact@aapkasathi.in."),
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