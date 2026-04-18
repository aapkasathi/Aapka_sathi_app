import 'dart:io';
// import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:aapka_sarthi/main.dart';
import 'package:aapka_sarthi/services/registration_service.dart';
// import 'package:aapka_sarthi/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  // Controllers by soumya
  final _dobController = TextEditingController();
  final _ageController = TextEditingController();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _fatherController = TextEditingController();
  final _addressController = TextEditingController();
  final _aadharController = TextEditingController();
  final _stateController = TextEditingController();
  final _districtController = TextEditingController();
  final _emailController = TextEditingController();

  // State variables
  String? _selectedGender;
  String? _personalPhotoName;
  String? _aadharPhotoName;
  File? _personalPhotoFile;
  File? _aadharPhotoFile;

  final List<String> _genderOptions = ["Male", "Female", "Other"];
  @override
  void initState() {
    super.initState();
    _loadDraft();
  }

//  Draft Logic
  Future<void> _saveDraft() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('p_name', _nameController.text);
    await prefs.setString('p_moblie', _mobileController.text);
    await prefs.setString('p_aadhar', _aadharController.text);
    await prefs.setString('p_father', _fatherController.text);
    await prefs.setString('p_address', _addressController.text);
    await prefs.setString('p_state', _stateController.text);
    await prefs.setString('p_district', _districtController.text);
  }

  Future<void> _loadDraft() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('p_name') ?? "";
      _mobileController.text = prefs.getString('p_mobile') ?? "";
      _aadharController.text = prefs.getString('p_aadhar') ?? "";
      _fatherController.text = prefs.getString('p_father') ?? "";
      _addressController.text = prefs.getString('p_address') ?? "";
      _stateController.text = prefs.getString('p_state') ?? "";
      _districtController.text = prefs.getString('p_district') ?? "";
    });
  }

  // error handling logic
  // Form(
  //   key: _formKey,
  //   child: Column(children: [
  //     TextFormField(
  //       controller: _nameController,
  //       decoration : InputDecoration(LabelText: "Full Name*"),
  //       validator: (value){
  //         if(value == null || value.isEmpty) return "Name Required";
  //         return null;
  //       },
  //     ),
  //     const SizedBox(height : 15),

  //     // Phone Field
  //     TextFormField(
  //       controller: _mobileController,
  //       keyboardType: TextInputType.phone,
  //       decoration: InputDecoration(labelText: "Mobile Number Required"),
  //       validator: (value){
  //         if(value == null || value.length !=10) return "Enter valid Mobile Number";
  //         return null;
  //       },
  //     ),
  //     const SizedBox(height: 15),
  //     TextFormField(
  //       controller: _aadharController,
  //       keyboardType: TextInputType.number,
  //       decoration: InputDecoration(labelText: "Aadhar Number *"),
  //       validator: (value) {
  //         if(value == null|| value.length !=12) return "Enter Valid Aadhar Number";
  //         return null;
  //       },
  //     ),
  //   ],),)
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

    if (result != null && result.files.single.path != null) {
      setState(() {
        if (isPersonalPhoto) {
          _personalPhotoFile = File(result.files.single.path!);
          _personalPhotoName = result.files.single.name;
        } else {
          _aadharPhotoFile = File(result.files.single.path!);
          _aadharPhotoName = result.files.single.name;
        }
      });
    }
  }

  @override
  // Widget _buildValidationField(
  //   TextEditingController controller,
  //   String label,
  //   String errorMsg){
  //     return TextFormField(
  //       controller: controller,
  //       decoration: InputDecoration(
  //         labelText: label,
  //         filled: true,
  //         fillColor: const Color(0xFFFFFDE7),
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(30),
  //         ),
  //       ),
  //       // validation logic
  //       validator: (value){
  //         if(value == null || value.trim().isEmpty){
  //           return errorMsg;
  //         }
  //         return null;
  //       },
  //     );
  //   }

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
            icon:
                const Icon(Icons.arrow_back_ios, color: Colors.black, size: 28),
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
          child: Form(
            key: _formKey,
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
                // _buildLabel("Full Name *"),
                // _buildInputField(
                //     hint: "Enter your full name", controller: _nameController),

                // _buildLabel("Father's Name *"),
                // _buildInputField(
                //     hint: "Enter father's name", controller: _fatherController),

                // _buildLabel("District*"),
                // _buildInputField(
                //     hint: "Enter District Name", controller: _districtController),

                // _buildLabel("State *"),
                // _buildInputField(
                //     hint: "Enter State Name", controller: _stateController),

                // _buildLabel("Full Address *"),
                // _buildInputField(
                //     hint: "Enter complete address",
                //     maxLines: 3,
                //     controller: _addressController),

                // _buildLabel("Phone No. *"),
                // _buildInputField(
                //     hint: "Enter 10-digit number",
                //     inputType: TextInputType.phone,
                //     controller: _mobileController),
                _buildValidatedInputField(
                    hint: "Full Name*",
                    controller: _nameController,
                    errorMsg: "Name is required"),
                _buildValidatedInputField(
                    hint: "Father's Name *",
                    controller: _fatherController,
                    errorMsg: "Father's Name is required"),
                _buildValidatedInputField(
                    hint: "District *",
                    controller: _districtController,
                    errorMsg: "District is required"),
                _buildValidatedInputField(
                    hint: "State *",
                    controller: _stateController,
                    errorMsg: "State is required"),
                _buildValidatedInputField(
                    hint: "Full Address *",
                    controller: _addressController,
                    errorMsg: "Address is required"),
                _buildValidatedInputField(
                    hint: "Phone No. *",
                    controller: _mobileController,
                    errorMsg: "Mobile number is required"),
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
                _buildInputField(
                    hint: "Auto-calculated",
                    controller: _ageController,
                    inputType: TextInputType.number,
                    isReadOnly: true),
                _buildValidatedInputField(
                    hint: "Email (Optional)",
                    controller: _emailController,
                    inputType: TextInputType.emailAddress,
                    errorMsg: ""),
                    
                _buildValidatedInputField(
                    hint: "Aadhar Number",
                    controller: _aadharController,
                    inputType: TextInputType.number,
                    expectedLength: 12,
                    errorMsg: "Aadhar number is required"),

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
                      onPressed:
                          // =>Navigator.pushNamed(context, '/register_business'), by soumya
                          () async {
                        if (_formKey.currentState!.validate()) {
                          if (_personalPhotoFile == null ||
                              _aadharPhotoFile == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Upload the photos.")));
                            return;}
                            final regService = RegistrationService();
                            final codes = await regService.getCodesFromNames(
                                _stateController.text,
                                _districtController.text);
                            if (codes == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Invalid State or District name. Please correct them.")));
                              return;
                            
                          }
                          await _saveDraft();
                          final step1Data = {
                            'name': _nameController.text.trim(),
                            'mobile': _mobileController.text.trim(),
                            'aadhar': _aadharController.text.trim(),
                            'father': _fatherController.text.trim(),
                            'address': _addressController.text.trim(),
                            'state': _stateController.text.trim(),
                            'district': _districtController.text.trim(),
                            'gender': _selectedGender,
                            'dob': _dobController.text,
                            'email': _emailController.text.trim(),
                            'district_code': codes['district'],
                            'state_code': codes['state'],
                            'photoPath': _personalPhotoFile!.path,
                            'aadharPath': _aadharPhotoFile!.path,
                          };
                          Navigator.pushNamed(context, '/register_business',
                              arguments: {'personal': step1Data});
                          // try {
                          //   final existingUser = await supabase
                          //       .from('users')
                          //       .select()
                          //       .eq('mobile', _mobileController.text.trim())
                          //       .maybeSingle();
                          //   if (existingUser != null) {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //         const SnackBar(
                          //             content: Text(
                          //                 "Mobile is alreay registered!")));
                          //     return;
                          //   }
                          // } catch (e) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(content: Text("Error : $e")));
                          // }
                        }
                        // else {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(
                        //           content:
                        //               Text("Please fill all fields properly")));
                        // }
                        // Validation: Check karein mandatory fields khali na hon
                        // if (_nameController.text.isEmpty ||
                        //     _mobileController.text.isEmpty) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //         content: Text("Please fill mandatory fields")),
                        //   );
                        //   return;
                        // }

                        // try {
                        //   if (_stateController.text.isEmpty ||
                        //       _districtController.text.isEmpty) {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(
                        //           content: Text(
                        //               "Please fill State and District fields")),
                        //     );
                        //     return;
                        //   }
                        //   // Loading dikhane ke liye aap ek Dialog ya Spinner add kar sakte hain
                        //   final regService = RegistrationService();
                        //   final codes = await regService.getCodesFromNames(
                        //       _stateController.text, _districtController.text);
                        //   if (codes == null) {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(
                        //           content: Text(
                        //               "Invalid State or District name. Please correct them.")),
                        //     );
                        //     return;
                        //   }
                        //   final userData = await regService.createInitialUser(
                        //     mobile: _mobileController.text,
                        //     stateCode: codes['state']!,
                        //     districtCode: codes['district']!,
                        //   );
                        //   final storageService = StorageService();

                        //   // 1. Create User in 'users' table & Get UUID
                        //   final String userUuid = userData[
                        //       'id']; // Ye UUID hai jo baaki tables me link hogi

                        //   // 2. Upload Personal Photo
                        //   String? personalUrl;
                        //   if (_personalPhotoFile != null) {
                        //     personalUrl = await storageService.uploadFile(
                        //         file: _personalPhotoFile!,
                        //         userId: userUuid,
                        //         folder: 'personal_photos');
                        //   }

                        //   // 2a. Upload Aadhar Photo
                        //   String? aadharUrl;
                        //   if (_aadharPhotoFile != null) {
                        //     aadharUrl = await storageService.uploadFile(
                        //         file: _aadharPhotoFile!,
                        //         userId: userUuid,
                        //         folder: 'aadhar_photos');
                        //   }

                        //   // 3. Save Personal Details to DB
                        //   await regService.savePersonal(
                        //     userId: userUuid,
                        //     name: _nameController.text,
                        //     fatherName: _fatherController.text,
                        //     address: _addressController.text,
                        //     phone: _mobileController.text,
                        //     gender: _selectedGender ?? "Other",
                        //     dob: _dobController
                        //         .text, // Format: YYYY-MM-DD hona chahiye
                        //     aadhar: _aadharController.text,
                        //     email: _emailController.text.trim().isEmpty
                        //         ? null
                        //         : _emailController.text.trim(),
                        //     state: _stateController.text,
                        //     district: _districtController.text,
                        //     photoUrl: personalUrl,
                        //     aadharUrl: aadharUrl,
                        //   );
                        //   Navigator.pushNamed(context, '/register_business',
                        //       arguments:
                        //           userUuid); // Next screen pe UUID pass karna na bhoolen
                        // } catch (e) {
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //       content:
                        //           Text("Error saving personal details: $e")));
                        // }
                      },
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
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward,
                              color: Colors.white, size: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          )),
    );
  }

  // --- WIDGET HELPER METHODS ---
  Widget _buildValidatedInputField({
    required String hint,
    required TextEditingController controller,
    required String errorMsg,
    TextInputType inputType = TextInputType.text,
    int maxLines = 1,
    bool isReadOnly = false,
    IconData? suffixIcon,
    int? expectedLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(hint),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDE7),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: TextFormField(
              controller: controller,
              keyboardType: inputType,
              maxLines: maxLines,
              readOnly: isReadOnly,
              textAlign: TextAlign.start,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: hint.replaceAll('*', '').trim(),
                hintStyle: TextStyle(color: Colors.orange[300], fontSize: 13),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                suffixIcon: suffixIcon != null
                    ? Icon(suffixIcon, color: Colors.grey)
                    : null,
                errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) return errorMsg;
                if (expectedLength != null &&
                    value.trim().length != expectedLength) {
                  return "$expectedLength digits required";
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

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
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, color: Colors.grey)
                : null,
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
              hint: Text("Select Gender",
                  style: TextStyle(color: Colors.orange[300], fontSize: 13)),
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

  Widget _buildFileUploadBox(
      {String? fileName,
      required VoidCallback onTap,
      required String hintText}) {
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
                Icon(Icons.cloud_upload_outlined,
                    color: const Color.fromARGB(255, 172, 170, 170), size: 28),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileName ?? hintText,
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
  Widget _buildStep(int number, String label, {bool isActive = false}) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? const Color(0xFF1A237E) : Colors.white,
            border: Border.all(
                color:
                    isActive ? const Color(0xFF1A237E) : Colors.grey.shade400),
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
