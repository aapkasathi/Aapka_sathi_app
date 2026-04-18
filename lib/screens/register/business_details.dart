import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessDetailsScreen extends StatefulWidget {
  const BusinessDetailsScreen({super.key});

  @override
  State<BusinessDetailsScreen> createState() => _BusinessDetailsScreenState();
}

class _BusinessDetailsScreenState extends State<BusinessDetailsScreen> {
  final _formKey = GlobalKey<FormState>(); // Validation logic

  // --- Controllers ---
  final _businessNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _vendingTimeController = TextEditingController();

  String? _selectedBusinessType;
  String? _selectedGovIdOption;
  String? _selectedCartoption;
  String? _selectedVendingtimeoption;

  String? _cartPhotoName;
  File? _cartFile;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();

  // --- Lists ---
  final List<String> _businessTypeOptions = ["Food Vendor", "Fruit Vendor", "Vegetable Vendor", "Clothing Vendor", "Electronics Vendor", "Other Vendor"];
  final List<String> _govIdOptions = ["Yes", "No"];
  final List<String> _categorycartoptions = ["fixed", "mobile"];
  final List<String> _vendingtimeoption = ["Morning", "Afternoon", "Evening", "Night", "FULL DAY"];

  @override
  void initState() {
    super.initState();
    _loadDraft(); // Draft logic loading
  }

  // --- Draft Logic---
  Future<void> _loadDraft() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _businessNameController.text = prefs.getString('b_name') ?? "";
      _locationController.text = prefs.getString('b_loc') ?? "";
      _vendingTimeController.text = prefs.getString('b_exp') ?? "";
    });
  }

  Future<void> _saveDraft() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('b_name', _businessNameController.text);
    await prefs.setString('b_loc', _locationController.text);
    await prefs.setString('b_exp', _vendingTimeController.text);
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _locationController.dispose();
    _vendingTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Receiving Step 1 Data
    final Map? args = ModalRoute.of(context)!.settings.arguments as Map?;
    final Map? personalData = args?['personal'] ??{};

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFFD54F), // Original Yellow
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Column(
          children: [
            Text("Vendor Registration", style: TextStyle(color: Color(0xFF1A237E), fontWeight: FontWeight.bold, fontSize: 22)),
            Text("Complete the form below to register as a vendor", style: TextStyle(color: Colors.black54, fontSize: 12)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Form(
          key: _formKey, // 👈 Validation link
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- STEPPER VISUAL  ---
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStep(1, "Personal Details", isCompleted: true),
                    _buildStepLine(),
                    _buildStep(2, "Business Details", isActive: true),
                    _buildStepLine(),
                    _buildStep(3, "Bank Details", isActive: false),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              const Text("Business Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
              const SizedBox(height: 20),

              // --- FORM FIELDS ---
              _buildLabel("Business Name *"),
              _buildInputField(hint: "Enter Business Name", controller: _businessNameController, errorMsg: "Enter Business Name"),

              _buildLabel("Business Type *"),
              _buildDropdown(hint: "Select Business Type", value: _selectedBusinessType, items: _businessTypeOptions,
                  onChanged: (val) => setState(() => _selectedBusinessType = val), errorMsg: "Select Business Type"),

              _buildLabel("Do you have government thella ID? *"),
              _buildDropdown(hint: "Select Option", value: _selectedGovIdOption, items: _govIdOptions,
                  onChanged: (val) => setState(() => _selectedGovIdOption = val), errorMsg: "Select an option"),

              _buildLabel("Location of Cart *"),
              _buildInputField(hint: "Enter Location", controller: _locationController, errorMsg: "Fill Location"),

              _buildLabel("How long have you been a Vendor *"),
              _buildInputField(hint: "e.g., 2 Years", controller: _vendingTimeController, errorMsg: "Enter Experience"),

              _buildLabel("Category of cart*"),
              _buildDropdown(hint: "Select Option", value: _selectedCartoption, items: _categorycartoptions,
                  onChanged: (val) => setState(() => _selectedCartoption = val), errorMsg: "Select Category"),

              _buildLabel("Time of vending*"),
              _buildDropdown(hint: "Select Option", value: _selectedVendingtimeoption, items: _vendingtimeoption,
                  onChanged: (val) => setState(() => _selectedVendingtimeoption = val), errorMsg: "Select Time"),

              const SizedBox(height: 20),
              _buildLabel("Photo of Cart *"),
              _buildFileUploadBox(fileName: _cartPhotoName, onTap: _pickImageFromCamera),

              const SizedBox(height: 40),

              // --- Back BUTTONS ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenWidth * 0.35, height: 45,
                    child: ElevatedButton(
                      onPressed: () { _saveDraft(); Navigator.pop(context); },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                      child: const Text("Back", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.45, height: 45,
                    // save next button
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (_cartFile == null) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cart photo zaroori hai")));
                            return;
                          }
                          await _saveDraft();
                          final step2Data = {
                            'business_name': _businessNameController.text,
                            'business_type': _selectedBusinessType,
                            'has_gov_id': _selectedGovIdOption == "Yes",
                            'location': _locationController.text.trim(),
                            'experience': _vendingTimeController.text.trim(),
                            'cart_category': _selectedCartoption,
                            'vending_time': _selectedVendingtimeoption,
                            'cart_photo_path': _cartFile!.path,
                          };
                          Navigator.pushNamed(context, '/register_bank', arguments: {'personal': personalData, 'business': step2Data});
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A237E), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Save & Next", style: TextStyle(color: Colors.white, fontSize: 13)),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // --- HELPERS ---

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 10.0, left: 5),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 14)),
    );
  }

  Widget _buildInputField({required String hint, required TextEditingController controller, String? errorMsg}) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFFFFDE7), borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.grey.shade300)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: TextFormField( 
          controller: controller,
          decoration: InputDecoration(hintText: hint, hintStyle: TextStyle(color: Colors.orange[300], fontSize: 13), border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
          validator: (val) => (val == null || val.isEmpty) ? errorMsg : null,
        ),
      ),
    );
  }

  Widget _buildDropdown({required String hint, required String? value, required List<String> items, required Function(String?) onChanged, String? errorMsg}) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFFFFDE7), borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.grey.shade300)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
          child: DropdownButtonFormField<String>( 
            value: value,
            isExpanded: true,
            dropdownColor: const Color(0xFFFFFDE7),
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            hint : Text(hint, style: TextStyle(color: Colors.orange[300],fontSize: 13, fontWeight: FontWeight.normal,)),
            // style : TextStyle(color: value == null? Colors.orange[300]: Colors.black, fontSize: 13,),
            decoration:  InputDecoration(hintText:hint, hintStyle: TextStyle(color: Colors.orange[300],fontSize: 13, fontWeight: FontWeight.normal,),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
            items: items.map((String val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
            onChanged: onChanged,
            validator: (val) => val == null ? errorMsg : null,
          ),
        ),
    );
  }


  Future<void> _pickImageFromCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) setState(() { _cartPhotoName = photo.name; _cartFile = File(photo.path); });
  }

  Widget _buildFileUploadBox({String? fileName, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: const Color(0xFFFFFDE7), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey.shade300)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Row(
              children: [
                const Icon(Icons.camera_alt_outlined, color: Colors.orange, size: 28),
                const SizedBox(width: 15),
                Expanded(child: Text(fileName ?? "Take Photo of Cart", style: TextStyle(color: fileName != null ? Colors.black : Colors.grey[600], fontSize: 14))),
                if (fileName != null) const Icon(Icons.check_circle, color: Colors.green, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep(int number, String label, {bool isActive = false, bool isCompleted = false}) {
    return Column(
      children: [
        Container(
          width: 30, height: 30,
          decoration: BoxDecoration(shape: BoxShape.circle, color: (isActive || isCompleted) ? const Color(0xFF1A237E) : Colors.white, border: Border.all(color: Colors.grey.shade400)),
          child: Center(child: Text(number.toString(), style: TextStyle(color: (isActive || isCompleted) ? Colors.white : Colors.grey, fontWeight: FontWeight.bold))),
        ),
        const SizedBox(height: 6),
        Text(label, style: TextStyle(fontSize: 11, color: (isActive || isCompleted) ? const Color(0xFF1A237E) : Colors.grey)),
      ],
    );
  }

  Widget _buildStepLine() {
    return Expanded(child: Container(height: 2, color: Colors.grey.shade300, margin: const EdgeInsets.only(bottom: 20, left: 5, right: 5)));
  }
}