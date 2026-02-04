import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RenewalForm extends StatefulWidget {
  const RenewalForm({super.key});

  @override
  State<RenewalForm> createState() => _RenewalFormState();
}

class _RenewalFormState extends State<RenewalForm> {
  // --- Controllers ---
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _cartNameController = TextEditingController();
  
  String? _selectedPaymentMode;
  final List<String> _paymentOptions = ['Online', 'Offline'];

  XFile? _pickedImage;

  // --- Image Picker Function ---
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _pickedImage = image;
        });
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Get the Safe Area Bottom Padding (Height of the phone's navigation bar)
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    
    // Colors
    const Color headerBgColor = Colors.white;
    const Color formBgColor = Color(0xFFFFD54F); 
    const Color fieldColor = Color(0xFFFFF9C4);  

    return Scaffold(
      backgroundColor: headerBgColor,
      resizeToAvoidBottomInset: true, 
      body: SafeArea(
        bottom: false, 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- TOP HEADER SECTION (White) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, size: 28, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        "Renewal Form",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Renew your subscription.",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Fill out the details below to renew your Aapka Sathi membership.",
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

            // --- BOTTOM FORM SECTION (Yellow Container) ---
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
                  // Bouncing physics feels better on iOS
                  physics: const BouncingScrollPhysics(), 
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),

                      // --- Fields ---
                      _buildLabel("Your Name*"),
                      _buildTextField(controller: _nameController, hintText: "Enter your full name", color: fieldColor),
                      const SizedBox(height: 16),

                      _buildLabel("Phone Number*"),
                      _buildTextField(controller: _phoneController, hintText: "+91 XXXXX XXXXX", keyboardType: TextInputType.phone, color: fieldColor),
                      const SizedBox(height: 16),

                      _buildLabel("Today's Date*"),
                      _buildTextField(controller: _dateController, hintText: "DD/MM/YYYY", color: fieldColor),
                      const SizedBox(height: 16),

                      _buildLabel("Aapka Sathi ID*"),
                      _buildTextField(controller: _idController, hintText: "e.g. AS-2024-001", color: fieldColor),
                      const SizedBox(height: 16),

                      _buildLabel("Cart Name*"),
                      _buildTextField(controller: _cartNameController, hintText: "e.g. Gupta Vegetables", color: fieldColor),
                      const SizedBox(height: 16),

                      _buildLabel("Payment Mode*"),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: fieldColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedPaymentMode,
                            hint: const Text("Select Payment Method", style: TextStyle(color: Colors.black38)),
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
                            dropdownColor: fieldColor,
                            items: _paymentOptions.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedPaymentMode = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      _buildLabel("Photo Upload*"),
                      InkWell(
                        onTap: _pickImage,
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: fieldColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: _pickedImage == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.cloud_upload_outlined, color: Colors.black38, size: 30),
                                    SizedBox(height: 5),
                                    Text("Tap to upload photo", style: TextStyle(color: Colors.black38)),
                                  ],
                                )
                              : Row(
                                  children: [
                                    const Icon(Icons.check_circle, color: Colors.green, size: 30),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        _pickedImage!.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const Icon(Icons.edit, color: Colors.black54),
                                  ],
                                ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // --- Submit Button ---
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            // Submission Logic
                            if (_pickedImage == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Please upload a photo")),
                              );
                            } else {
                              // Proceed
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A237E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            "Submit Request",
                            style: TextStyle(
                              color: Colors.white, 
                              fontSize: 18, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      
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

  // Helper Widgets
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

  Widget _buildTextField({
    TextEditingController? controller,
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black38),
        ),
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}