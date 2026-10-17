 Aapka Sarthi — Service Platform 
 Aapka Sarthi is a robust, cross-platform mobile application built with Flutter. Designed for empowering street vendors by giving them seamless user service management, document processing, and real-time backend communication, it empowers users with features like dynamic PDF generation, document uploading, localized formatting, and secure cloud storage.
 🚀 Key Features🔐
 Authentication & Backend: Real-time database sync and secure authentication powered by Supabase.
 📄 Document & Media Handling: Support for selecting and managing files and images (file_picker, image_picker).
 🖨️ Dynamic PDF Generation & Printing: Built-in PDF rendering and printing support (pdf, printing).
 💾 Local Data Persistence: Caching settings, tokens, and preferences locally with shared_preferences.
 🌐 Localization & Formatting: Native date and currency handling (intl).
 🔗 External Links: Smooth navigation to external web links and services (url_launcher).
 🛠️ Tech Stack & DependenciesCategoryTechnologyFrameworkFlutter (Dart SDK >= 3.0.0 < 4.0.0)BackendSupabase FlutterDocument Processingpdf, printing, path_providerFile Pickerfile_picker, image_pickerUtilitiesshared_preferences, intl, url_launcher, cupertino_icons.
 📋 PrerequisitesBefore running this project,
 ensure you have the following installed:Flutter SDK: >= 3.38.4Dart SDK: >= 3.10.3IDE: Android Studio or VS Code with Flutter extensionSupabase Project: An active Supabase database and URL/Anon key
 
 ⚡ Getting Started & Setup
 1. Clone the Repositorygit clone https://github.com/Sanya6004/aapka_sarthi.git
    cd aapka_sarthi
 2. Install Dependenciesflutter pub get
 3. Environment Configuration (Supabase Setup)Ensure your Supabase URL and Anon Key are initialized in your lib/main.dart or     configuration file:await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL',
    anonKey: 'YOUR_SUPABASE_ANON_KEY',
    );
Note: Never commit production API keys to public repositories.
4. App Icon Generator (Optional)If you update the app icons in assets/images/app_icon.png, regenerate them using:dart run flutter_launcher_icons
5. Run the Applicationflutter run
📦 Building the APK for TestingTo build the app for Android testing or distribution:Debug Build (Fast build, debugging tools enabled):flutter build apk --debug
Release Build (Optimized performance & small file size):flutter build apk --release
Split per ABI (Generates smaller, architecture-specific APKs):flutter build apk --split-per-abi
The built APK file will be available at:build/app/outputs/flutter-apk/app-release.apk📁 Project Architectureaapka_sarthi/
├── android/               # Android configuration files
├── ios/                   # iOS configuration files
├── assets/
│   └── images/            # Graphic assets & app icons
├── lib/
│   ├── main.dart          # Entry point & Supabase initialization
│   ├── screens/           # UI Views
│   ├── services/          # Storage, PDF & Supabase logic
│   └── widgets/           # Reusable UI Components
├── pubspec.yaml           # Project dependencies & configurations
└── README.md              # Project documentation
🧑‍💻 AuthorCreated and maintained by Sanya Singh:🌐 GitHub: @Sanya6004📄 LicenseThis project is private and proprietary. All rights reserved by Aapka Sarthi.
