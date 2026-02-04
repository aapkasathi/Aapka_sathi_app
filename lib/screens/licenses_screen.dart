import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class LicensesScreen extends StatefulWidget {
  const LicensesScreen({super.key});

  @override
  State<LicensesScreen> createState() => _LicensesScreenState();
}

class _LicensesScreenState extends State<LicensesScreen> {
  // List to store the selected files
  final List<PlatformFile> _selectedFiles = [];

  // Function to pick files
  Future<void> _pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result != null) {
        setState(() {
          _selectedFiles.addAll(result.files);
        });
      }
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
            onPressed: () => Navigator.pop(context, true),
          ),
        ),
        title: const Text(
          "Licenses",
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
                      onPressed: _selectedFiles.isEmpty
                          ? null
                          : () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Uploading files...")));
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

          // --- CHANGE 3: "Add More" Button with Bottom SafeArea ---
          // This container will sit at the bottom and respect the device navigation bar
          Container(
            width: double.infinity,
            color: Colors.white, // Background color to cover scrolling content
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: SafeArea(
              top: false, // We don't need top safe area here
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0), // Extra padding from bottom edge
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
          ),
        ],
      ),
    );
  }

  // Helper widget for each file item
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