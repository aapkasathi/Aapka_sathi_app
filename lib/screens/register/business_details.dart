import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BusinessDetailsScreen extends StatefulWidget {
  const BusinessDetailsScreen({super.key});

  @override
  State<BusinessDetailsScreen> createState() => _BusinessDetailsScreenState();
}

class _BusinessDetailsScreenState extends State<BusinessDetailsScreen> {
  // Dropdown Selections
  String? _selectedBusinessType;
  String? _selectedGovIdOption; 

  // File Selection
  String? _cartPhotoName;
  final ImagePicker _picker = ImagePicker();

  // Dropdown Options
  final List<String> _businessTypeOptions = [
    "Food Vendor",
    "Fruit Vendor",
    "Vegetable Vendor",
    "Clothing Vendor",
    "Electronics Vendor",
    "Other Vendor"
  ];

  final List<String> _govIdOptions = [
    "Yes",
    "No"
  ];
  void _handleBusinessTypeChange(String? value) {
    if (value == "Other Vendor") {
      // Show Popup Dialog
      showDialog(
        context: context,
        builder: (context) {
          String customValue = "";
          return AlertDialog(
            backgroundColor: const Color(0xFFFFFDE7),
            title: const Text("Enter Business Type"),
            content: TextField(
              onChanged: (val) {
                customValue = val;
              },
              decoration: const InputDecoration(
                hintText: "Type here...",
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (customValue.isNotEmpty) {
                    setState(() {
                      _businessTypeOptions.insert(_businessTypeOptions.length - 1, customValue);
                      _selectedBusinessType = customValue;
                    });
                  }
                  Navigator.pop(context);
                },
                child: const Text("Add"),
              ),
            ],
          );
        },
      );
    } else {
      // Normal Selection
      setState(() {
        _selectedBusinessType = value;
      });
    }
  }

  // --- LOGIC: Pick Image from Camera ---
  Future<void> _pickImageFromCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      setState(() {
        _cartPhotoName = photo.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFFD54F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Column(
          children: [
            Text(
              "Vendor Registration",
              style: TextStyle(
                color: Color(0xFF1A237E),
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Text(
              "Complete the form below to register as a vendor",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.w400,
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
                  _buildStep(2, "Business Details", isActive: true),
                  _buildStepLine(),
                  _buildStep(3, "Bank Details", isActive: false),
                ],
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Business Details",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),

            const SizedBox(height: 20),

            // --- FORM FIELDS ---
            _buildLabel("Business Name *"),
            _buildInputField(hint: "Enter Business Name"),

            _buildLabel("Business Type *"),
            _buildDropdown(
              hint: "Select Business Type",
              value: _selectedBusinessType,
              items: _businessTypeOptions,
              onChanged: _handleBusinessTypeChange,
            ),

            
            _buildLabel("Do you have government thella ID? *"),
            _buildDropdown(
              hint: "Select Option",
              value: _selectedGovIdOption,
              items: _govIdOptions,
              onChanged: (val) {
                setState(() {
                  _selectedGovIdOption = val;
                });
              },
            ),

            _buildLabel("Location of Cart *"),
            _buildInputField(hint: "Enter Location"),

            _buildLabel("How long have you been a Vendor *"),
            _buildInputField(hint: "e.g., 2 Years"),

            const SizedBox(height: 20),

            // --- FILE UPLOAD (CAMERA) ---
            _buildLabel("Photo of Cart *"),
            _buildFileUploadBox(
              fileName: _cartPhotoName,
              onTap: _pickImageFromCamera,
            ),

            const SizedBox(height: 40),

            // --- BUTTONS (BACK & NEXT) ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button
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
                    child: const Text("Back", style: TextStyle(color: Colors.white)),
                  ),
                ),

                // Save & Next Button
                SizedBox(
                  width: screenWidth * 0.45,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/register_bank'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A237E),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
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
    );
  }

  // --- WIDGET HELPERS ---

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 10.0, left: 5),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black87,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildInputField({required String hint}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDE7),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.orange[300], fontSize: 13),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDE7),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: Text(hint, style: TextStyle(color: Colors.orange[300], fontSize: 13)),
              isExpanded: true,
              dropdownColor: const Color(0xFFFFFDE7),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: onChanged,
            ),
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
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Row(
              children: [
                const Icon(Icons.camera_alt_outlined, color: Colors.orange, size: 28),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileName ?? "Take Photo of Cart",
                        style: TextStyle(
                          color: fileName != null ? Colors.black : Colors.grey[600],
                          fontWeight: fileName != null ? FontWeight.bold : FontWeight.normal,
                          fontSize: 14
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if(fileName == null)
                       const Padding(
                         padding: EdgeInsets.only(top: 2),
                         child: Text(
                           "Click to open camera",
                           style: TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold),
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
  
  Widget _buildStep(int number, String label, {bool isActive = false, bool isCompleted = false}) {
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
            border: Border.all(color: isActive || isCompleted ? const Color(0xFF1A237E) : Colors.grey.shade400),
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
            fontWeight: isActive || isCompleted ? FontWeight.bold : FontWeight.normal,
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