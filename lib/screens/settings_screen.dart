import 'package:flutter/material.dart';

// --- IMPORTS FOR YOUR LEGAL PAGES ---
import 'disclaimer_screen.dart';
import 'terms_conditions_screen.dart';
import 'privacy_policy_screen.dart';
import 'request_callback_screen.dart';
import 'package:aapka_sarthi/screens/profile_screen.dart';
import 'faq_screen.dart';
import 'package:aapka_sarthi/screens/languages_options.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  
  bool _trainingEnabled = false;
  bool _legalAidEnabled = true;
  bool _schemesEnabled = true;
  bool _announcementEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD54F), 
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
          "Settings",
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
              color: const Color(0xFFFFF5D2), // Light Cream Card
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Account Setting Section ---
                  _buildSectionHeader("Account Setting"),
                  _buildMenuItem("Edit Profile", onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),),
                    );
                  }),
                  _buildMenuItem("Change Password/Mobile Pin", onTap: () {
                    // Navigate to Change Password page
                  }),
                  _buildMenuItem("Linked Documents", onTap: () {
                    // Navigate to Linked Documents page
                  }),
                  _buildMenuItem("Language", onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LanguagesOptions(),),
                    );
                      
                  }),

                  const SizedBox(height: 20),

                  // --- Notification Setting Section ---
                  _buildSectionHeader("Notification Setting"),
                  _buildToggleItem("Training", _trainingEnabled,
                      (val) => setState(() => _trainingEnabled = val)),
                  _buildToggleItem("Legal Aid", _legalAidEnabled,
                      (val) => setState(() => _legalAidEnabled = val)),
                  _buildToggleItem("Schemes", _schemesEnabled,
                      (val) => setState(() => _schemesEnabled = val)),
                  _buildToggleItem("Announcement", _announcementEnabled,
                      (val) => setState(() => _announcementEnabled = val)),

                  const SizedBox(height: 20),

                  // --- Legal & Info Section ---
                  _buildSectionHeader("Legal & Info"),

                  // 1. Terms & Conditions Navigation
                  _buildMenuItem("Terms & Conditions", onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TermsConditionsScreen()),
                    );
                  }),

                  // 2. Privacy Policy Navigation
                  _buildMenuItem("Privacy Policy", onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyScreen()),
                    );
                  }),

                  // 3. Disclaimer Navigation
                  _buildMenuItem("Disclaimer", onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DisclaimerScreen()),
                    );
                  }),

                  const SizedBox(height: 20),

                  // --- Contact Section ---
                  _buildSectionHeader("Contact"),
                  _buildMenuItem("FAQS", onTap: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FaqScreen()),
                    );
                  }),
                  _buildMenuItem("Request a Callback", onTap: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RequestCallbackScreen()),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey[700],
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  
  Widget _buildMenuItem(String title, {required VoidCallback onTap}) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          trailing:
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          onTap: onTap,
          contentPadding: EdgeInsets.zero,
          dense: true,
          visualDensity: VisualDensity.compact,
        ),
        const Divider(
            height: 1,
            thickness: 0.5,
            color: Colors.grey), 
      ],
    );
  }

  // Widget for menu items with a toggle switch
  Widget _buildToggleItem(
      String title, bool value, ValueChanged<bool> onChanged) {
    return Column(
      children: [
        SwitchListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF1A237E), 
          activeTrackColor: const Color(0xFF1A237E).withOpacity(0.3),
          contentPadding: EdgeInsets.zero,
          dense: true,
          visualDensity: VisualDensity.compact,
        ),
        const Divider(
            height: 1,
            thickness: 0.5,
            color: Colors.grey), // 
      ],
    );
  }
}
