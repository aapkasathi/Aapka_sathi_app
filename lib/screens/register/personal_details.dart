import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:file_picker/file_picker.dart'; 

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  // Controllers
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _ageController = TextEditingController(); 
  
  // State variables
  String? _selectedGender;
  String? _personalPhotoName;
  String? _aadharPhotoName;

  final List<String> _genderOptions = ["Male", "Female", "Other"];

  // --- LOGIC ---
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1A237E),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
        final age = DateTime.now().year - picked.year;
        _ageController.text = age.toString();
      });
    }
  }

  Future<void> _pickFile(bool isPersonalPhoto) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        if (isPersonalPhoto) {
          _personalPhotoName = result.files.single.name;
        } else {
          _aadharPhotoName = result.files.single.name;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width to make the button responsive
    final screenWidth = MediaQuery.of(context).size.width;

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
            onPressed: () => Navigator.pop(context),
          ),
        ),
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
              "Step 1 of 3",
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
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- STEPPER VISUAL ---
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStep(1, "Personal", isActive: true),
                  _buildStepLine(),
                  _buildStep(2, "Business", isActive: false),
                  _buildStepLine(),
                  _buildStep(3, "Bank", isActive: false),
                ],
              ),
            ),

            const SizedBox(height: 15),
            
            const Text(
              "Personal Details",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
            
            const SizedBox(height: 20),

            // --- FORM FIELDS ---
            _buildLabel("Full Name *"),
            _buildInputField(hint: "Enter your full name"),

            _buildLabel("Father's Name *"),
            _buildInputField(hint: "Enter father's name"),

            _buildLabel("Full Address *"),
            _buildInputField(hint: "Enter complete address", maxLines: 3), 

            _buildLabel("Phone No. *"),
            _buildInputField(hint: "Enter 10-digit number", inputType: TextInputType.phone),

            _buildLabel("Gender *"),
            _buildGenderDropdown(),

            _buildLabel("Date of Birth *"),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer( 
                child: _buildInputField(
                  hint: "DD/MM/YYYY", 
                  controller: _dobController,
                  suffixIcon: Icons.calendar_month,
                ),
              ),
            ),

            _buildLabel("Age *"),
            _buildInputField(hint: "Auto-calculated", controller: _ageController, inputType: TextInputType.number, isReadOnly: true),

            _buildLabel("Email ID"), 
            _buildInputField(hint: "Enter email address", inputType: TextInputType.emailAddress),


            _buildLabel("Aadhar Number *"),
            _buildInputField(hint: "Enter 12-digit Aadhar", inputType: TextInputType.number),

            const SizedBox(height: 25),

            // --- FILE UPLOADS ---
            _buildLabel("Personal Photo *"),
            _buildFileUploadBox(
              fileName: _personalPhotoName,
              onTap: () => _pickFile(true),
              hintText: "Upload Passport Size Photo",
            ),

            const SizedBox(height: 15),

            _buildLabel("Aadhar Photo *"),
            _buildFileUploadBox(
              fileName: _aadharPhotoName,
              onTap: () => _pickFile(false),
              hintText: "Upload Aadhar Card Image",
            ),

            const SizedBox(height: 40),

            // --- NEXT BUTTON ---
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: screenWidth * 0.45 < 180 ? 180 : screenWidth * 0.45, 
                height: 55,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/register_business'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A237E), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5, 
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Save & Next",
                        style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER METHODS ---

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 12.0, left: 5),
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

  Widget _buildInputField({
    required String hint, 
    TextInputType inputType = TextInputType.text,
    TextEditingController? controller,
    IconData? suffixIcon,
    int maxLines = 1,
    bool isReadOnly = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDE7),  
        borderRadius: BorderRadius.circular(30), 
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [], 
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: TextField(
          controller: controller,
          keyboardType: inputType,
          maxLines: maxLines,
          readOnly: isReadOnly,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.orange[300], fontSize: 13),
            border: InputBorder.none, 
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.grey) : null,
          ),
        ),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDE7),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [], 
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedGender,
              hint: Text("Select Gender", style: TextStyle(color: Colors.orange[300], fontSize: 13)),
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              dropdownColor: const Color(0xFFFFFDE7), 
              items: _genderOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedGender = newValue;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFileUploadBox({String? fileName, required VoidCallback onTap, required String hintText}) {
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
                 Icon(Icons.cloud_upload_outlined, color: const Color.fromARGB(255, 172, 170, 170), size: 28),
                 const SizedBox(width: 15),
                 Expanded(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         fileName ?? hintText,
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
                            "Click to browse",
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
  Widget _buildStep(int number, String label, {bool isActive = false}) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? const Color(0xFF1A237E) : Colors.white,
            border: Border.all(color: isActive ? const Color(0xFF1A237E) : Colors.grey.shade400),
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey,
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
            color: isActive ? const Color(0xFF1A237E) : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
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