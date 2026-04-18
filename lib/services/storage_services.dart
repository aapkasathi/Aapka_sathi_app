// upload file to supabase storage and return the public url
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:aapka_sarthi/controllers/auth_controller.dart';

class StorageService {
  final supabase = Supabase.instance.client;
  Future<String?> uploadFile({
    required File file,
    required String userId,
    required String folder,
  }) async {
    try {
      final fileName = path.basename(file.path);
      final String uniqueFileName = "${DateTime.now().millisecondsSinceEpoch}_$fileName";
      final filePath = '$userId/$folder/$uniqueFileName';
      await supabase.storage.from('vendor-files').upload(filePath, file, fileOptions: const FileOptions(cacheControl: '3600', upsert: false));
      final publicUrl = supabase.storage.from('vendor-files').getPublicUrl(filePath);
      return publicUrl;
    } catch (e) {
      throw Exception('File upload failed: $e');
    }
  }

  Future<void> saveDocument({
    required String userId,
    required String url,
    required String fileName,
    required String docType,
    required int fileSize,
    String? fileType,
  }) async {
    await supabase.from('documents').insert({
      'user_id': userId,
      'doc_type': docType,
      'file_name': fileName,
      'file_url': url,
      'file_size': fileSize,
      'file_type': fileType,
    });
  }
  Future<void> uploadAndSaveDoc({
  required File file,
  required String fileName,
  required String docType, // 'license' or 'certificate'
  required int fileSize,
  String? fileExtension,
}) async {
  final userId = AuthController.loggedInUserId; // Humara custom login ID
  if (userId == null) return;

  // 1. Storage mein upload karein
  final String? url = await uploadFile(
    file: file,
    userId: userId,
    folder: docType == 'license' ? 'licenses' : 'certificates',
  );

  if (url != null) {
    // 2. Database table 'documents' mein entry karein
    await supabase.from('documents').insert({
      'user_id': userId,
      'doc_type': docType,
      'file_name': fileName,
      'file_url': url,
      'file_size': fileSize,
      'file_type': fileExtension,
    });
  }
}
}
