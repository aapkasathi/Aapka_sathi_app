import 'package:flutter/material.dart';
// Ensure this import points to your actual Dashboard file
import 'package:aapka_sathi/screens/home/dashboard_screen.dart'; 

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  bool _isEditing = false;
  final TextEditingController _mobileController = TextEditingController(text: "mobille no.");
  final TextEditingController _locationController = TextEditingController(text: "vendor location");
  final TextEditingController _cartNameController = TextEditingController(text: "cart name");
  final TextEditingController _cartLocationController = TextEditingController(text: "cart location");

  
  final String _userName = "user";
  final String _businessType = "business type";
  final String _vendorId = "Vendor ID";

  // --- Colors ---
  final Color _headerYellow = const Color(0xFFFFD54F);
  final Color _inputBoxColor = const Color(0xFFF9F9F9); 
  final Color _textColor = Colors.black87;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double headerHeight = size.height * 0.38;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, 
      body: Stack(
        children: [
          // ============================================================
          // 1. TOP SECTION (Yellow Header) - STATIC / NON-EDITABLE
          // ============================================================
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: headerHeight,
            child: Container(
              decoration: BoxDecoration(
                color: _headerYellow,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // --- Navigation Row ---
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 28),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const DashboardScreen()),
                              );
                            },
                          ),
                          // Edit Menu
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert, color: Colors.black, size: 28),
                            onSelected: (value) {
                              if (value == 'edit') {
                                setState(() {
                                  _isEditing = true; // Enables the bottom fields
                                });
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return [
                                const PopupMenuItem<String>(
                                  value: 'edit',
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit, color: Colors.black54, size: 20),
                                      SizedBox(width: 10),
                                      Text("Edit Profile"),
                                    ],
                                  ),
                                ),
                              ];
                            },
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(), 
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(color: Colors.white, width: 3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child: const Icon(Icons.person, size: 60, color: Colors.grey),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              _userName,
                              style: TextStyle(
                                fontSize: size.width * 0.06,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              _businessType,
                              style: TextStyle(
                                fontSize: size.width * 0.04,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              _vendorId,
                              style: const TextStyle(fontSize: 12, color: Colors.black45),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

         Positioned.fill(
            top: headerHeight,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 30, 
                left: 25, 
                right: 25, 
                bottom: MediaQuery.of(context).viewInsets.bottom + 100
              ), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildField("Mobile No.*", _mobileController, isEditable: _isEditing), 
                  
                  const SizedBox(height: 20),
                  
                  _buildField("Location*", _locationController, isEditable: _isEditing),
                  
                  const SizedBox(height: 20),
                  
                  _buildField("Cart Name*", _cartNameController, isEditable: _isEditing),
                  
                  const SizedBox(height: 20),
                  
                  _buildField("Cart Location*", _cartLocationController, isEditable: _isEditing),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          if (_isEditing)
            Positioned(
              top: headerHeight - 25, 
              right: 40,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isEditing = false;
                  });
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Profile Updated Successfully!"),
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 6,
                        spreadRadius: 2,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: const Icon(Icons.check, color: Colors.green, size: 30),
                ),
              ),
            ),
        ],
      ),
    );
  }

  
  Widget _buildField(String label, TextEditingController controller, {required bool isEditable}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 6.0),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.brown[600],
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: _inputBoxColor,
            borderRadius: BorderRadius.circular(20),
            border: isEditable 
              ? Border.all(color: Colors.brown.shade200, width: 1) 
              : Border.all(color: Colors.transparent),
          ),
          child: TextField(
            controller: controller,
            
            enabled: isEditable, 
            style: TextStyle(
              color: _textColor,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: "Enter $label",
              hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }
}