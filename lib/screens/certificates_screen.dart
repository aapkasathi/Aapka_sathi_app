import 'dart:io';
import 'package:aapka_sarthi/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:aapka_sarthi/services/registration_service.dart';

class CertificatesScreen extends StatefulWidget {
  const CertificatesScreen({super.key});

  @override
  State<CertificatesScreen> createState() => _CertificatesScreenState();
}

class _CertificatesScreenState extends State<CertificatesScreen> {
  // List to store the selected files
  final List<PlatformFile> _selectedFiles = [];
  bool _isLoading = false; 
  List<Map<String, dynamic>> _uploadedDocs = [];

@override
void initState() {
  super.initState();
  _fetchDocs();
}

Future<void> _fetchDocs() async {
  final docs = await RegistrationService().getUploadedDocs("certificate"); 
  setState(() => _uploadedDocs = docs);
}
  // Function to pick files from the gallery
  Future<void> _pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result != null) { for (var file in result.files) {  if (file.size > 10485760) { ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("${file.name} is too large! Max 10MB allowed.")), ); } else { setState(() => _selectedFiles.add(file)); } } }  
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking file: $e')),
      );
    }
  }

  // Function to remove a selected file
  void _removeFile(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 28),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context, true);
              }
            },
          ),
        ),
        title: const Text(
          "Certificates",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
     body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // --- 1. LARGE UPLOAD AREA ---
                  GestureDetector(
                    onTap: _pickFiles,
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cloud_upload_outlined,
                              size: 60, color: Colors.grey[600]),
                          const SizedBox(height: 15),
                          const Text(
                            "Drop your files here or browse",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Max file size up to 10 MB",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // --- 2. UPLOAD BUTTON (Dark Grey) ---
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      // onPressed: _selectedFiles.isEmpty
                      //     ? null
                      //     : () {
                      //         ScaffoldMessenger.of(context).showSnackBar(
                      //             const SnackBar(
                      //                 content: Text("Uploading certificates...")));
                      //       },
                      onPressed: _selectedFiles.isEmpty ? null : () async {
  setState(() => _isLoading = true);
  try {
    final service = StorageService();
    for (var file in _selectedFiles) {
      // Size Validation (10MB limit)
      if (file.size <= 10485760) {
        await service.uploadAndSaveDoc(
          file: File(file.path!),
          fileName: file.name,
          docType: "certificate", // 👈 Certificates wali file mein yahan "certificate" likhein
          fileSize: file.size,
          fileExtension: file.extension,
        );
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Upload Successful!")));
    setState(() => _selectedFiles.clear()); // List khali karein
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
  } finally {
    setState(() => _isLoading = false);
  }
},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF616161),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "UPLOAD",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // --- 3. LIST OF SELECTED FILES ---
                  ..._selectedFiles.asMap().entries.map((entry) {
                    int index = entry.key;
                    PlatformFile file = entry.value;
                    String extension =
                        file.extension?.toUpperCase() ?? 'FILE';
                    String fileSize =
                        "${(file.size / 1024 / 1024).toStringAsFixed(2)}mb";

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: _buildFileItem(extension, file.name, fileSize,
                          () => _removeFile(index)),
                    );
                  }),
                ],
              ),
            ),
          ),

          // --- 4. ADD MORE BUTTON (Black) ---
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _pickFiles,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Add More",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for each file item in the list
  
  Widget _buildFileItem(
      String type, String name, String size, VoidCallback onDelete) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // File Type Icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                type,
                style: TextStyle(
                    color: Colors.grey[700], fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 15),
          // File Name and Size
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  size,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
          // Delete Button
          IconButton(
            icon: const Icon(Icons.close, color: Colors.grey),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}