import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController {
  static String? loggedInUserId;
  Future<bool> loginWithVendorId(String vendorId, String mobile) async {
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase
          .from('users')
          .select('id')
          .eq('vendor_id_short', vendorId)
          .eq('mobile', mobile)
          .maybeSingle();

      if (response != null) {
        loggedInUserId = response['id'];
        return true;
      }
      return false;
    } catch (e) {
      print("Login Error: $e");
      return false;
    }
  }
}