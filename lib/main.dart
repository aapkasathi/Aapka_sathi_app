import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';
import 'services/language_service.dart';
import 'screens/language_selection_screen.dart';
import 'screens/multilingual_demo_screen.dart';

// Import all the screens created
import 'screens/start/language_screen.dart';
import 'screens/start/login_screen.dart';
import 'screens/register/personal_details.dart';
import 'screens/register/business_details.dart';
import 'screens/register/bank_details.dart';
import 'screens/home/dashboard_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/help_support_screen.dart';
import 'screens/licenses_screen.dart';
import 'screens/certificates_screen.dart';
import 'screens/licenses_info_screen.dart';
import 'screens/policies_screen.dart';
import "screens/disclaimer_screen.dart";
import 'screens/privacy_policy_screen.dart';
import 'screens/terms_conditions_screen.dart';
import 'screens/renewal_form.dart';
import 'screens/appointment_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/request_callback_screen.dart';
import 'screens/splashscreen.dart';
import 'screens/policyscreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Language Service
  final languageService = LanguageService();
  await languageService.init(defaultLanguage: 'en');

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://ncexztproaiixhnnyihv.supabase.co', 
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5jZXh6dHByb2FpaXhobm55aWh2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njk2ODU5MjQsImV4cCI6MjA4NTI2MTkyNH0.HrFxAo5BFyQWKbeGBC3YcrTArqdaBFtK5PIv0KDisT8',
  );

  runApp(const AapkaSathiApp());
}
final supabase = Supabase.instance.client;

class AapkaSathiApp extends StatelessWidget {
  const AapkaSathiApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      title: 'Aapka Sathi',
      debugShowCheckedModeBanner: false,
      theme: appTheme, 
      initialRoute: '/splash',

      routes: {
        '/splash': (context) => const SplashScreen(),
        '/language': (context) => const LanguageSelectScreen(),
        '/login': (context) => const LoginScreen(),
        '/register_personal': (context) => const PersonalDetailsScreen(),
        '/register_business': (context) => const BusinessDetailsScreen(),
        '/register_bank': (context) => const BankDetailsScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/help': (context) => const HelpSupportScreen(),
        '/licenses': (context) => const LicensesScreen(),
        '/certificates': (context) => const CertificatesScreen(),
        '/policies': (context) => const PoliciesScreen(),
        '/licenses_info': (context) => const LicensesInfoScreen(),
        '/disclaimer': (context) => const DisclaimerScreen(),
        '/privacy_policy': (context) => const PrivacyPolicyScreen(),
        '/terms_conditions': (context) => const TermsConditionsScreen(),
        '/renewal_form': (context) => const RenewalForm(),
        '/appointment': (context) => const AppointmentScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/request_callback': (context) => const RequestCallbackScreen(),
        '/policyscreen': (context) => const PolicyScreen(),
    


      },
    );
  }
}
