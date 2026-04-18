import 'dart:io';
import 'package:aapka_sarthi/services/registration_service.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:aapka_sarthi/services/storage_services.dart';

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({super.key});

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

//by soumya
class _BankDetailsScreenState extends State<BankDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _accountNumberController = TextEditingController();
  final _ifscController = TextEditingController();
  final _holderNameController = TextEditingController();
  PlatformFile? _pickedFile;
  // State for Radio Button (Yes/No)
  bool _hasBankDetails = true;
  // State for Checkbox
  bool _agreedToTerms = false;
  bool _isLoading = false;
  // File Upload State
  String? _passbookPhotoName;
  // final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _accountNumberController.dispose();
    _ifscController.dispose();
    _holderNameController.dispose();
    super.dispose();
  }

  // Function to pick file
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _pickedFile = result.files.single;
        _passbookPhotoName = _pickedFile!.name;
      });
    }
  }

  // Function to handle form submission (placeholder) (by soumya)
  void _submitBankDetails(Map personalData, Map businessData) async {
    setState(() => _isLoading = true);
    try {
      final storage = StorageService();
      final regService = RegistrationService();
      final initialUser = await regService.createInitialUser(
          mobile: personalData['mobile'] ?? "",
          stateCode: personalData['state_code'],
          districtCode: personalData['district_code']);
      final String newUserUuid = initialUser['id'];
      final String rawVendorId = initialUser['vendor_id'].toString();
      final String fullVendorId =
          rawVendorId.replaceAll(RegExp(r'[{}v_full_id:\s]'), '');
      // final userId = supabase.auth.currentUser?.id;
      // if (userId == null) throw Exception("User session missing");
      if (_hasBankDetails && _passbookPhotoName == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please upload passbook photo")));
        return;
      }

      String? profileUrl, aadharUrl, cartUrl, passbookUrl;
      if (personalData['photoPath'] != null) {
        profileUrl = await storage.uploadFile(
            file: File(personalData['photoPath']),
            userId: newUserUuid,
            folder: "profiles");
      }
      if (personalData['aadharPath'] != null) {
        aadharUrl = await storage.uploadFile(
            file: File(personalData['aadharPath']),
            userId: newUserUuid,
            folder: "aadhar_docs");
      }
      if (businessData['cart_photo_path'] != null) {
        cartUrl = await storage.uploadFile(
            file: File(businessData['cart_photo_path']),
            userId: newUserUuid,
            folder: "cart_photos");
      }
      if (_hasBankDetails && _pickedFile != null) {
        passbookUrl = await storage.uploadFile(
            file: File(_pickedFile!.path!),
            userId: newUserUuid,
            folder: "passbook_photos");
      }

      await regService.savePersonal(
        userId: newUserUuid,
        vendorId: fullVendorId,
        name: personalData['name'],
        fatherName: personalData['father'],
        address: personalData['address'],
        phone: personalData['mobile'],
        gender: personalData['gender'],
        dob: personalData['dob'],
        aadhar: personalData['aadhar'],
        state: personalData['state'],
        district: personalData['district'],
        email: personalData['email'] ?? "",
        photoUrl: profileUrl,
        aadharUrl: aadharUrl,
      );

      await regService.saveBusiness(
        userId: newUserUuid,
        businessName: businessData['business_name'] ?? 'N/A',
        businessType: businessData['business_type'] ?? 'N/A',
        hasGovId: businessData['has_gov_id'],
        cartLocation: businessData['location'] ?? "N/A",
        experienceYears:
            int.tryParse(businessData['experience']?.toString() ?? "0") ?? 0,
        vendingTime: businessData['vending_time'] ?? 'N/A',
        cartCategory: businessData['cart_category'] ?? 'N/A',
        businessAddress: businessData['location'] ?? "N/A",
        cartPhotoUrl: cartUrl,
      );
      final supabase = Supabase.instance.client;
      await supabase.from('bank_details').upsert({
        'vendor_id': newUserUuid,
        'has_bank_details': _hasBankDetails,
        'account_number': _accountNumberController.text,
        'ifsc_code': _ifscController.text.trim().toUpperCase(),
        'account_holder_name': _holderNameController.text,
        'passbook_photo_url': passbookUrl,
        'terms_accepted': _agreedToTerms,
      });
      Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false,
          arguments: {'userId': newUserUuid});
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error submitting data: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // ---Terms & Conditions & Privacy Policy Popup ---
  void _showTermsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // User must click Accept or Cancel
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFFDE7), // Cream background
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text(
            "Legal Information",
            style: TextStyle(
              color: Color(0xFF1A237E),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- SECTION 1: TERMS & CONDITIONS ---
                  const Text(
                    "Terms & Conditions",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF1A237E)),
                  ),
                  const SizedBox(height: 8),

                  _buildTermSection("1. Introduction & Acceptance of Terms",
                      "Welcome to Aapka Sathi (\"we,\" \"our,\" \"us\"), a mobile application and platform dedicated to supporting street vendors and micro entrepreneurs. These Terms & Conditions (\"Terms\") govern your use of the Aapka Sathi mobile application (\"App\") and related services. By downloading, accessing, or using the App, you agree to be bound by these Terms, our Privacy Policy, and any additional terms communicated to you. If you do not agree, please stop using the App immediately."),

                  _buildTermSection("2. Eligibility", [
                    "You must be at least 18 years old to use the App.",
                    "If you are under 18, you may use the App only with verified parental or guardian consent, in compliance with the Digital Personal Data Protection Act, 2023.",
                    "By using the App, you confirm that you meet these eligibility requirements."
                  ]),

                  _buildTermSection("3. Description of Services", [
                    "Aapka Sathi provides services to empower street vendors, including but not limited to:",
                    "Registration Support: Assistance with vendor registration and licensing.",
                    "Legal Aid: Guidance on government documentation and compliance.",
                    "Training: Hygiene, safety, and skill development programs.",
                    "Information Access: Updates on government schemes, policies, and market opportunities.",
                    "Connections: Linking vendors to municipal bodies, NGOs, hospitals, and advocates.",
                    "We reserve the right to add, modify, or discontinue any service at our discretion."
                  ]),

                  _buildTermSection("4. User Responsibilities", [
                    "Provide accurate, complete, and updated personal and legal information.",
                    "Use the App lawfully and respectfully, without engaging in fraud, harassment, or illegal activities.",
                    "Maintain the confidentiality of your login credentials and notify us immediately if you suspect unauthorized access.",
                    "Refrain from attempting to hack, disrupt, or gain unauthorized access to any part of the App.",
                    "Follow all applicable laws, including the Street Vendors (Protection of Livelihood and Regulation of Street Vending) Act, 2014."
                  ]),

                  _buildTermSection("5. Intellectual Property Rights",
                      "All content, logos, graphics, designs, and materials on the App are the intellectual property of Aapka Sathi and are protected under applicable copyright and trademark laws. You may not copy, modify, reproduce, distribute, or create derivative works without our prior written consent."),

                  _buildTermSection(
                      "6. Payment & Subscription Terms (If Applicable)", [
                    "Certain services may be subject to subscription fees or service charges.",
                    "Payment terms, including pricing, will be clearly disclosed before purchase.",
                    "All payments are non-refundable unless otherwise stated by law."
                  ]),

                  _buildTermSection("7. Limitation of Liability",
                      "Aapka Sathi will not be liable for indirect, incidental, or consequential damages resulting from the use of the App. We do not guarantee uninterrupted or error-free service. We are not responsible for losses caused by third-party service providers, including government agencies or NGOs."),

                  _buildTermSection("8. Suspension or Termination", [
                    "We may suspend or terminate your access to the App without notice if you violate these Terms or applicable laws.",
                    "Misuse the App or engage in fraudulent activities.",
                    "Pose a security risk or disrupt the functioning of the App.",
                    "Upon termination, your right to use the App will end immediately, but obligations related to payments, confidentiality, and liability will survive."
                  ]),

                  _buildTermSection("9. Modifications to Terms",
                      "We may update these Terms from time to time. Updated Terms will be posted in the App, and your continued use after changes means you accept the new Terms."),

                  _buildTermSection("10. Privacy & Data Protection",
                      "Your use of the App is also governed by our Privacy Policy, which explains how we collect, use, and protect your data. By using the App, you consent to our data practices as described in the Privacy Policy."),

                  _buildTermSection("11. Dispute Resolution & Governing Law", [
                    "These Terms shall be governed by and interpreted in accordance with the laws of India.",
                    "Any disputes shall be subject to the exclusive jurisdiction of the courts in Gwalior, Madhya Pradesh.",
                    "We encourage resolving disputes amicably before pursuing legal action."
                  ]),

                  _buildTermSection("12. Contact Us",
                      "For any questions, feedback, or complaints regarding these Terms, please contact: contact@aapkasathi.in."),

                  const SizedBox(height: 20),
                  const Divider(color: Colors.grey, thickness: 1),
                  const SizedBox(height: 10),

                  // --- SECTION 2: PRIVACY POLICY ---
                  const Text(
                    "Privacy Policy",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF1A237E)),
                  ),
                  const SizedBox(height: 8),

                  _buildTermSection("1. Introduction",
                      "Aapka Sathi (\"we,\" \"our,\" \"us\") is committed to safeguarding your privacy and ensuring the protection of your personal information. This Privacy Policy explains how we collect, use, store, and share your data in compliance with the Digital Personal Data Protection Act, 2023 (India), the Information Technology Act, 2000, and applicable data protection regulations.\nBy downloading, accessing, or using our mobile application (\"App\"), you agree to the terms of this Privacy Policy. If you do not agree, please refrain from using the App."),

                  _buildTermSection("2. Information We Collect", [
                    "Personal Information: Name, mobile number, email address, residential/business address.",
                    "Identity & Supporting Documents: ID proofs, certificates, licenses, photographs.",
                    "Location Data: Real-time or approximate location (only with your explicit consent).",
                    "Usage Data: Information about your interaction with the App (pages visited, features used).",
                    "Device & Technical Data: IP address, device type, operating system, and app version.",
                    "If you provide personal data about another person, you confirm that you have obtained their consent to share it with us."
                  ]),

                  _buildTermSection("3. Purpose of Data Processing", [
                    "Assisting in official registration, documentation, and licensing.",
                    "Notifying you about new schemes, policies, and updates.",
                    "Improving the App's functionality and personalizing your experience.",
                    "Connecting you with verified support services, such as NGOs, hospitals, and legal aid.",
                    "Ensuring compliance with legal obligations.",
                    "We will not process your personal data for purposes not stated in this Privacy Policy without obtaining your prior consent."
                  ]),

                  _buildTermSection("4. Lawful Basis for Processing", [
                    "Consent: You have given clear permission for processing your personal data.",
                    "Contractual Necessity: Processing is required to fulfill our service agreement with you.",
                    "Legal Obligation: To comply with applicable laws and regulations."
                  ]),

                  _buildTermSection("5. Information Sharing & Disclosure", [
                    "Government Authorities: For application processing, verification, and licensing (only with your consent unless legally required).",
                    "Verified Partners: NGOs, advocates, hospitals, or financial institutions, solely for your benefit.",
                    "Service Providers: Technology, hosting, and analytics partners (e.g., Firebase Authentication, database hosting).",
                    "All third parties are contractually bound to maintain confidentiality and comply with applicable data protection laws."
                  ]),

                  _buildTermSection("6. Data Retention",
                      "We retain your personal data only as long as necessary to fulfill the purposes outlined in this policy or as required by law. Upon your request for deletion, or when retention is no longer necessary, we will securely erase or anonymize your data."),

                  _buildTermSection("7. Data Security", [
                    "Encrypted data storage (AES-256 encryption).",
                    "Secure authentication via Firebase Authentication.",
                    "Access restricted to authorized personnel only.",
                    "In case of a data breach, we will promptly notify affected users and relevant authorities in accordance with applicable laws."
                  ]),

                  _buildTermSection("8. Your Rights", [
                    "Access and obtain a copy of your personal data.",
                    "Request correction of inaccurate or incomplete data.",
                    "Request deletion of your data (\"Right to be Forgotten\").",
                    "Withdraw consent for data processing.",
                    "Lodge a complaint with a data protection authority.",
                    "Requests can be made at support@aapkasathi.in. We will respond within the timelines required by law."
                  ]),

                  _buildTermSection("9. Children's Privacy",
                      "In compliance with the DPDP Act, 2023, our App is not intended for individuals under 18 years of age without verified parental or guardian consent. If we learn we have collected data from a minor without consent, we will delete it immediately."),

                  _buildTermSection("10. Use of Cookies & Tracking",
                      "If the App uses cookies, analytics tools, or similar tracking technologies, we will notify you and obtain consent where required."),

                  _buildTermSection("11. Policy Updates",
                      "We may update this Privacy Policy periodically. Changes will be notified via the App, email, or our website. Your continued use of the App after updates constitutes acceptance of the revised policy."),

                  _buildTermSection("12. Contact Us",
                      "If you have questions or concerns about this Privacy Policy or our data handling practices, please contact: contact@aapkasathi.in."),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                setState(() => _agreedToTerms = false); // Uncheck if cancelled
              },
              child: const Text("Decline", style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                setState(() => _agreedToTerms = true); // Check the box
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A237E),
              ),
              child: const Text("Accept & Continue",
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // Helper widget for a single bullet point
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ",
              style: TextStyle(fontSize: 14, color: Colors.black54)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 12, color: Colors.black54, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for Terms & Privacy sections to handle lists
  Widget _buildTermSection(String title, dynamic content) {
    Widget contentWidget;
    if (content is String) {
      contentWidget = Text(
        content,
        style:
            const TextStyle(fontSize: 12, color: Colors.black54, height: 1.3),
      );
    } else if (content is List<String>) {
      contentWidget = Column(
        children: content.map((point) => _buildBulletPoint(point)).toList(),
      );
    } else {
      contentWidget = const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.black87),
          ),
          const SizedBox(height: 4),
          contentWidget,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map? args = ModalRoute.of(context)!.settings.arguments as Map?;
    final Map personalData = args?['personal'] ?? {};
    final Map businessData = args?['business'] ?? {};
    // Get screen width for responsive buttons
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFFD54F), // Light Cream Background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD54F),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Column(
          children: [
            Text(
              "Vendor Registration",
              style: TextStyle(
                color: Color(0xFF1A237E), // Dark Blue Title
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              "Complete the form below to register as a vendor",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- STEPPER VISUAL ---
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStep(1, "Personal Details", isCompleted: true),
                  _buildStepLine(),
                  _buildStep(2, "Business Details", isCompleted: true),
                  _buildStepLine(),
                  _buildStep(3, "Bank Details", isActive: true),
                ],
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Bank Account Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),

            const SizedBox(height: 20),

            // --- YES/NO RADIO BUTTONS ---
            _buildLabel("Bank Details Available *"),
            Row(
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: _hasBankDetails,
                  activeColor: const Color(0xFF1A237E),
                  onChanged: (val) => setState(() => _hasBankDetails = val!),
                ),
                const Text("Yes"),
                const SizedBox(width: 20),
                Radio<bool>(
                  value: false,
                  groupValue: _hasBankDetails,
                  activeColor: const Color(0xFF1A237E),
                  onChanged: (val) => setState(() => _hasBankDetails = val!),
                ),
                const Text("No"),
              ],
            ),

            const SizedBox(height: 10),

            // --- CONDITIONAL FORM SECTION ---
            if (_hasBankDetails)
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // The Blue Vertical Line
                    Container(
                      width: 2,
                      color: Colors.blue,
                      margin: const EdgeInsets.only(right: 15),
                    ),

                    // The Form Fields
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("Account Number *"),
                          _buildInputField(
                              hint: "Enter Account Number",
                              controller: _accountNumberController), //edit
                          _buildLabel("IFSC Code *"),
                          _buildInputField(
                              hint: "Enter IFSC Code",
                              controller: _ifscController), //edit
                          _buildLabel("Account Holder Name *"),
                          _buildInputField(
                              hint: "Enter Holder Name",
                              controller: _holderNameController), //edit
                          _buildLabel("Passbook Photo *"),
                          _buildFileUploadBox(
                            fileName: _passbookPhotoName,
                            onTap: _pickFile,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 30),

            // --- DISCLAIMER & TERMS CHECKBOX ---
            GestureDetector(
              onTap: _showTermsDialog,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      value: _agreedToTerms,
                      activeColor: const Color(0xFF1A237E),
                      // Force showing dialog if user clicks checkbox directly
                      onChanged: (val) {
                        if (val == true) {
                          _showTermsDialog();
                        } else {
                          setState(() => _agreedToTerms = false);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      "Terms & Conditions and Privacy Policy",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF1A237E),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // --- RESPONSIVE BOTTOM BUTTONS ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button (Responsive Width)
                SizedBox(
                  width: screenWidth * 0.35,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text("Back",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),

                // Submit Button (Responsive Width)
                SizedBox(
                  width: screenWidth * 0.50,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: _agreedToTerms
                        ? () => _submitBankDetails(personalData, businessData)
                        : null, //(by soumya) Enable only if terms are accepted
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A237E),
                      disabledBackgroundColor:
                          const Color(0xFF1A237E).withOpacity(0.5),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Submit Registration",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPERS ---

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 10.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF3E2723),
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildInputField(
      {required String hint, TextEditingController? controller}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDE7),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.orange[300], fontSize: 13),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildFileUploadBox({String? fileName, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFDE7),
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Row(
              children: [
                const Icon(Icons.cloud_upload_outlined,
                    color: Colors.orange, size: 28),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileName ?? "Upload Passbook Photo",
                        style: TextStyle(
                            color: fileName != null
                                ? Colors.black
                                : Colors.grey[600],
                            fontWeight: fileName != null
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (fileName == null)
                        const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Text(
                            "Click to browse",
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                    ],
                  ),
                ),
                if (fileName != null)
                  const Icon(Icons.check_circle, color: Colors.green, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- STEPPER HELPERS ---

  Widget _buildStep(int number, String label,
      {bool isActive = false, bool isCompleted = false}) {
    Color circleColor;
    Color textColor;

    if (isActive || isCompleted) {
      circleColor = const Color(0xFF1A237E);
      textColor = const Color(0xFF1A237E);
    } else {
      circleColor = Colors.white;
      textColor = Colors.grey;
    }

    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: circleColor,
            border: Border.all(
                color: isActive || isCompleted
                    ? const Color(0xFF1A237E)
                    : Colors.grey.shade400),
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: TextStyle(
                color: isActive || isCompleted ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: textColor,
            fontWeight:
                isActive || isCompleted ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine() {
    return Expanded(
      child: Container(
        height: 2,
        color: Colors.grey.shade300,
        margin: const EdgeInsets.only(bottom: 20, left: 5, right: 5),
      ),
    );
  }
}
