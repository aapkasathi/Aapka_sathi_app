import 'package:aapka_sarthi/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:aapka_sarthi/screens/home/dashboard_screen.dart';
import 'package:aapka_sarthi/services/registration_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  final TextEditingController _mobileController =
      TextEditingController(text: "mobille no.");
  final TextEditingController _locationController =
      TextEditingController(text: "vendor location");
  final TextEditingController _cartNameController =
      TextEditingController(text: "cart name");
  final TextEditingController _cartLocationController =
      TextEditingController(text: "cart location");

  String _userName = "user";
  String _businessType = "business type";
  String _vendorId = "Vendor ID";
  String? _profilePhotoUrl;
  String? _cartPhotoUrl;
  bool _isLoading = true;

  // --- Colors ---
  final Color _headerYellow = const Color(0xFFFFD54F);
  final Color _inputBoxColor = const Color(0xFFF9F9F9);
  final Color _textColor = Colors.black87;

  @override
  void initState() {
    super.initState();
    _loadProfileData(); // Screen khulte hi data load hoga
    print("Profile check - LoggedInID: ${AuthController.loggedInUserId}");
  }

  Future<void> _loadProfileData() async {
    final data = await RegistrationService().getVendorProfile();
    if (data != null) {
      try {
        if (mounted && data != null) {
          setState(() {
            _userName = data['name'] ?? "User";
            _businessType = data['type'] ?? "Vendor";
            _vendorId = data['v_id'] ?? "N/A";
            _profilePhotoUrl = data['photo'];

            // Controllers mein bhi data bhar dete hain
            _mobileController.text = data['mobile'] ?? "";
            _locationController.text = data['address'] ?? "";
            _cartNameController.text = data['cart_name'] ?? "no cart name";
            _cartLocationController.text = data['cart_location'] ?? "";
            _cartPhotoUrl = data['cart_photo'] ?? "";

            _isLoading = false;
          });
        }
      } catch (e) {
        debugPrint("Profile Load Error: $e");
      }
    }
  }

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
                image: _cartPhotoUrl !=null ? DecorationImage(image: NetworkImage(_cartPhotoUrl!),fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken,),):null
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
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Colors.black, size: 28),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DashboardScreen()),
                              );
                            },
                          ),
                          // Edit Menu
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert,
                                color: Colors.black, size: 28),
                            onSelected: (value) {
                              if (value == 'edit') {
                                setState(() {
                                  _isEditing =
                                      true; // Enables the bottom fields
                                });
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem<String>(
                                  value: 'edit',
                                  child: Row(
                                    children: [
                                      const Icon(Icons.edit,
                                          color: Colors.black54, size: 20),
                                      const SizedBox(width: 10),
                                      Text(_isEditing ? "Editing Profile..." : "Profile",
                                      style:const TextStyle(fontWeight: FontWeight.bold)),
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
                                border:
                                    Border.all(color: Colors.white, width: 3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha:0.4),
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                backgroundImage: _profilePhotoUrl != null
                                    ? NetworkImage(_profilePhotoUrl!)
                                    : null,
                                child: _profilePhotoUrl == null
                                    ? const Icon(Icons.person,
                                        size: 60, color: Colors.grey)
                                    : null,
                              ),
// const Icon(Icons.person, size: 60, color: Colors.grey),
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
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black45),
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
                  bottom: MediaQuery.of(context).viewInsets.bottom + 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildField("Mobile No.*", _mobileController,
                      isEditable: _isEditing,
                      keyboardType: TextInputType.phone,
                      ),
                  const SizedBox(height: 20),
                  _buildField("Location*", _locationController,
                      isEditable: _isEditing),
                  const SizedBox(height: 20),
                  _buildField("Cart Name*", _cartNameController,
                      isEditable: _isEditing),
                  const SizedBox(height: 20),
                  _buildField("Cart Location*", _cartLocationController,
                      isEditable: _isEditing),
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
                // onTap: () {
                //   setState(() {
                //     _isEditing = false;
                //   });

                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(
                //       content: Text("Profile Updated Successfully!"),
                //       duration: Duration(seconds: 1),
                //       backgroundColor: Colors.green,
                //     ),
                //   );
                // },
                onTap: () async {
                  if(_mobileController.text.trim().length !=10){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter a valid 10-digit mobile number"), backgroundColor: Colors.red),
                    );
                    return;
                  }
  setState(() => _isLoading = true); // Loading chalu karein

  // Service call karein
  bool success = await RegistrationService().updateVendorProfile(
    mobile: _mobileController.text.trim(),
    address: _locationController.text.trim(),
    businessName: _cartNameController.text.trim(),
    cartLocation: _cartLocationController.text.trim(),
  );

  setState(() {
    _isLoading = false;
    if (success) {
      _isEditing = false; // Edit mode band karein
    }
  });

  if (success) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile Updated Successfully!"), backgroundColor: Colors.green),
    );
    _loadProfileData(); // Data refresh karein
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Failed to update profile"), backgroundColor: Colors.red),
    );
  }
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

  Widget _buildField(String label, TextEditingController controller,
      {required bool isEditable, TextInputType keyboardType = TextInputType.text, int? maxLength,}) {
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
            keyboardType: keyboardType,
            maxLength: maxLength,
            style: TextStyle(
              color: _textColor,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: "Enter $label",
              hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                counterText: '',
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }
}
