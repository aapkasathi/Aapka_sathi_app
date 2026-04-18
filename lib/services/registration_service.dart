import 'package:aapka_sarthi/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:aapka_sarthi/controllers/auth_controller.dart';

class RegistrationService {
  final supabase = Supabase.instance.client;

  // Generate Vendor ID and Create User entry first
  Future<Map<String, dynamic>> createInitialUser({
    required String mobile,
    required String stateCode,
    required String districtCode,
  }) async {
    // 1. Call your Postgres Function
    final dynamic rpcResponse =
        await supabase.rpc('generate_vendor_id', params: {
      'p_state_code': stateCode,
      'p_district_code': districtCode,
    });
    String fullVendorId;
    String shortVendorId;
    if (rpcResponse is Map) {
      fullVendorId = rpcResponse['v_full_id'].toString();
      shortVendorId = rpcResponse['v_short_id'].toString();
    } else {
      fullVendorId = rpcResponse[0]['v_full_id'].toString();
      shortVendorId = rpcResponse[0]['v_short_id'].toString();
    }
    // final String generatedId = rpcResponse is List
    //     ? rpcResponse.first.toString()
    //     : rpcResponse.toString();
    // 2. Create entry in public.users table
    final response = await supabase
        .from('users')
        .insert({
          'vendor_id': fullVendorId,
          'vendor_id_short': shortVendorId,
          'mobile': mobile,
          'role': 'vendor'
        })
        .select()
        .single();

    return response; // Isme se 'id' (UUID) milega jo baaki tables me jayega
  }

  Future<Map<String, String>?> getCodesFromNames(
      String stateName, String districtName) async {
    try {
      final data = await supabase
          .from('district_codes')
          .select('state_code, district_code')
          .ilike('state_name', stateName.trim())
          .ilike('district_name', districtName.trim())
          .maybeSingle();
      if (data != null) {
        return {
          'state': data['state_code'] as String,
          'district': data['district_code'] as String,
        };
      }
      return null;
    } catch (e) {
      print('Database error: $e');
      return null;
    }
  }

  Future<void> savePersonal({
    required String userId, // This is the UUID from users table
    required String
        vendorId, // This is the generated vendor ID from the function
    required String name,
    required String fatherName,
    required String address,
    required String phone,
    required String gender,
    required String dob,
    required String aadhar,
    required String state,
    required String district,
    String? email,
    String? photoUrl,
    String? aadharUrl,
  }) async {
    String vendorLoginId = vendorId.length >= 8
        ? vendorId.substring(vendorId.length - 8)
        : vendorId; // Create a vendor login ID using the userId
    print("Attempting to save personal details for userId: $userId");
    String formattedDob;
    try {
      List<String> dateParts = dob.split('/');
      if (dateParts.length == 3) {
        formattedDob =
            "${dateParts[2]}-${dateParts[1].padLeft(2, '0')}-${dateParts[0].padLeft(2, '0')}";
      } else {
        formattedDob = dob;
      }
    } catch (e) {
      formattedDob = dob;
    }
    await supabase.from('personal_details').upsert({
      'user_id': userId,
      'full_name': name,
      'father_name': fatherName,
      'address': address,
      'vendor_id': vendorId,
      'vendor_login_id': vendorLoginId, // Save the generated vendor ID
      'phone': phone,
      'gender': gender,
      'dob': formattedDob, // Ensure DB format is YYYY-MM-DD
      'email': email,
      'aadhar_number': aadhar,
      'state': state,
      'district': district,
      'personal_photo_url': photoUrl,
      'aadhar_photo_url': aadharUrl,
    });
    print("Personal details saved successfully for userId: $userId");
  }

  Future<void> saveBusiness({
    required String userId,
    required String businessName,
    required String businessType,
    required bool hasGovId,
    required String cartLocation,
    required int experienceYears, // Changed to int for DB compatibility
    required String vendingTime,
    required String cartCategory,
    required String businessAddress,
    String? cartPhotoUrl,
  }) async {
    await supabase.from('business_details').upsert({
      'vendor_id': userId,
      'business_name': businessName,
      'business_type': businessType,
      'has_gov_id': hasGovId,
      'cart_location': cartLocation,
      'experience_years': experienceYears,
      'cart_category': cartCategory,
      'business_address': businessAddress,
      'vending_time': vendingTime,
      'cart_photo_url': cartPhotoUrl,
    });
  }

  Future<void> saveBankDetails({
    required String userId,
    required bool hasBankDetails,
    required String accountNumber,
    required String ifscCode,
    required String holderName,
    String? passbookPhotoUrl,
    required bool termsAccepted,
  }) async {
    await supabase.from('bank_details').upsert({
      'vendor_id': userId,
      'has_bank_details': hasBankDetails,
      'account_holder_name': holderName,
      'account_number': accountNumber,
      'ifsc_code': ifscCode,
      'passbook_photo_url': passbookPhotoUrl,
      'terms_accepted': termsAccepted,
    });
  }

  Future<Map<String, dynamic>?> getVendorProfile() async {
    try {
      final String? uuid=  AuthController.loggedInUserId;
      if (uuid == null) return null;
      final personal = await supabase
          .from('personal_details')
          .select()
          .eq('user_id', uuid)
          .maybeSingle();
      final business = await supabase
          .from('business_details')
          .select()
          .eq('vendor_id', uuid)
          .maybeSingle();
      if (personal == null) return null;
      return {
        'name': personal['full_name'],
        'photo': personal['personal_photo_url'],
        'v_id': personal['vendor_id'],
        'mobile': personal['phone'],
        'type': business?['business_type'] ?? "Business Type Not Set",
        'address': personal['address'],
        'cart_name': business != null ? business['business_name'] : null,
        'cart_location': business != null ? business['cart_location'] : null,
        'cart_photo': business != null ? business['cart_photo_url'] : null,
      };
    } catch (e) {
      print('Fetch Eroor: $e');
      return null;
    }
  }
  Future<bool> bookAppointment({
  required DateTime date,
  required String timeSlot,
  required String service,
  required String mode,
  String? otherReason,
}) async {
  try {
    final uuid = AuthController.loggedInUserId;
    if (uuid == null) return false;

    await supabase.from('appointments').insert({
      'user_id': uuid,
      'appointment_date': date.toIso8601String().split('T')[0], // YYYY-MM-DD format
      'time_slot': timeSlot,
      'service': service,
      'mode': mode,
      'other_reason': otherReason,
      'status': 'pending', // Default status
    });
    return true;
  } catch (e) {
    print("Booking Error: $e");
    return false;
  }
}

  Future<bool> submitSupportTicket({
  required String name,
  required String address,
  required String phone,
  required String subject,
  required String message,
}) async {
  try {
    final uuid = AuthController.loggedInUserId; 
   
    // Schema ke columns ke hisab se insert
    await supabase.from('support_tickets').insert({
      'user_id': uuid,
      'name': name,
      'address': address,
      'phone': phone,
      'subject': subject,
      'message': message,
      'status': 'open', // Default status as per schema
    });
    return true;
  } catch (e) {
    print("Support Ticket Error: $e");
    return false;
  }
}
Future<bool> updateVendorProfile({
  required String mobile,
  required String address,
  required String businessName,
  required String cartLocation,
}) async {
  try {
    final uuid = AuthController.loggedInUserId;
    if (uuid == null) return false;

    // 1. personal_details table update karein
    await supabase.from('users').update({
      'mobile':mobile,
    }).eq('id',uuid);
    await supabase.from('personal_details').update({
      'phone': mobile,
      'address': address,
    }).eq('user_id', uuid);

    // 2. business_details table update karein
    await supabase.from('business_details').update({
      'business_name': businessName,
      'cart_location': cartLocation,
    }).eq('vendor_id', uuid);

    return true;
  } catch (e) {
    print("Update Error: $e");
    return false;
  }
}
Future<List<Map<String, dynamic>>> getUploadedDocs(String type) async {
  final userId = AuthController.loggedInUserId;
  final response = await supabase
      .from('documents')
      .select()
      .eq('user_id', userId!)
      .eq('doc_type', type); // 'license' or 'certificate'
  return List<Map<String, dynamic>>.from(response);
}
}
