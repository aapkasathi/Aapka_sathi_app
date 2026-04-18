import 'package:aapka_sarthi/services/registration_service.dart';
import 'package:flutter/material.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  // Controllers to manage text input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _autoFillUserDetails();
  }

  Future<void> _autoFillUserDetails() async {
    final data = await RegistrationService().getVendorProfile();
    if (data != null && mounted) {
      setState(() {
        _nameController.text = data['name'] ?? "";
        _addressController.text = data['address'] ?? "";
        _phoneController.text = data['mobile'] ?? "";
      });
    }
  }
  Future<void> _handleFormSubmit() async {
    if(_subjectController.text.isEmpty || _messageController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in both Subject and Message fields.")),
      );
      return;
    }
    setState(() => _isLoading = true);
    bool isSuccess = await RegistrationService().submitSupportTicket(name: _nameController.text.trim(), address: _addressController.text.trim(), phone: _phoneController.text.trim(), subject: _subjectController.text.trim(), message: _messageController.text.trim(),);

    setState(() => _isLoading = false);      
    if (isSuccess){
      _showSuccessDialog();
      _subjectController.clear();
      _messageController.clear();
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to submit your request. Please try again later.")),
      );
    }
    }
  

  // --- SHOW SUCCESS DIALOG FUNCTION ---

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Wrap content height
              children: [
                // 1. Icon
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 60,
                  ),
                ),
                const SizedBox(height: 20),

                // 2. Title
                const Text(
                  "Thank You!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),

                // 3. Message
                const Text(
                  "We have received your request.\nWe will connect with you soon.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 25),

                // 4. OK Button
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.of(context).pop(); // Go back to previous screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF1A237E), // Match your app theme
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    const Color headerBgColor = Colors.white;
    const Color formBgColor = Color(0xFFFFD54F); // Mustard Yellow
    const Color fieldColor = Color(0xFFFFF9C4); // Pale Yellow

    return Scaffold(
      backgroundColor: headerBgColor, // Top half is white
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- TOP HEADER SECTION (White) ---
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button & Title
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            size: 28, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        "Help & Support",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Big Heading
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "We are here to help.",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Subheading
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Please fill out the form below and we will get back to you shortly.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: formBgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),

                      // --- Form Fields ---
                      _buildLabel("Name"),
                      _buildTextField(
                          controller: _nameController,
                          hintText: "Enter your full name",
                          color: fieldColor),
                      const SizedBox(height: 16),

                      _buildLabel("Address"),
                      _buildTextField(
                          controller: _addressController,
                          hintText: "Enter your full address",
                          color: fieldColor),
                      const SizedBox(height: 16),

                      _buildLabel("Phone No."),
                      _buildTextField(
                          controller: _phoneController,
                          hintText: "+91 XXXXX XXXXX",
                          keyboardType: TextInputType.phone,
                          color: fieldColor),
                      const SizedBox(height: 16),

                      _buildLabel("Subject"),
                      _buildTextField(
                          controller: _subjectController,
                          hintText: "e.g. Payment Issue, App Bug",
                          color: fieldColor),
                      const SizedBox(height: 16),

                      _buildLabel("Message"),
                      _buildTextField(
                          controller: _messageController,
                          hintText: "Describe your issue in detail...",
                          maxLines: 5,
                          color: fieldColor),

                      const SizedBox(height: 30), // Space before button

                      // --- Submit Button ---
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed:_isLoading?null: _handleFormSubmit, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF1A237E), // Dark Blue
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: _isLoading? const CircularProgressIndicator(color: Colors.white): Text(
                            "Submit",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      // Spacer for Safe Area
                      SizedBox(height: bottomPadding + 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widget: Label Text ---
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // --- Helper Widget: Styled Text Field ---
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required Color color,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black38),
        ),
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}
