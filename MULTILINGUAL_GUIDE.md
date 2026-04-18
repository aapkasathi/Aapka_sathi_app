# Multilingual App Implementation Guide

This Flutter app demonstrates a complete multilingual system without using any external translation APIs or libraries. The system supports English and Hindi (हिंदी) with easy scalability for more languages.

## 📁 Project Structure

```
lib/
├── services/
│   └── language_service.dart          # Core language management service
├── screens/
│   ├── language_selection_screen.dart # Initial language selection UI
│   └── multilingual_demo_screen.dart  # Demo screen with language switcher
└── main.dart                          # Updated with language initialization

assets/
└── strings/
    └── strings.json                   # All translations stored here
```

## 🌍 Supported Languages

- **English** (`en`)
- **Hindi** (`hi`) - with full Unicode support

## 📋 How It Works

### 1. **Language Strings File** (`assets/strings/strings.json`)

All UI text is stored in a JSON file with a simple structure:

```json
{
  "en": {
    "welcome": "Welcome",
    "login": "Login",
    "logout": "Logout"
  },
  "hi": {
    "welcome": "स्वागत है",
    "login": "लॉगिन",
    "logout": "लॉगआउट"
  }
}
```

**Key Benefits:**
- No API calls needed
- Easy to edit and maintain
- Unicode support for Hindi and other languages
- Human-readable format

### 2. **LanguageService** (`lib/services/language_service.dart`)

A singleton service that manages all language operations:

```dart
// Initialize on app startup
final languageService = LanguageService();
await languageService.init(defaultLanguage: 'en');

// Get translated text
String welcomeText = languageService.getText('welcome');

// Switch language at runtime
languageService.setLanguage('hi');

// Get current language
String currentLang = languageService.getCurrentLanguage();

// Get all supported languages
List<String> languages = languageService.getSupportedLanguages();
```

**Key Features:**
- Singleton pattern for app-wide access
- Automatic fallback to English if translation missing
- Lazy loading of JSON strings
- Error handling for missing keys

### 3. **Language Selection Screen** (`language_selection_screen.dart`)

Beautiful UI for users to select their preferred language on app startup.

**Features:**
- Radio button selection
- Language names display in their native scripts
- Smooth transitions
- Material Design

### 4. **Multilingual Demo Screen** (`multilingual_demo_screen.dart`)

Demonstrates the system in action with:
- Current language display
- Real-time language switching
- Sample translated strings
- How-it-works explanation

## 🚀 Usage Guide

### Basic Setup (Already Done)

1. **Initialize in main.dart:**
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final languageService = LanguageService();
  await languageService.init(defaultLanguage: 'en');
  
  runApp(const AapkaSathiApp());
}
```

2. **Add assets to pubspec.yaml:**
```yaml
flutter:
  assets:
    - assets/strings/strings.json
```

### Using in Your Screens

**Simple example:**
```dart
import 'package:aapka_sathi_app/services/language_service.dart';

class MyScreen extends StatelessWidget {
  final languageService = LanguageService();

  @override
  Widget build(BuildContext context) {
    return Text(
      languageService.getText('welcome'),
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
```

**With State Management for language switching:**
```dart
class MyScreen extends StatefulWidget {
  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  final languageService = LanguageService();

  void _changeLanguage(String langCode) {
    setState(() {
      languageService.setLanguage(langCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(languageService.getText('welcome')),
        ElevatedButton(
          onPressed: () => _changeLanguage('hi'),
          child: Text('Switch to Hindi'),
        ),
      ],
    );
  }
}
```

## 🔤 Hindi Unicode Support

The implementation uses standard Unicode encoding for Hindi text. No special configuration needed!

**Supported Hindi scripts:**
- Devanagari script (देवनागरी)
- Full Unicode range U+0900 to U+097F

**Example strings in strings.json:**
```json
"hi": {
  "welcome": "स्वागत है",
  "hello": "नमस्ते",
  "goodbye": "अलविदा"
}
```

## ➕ Adding a New Language

**Step 1:** Add strings to `assets/strings/strings.json`
```json
{
  "en": { ... },
  "hi": { ... },
  "fr": {
    "welcome": "Bienvenue",
    "login": "Connexion",
    "logout": "Déconnexion"
  }
}
```

**Step 2:** Update `LanguageService` constants
```dart
static const List<String> supportedLanguages = ['en', 'hi', 'fr'];
static const Map<String, String> languageNames = {
  'en': 'English',
  'hi': 'हिंदी (Hindi)',
  'fr': 'Français',
};
```

**Step 3:** Use it immediately - no other changes needed!

## 🛠️ API Reference

### LanguageService Methods

| Method | Description | Example |
|--------|-------------|---------|
| `init()` | Initialize with default language | `await languageService.init('en')` |
| `getText(key)` | Get translated string | `languageService.getText('welcome')` |
| `setLanguage(code)` | Change current language | `languageService.setLanguage('hi')` |
| `getCurrentLanguage()` | Get current language code | `languageService.getCurrentLanguage()` |
| `getSupportedLanguages()` | Get list of supported languages | `languageService.getSupportedLanguages()` |
| `getLanguageName(code)` | Get display name of language | `languageService.getLanguageName('en')` |
| `getAllStrings()` | Get all strings for current language | `languageService.getAllStrings()` |

## 🎨 Advanced Usage

### Combining with Other Variables

```dart
String userName = "John";
String greeting = languageService.getText('hello') + ", " + userName;
```

### Fallback Messages

The system automatically falls back to English if:
1. A key doesn't exist in the current language
2. The current language file is corrupted or missing

```dart
// If 'my_custom_key' doesn't exist in strings.json
languageService.getText('my_custom_key');
// Returns: 'my_custom_key' (the key itself as fallback)
```

### Error Handling

All methods include built-in error handling:
```dart
try {
  await languageService.init();
} catch (e) {
  print('Error initializing language: $e');
  // App continues with default English
}
```

## 🎯 Key Advantages

✅ **No External APIs** - Everything is local  
✅ **Zero Dependencies** - Uses only Flutter built-ins  
✅ **Fast Loading** - JSON is loaded once on startup  
✅ **Unicode Support** - Handles any language/script  
✅ **Easy to Scale** - Add languages by editing JSON  
✅ **Memory Efficient** - Singleton pattern  
✅ **Type Safe** - Dart static typing  
✅ **Fallback System** - Graceful error handling  

## 📱 Running the Demo

1. **Build and run:**
```bash
flutter pub get
flutter run
```

2. **On startup:**
   - Language selection screen appears
   - Select English or Hindi
   - Tap "Continue"

3. **Demo features:**
   - See current language displayed
   - Switch language with buttons
   - View sample translated strings
   - Press "Select Language" to go back

## 🧪 Testing

### Test Language Switching
```dart
void testLanguageSwitching() {
  final ls = LanguageService();
  ls.setLanguage('en');
  assert(ls.getText('welcome') == 'Welcome');
  
  ls.setLanguage('hi');
  assert(ls.getText('welcome') == 'स्वागत है');
}
```

### Test Fallback
```dart
void testFallback() {
  final ls = LanguageService();
  ls.setLanguage('hi');
  // If key doesn't exist in Hindi, should return key name
  String result = ls.getText('nonexistent_key');
  assert(result == 'nonexistent_key');
}
```

## 🔐 Best Practices

1. **Always call `init()` before using:**
```dart
await languageService.init();
```

2. **Store language preference** (optional):
```dart
// You can add SharedPreferences to persist user choice
```

3. **Use getText() in build methods:**
```dart
@override
Widget build(BuildContext context) {
  return Text(languageService.getText('welcome'));
}
```

4. **Trigger setState() for runtime switching:**
```dart
void _switchLanguage(String code) {
  setState(() {
    languageService.setLanguage(code);
  });
}
```

5. **Keep strings.json organized:**
   - Group related strings
   - Use clear, descriptive keys
   - Keep both languages in sync

## 🐛 Troubleshooting

**Issue:** Hindi text shows as boxes
- **Solution:** Ensure `strings.json` is saved as UTF-8

**Issue:** getText() returns the key name
- **Solution:** Check that the key exists in your language's strings.json

**Issue:** App crashes on initialization
- **Solution:** Verify `assets/strings/strings.json` path in `pubspec.yaml`

**Issue:** Language doesn't switch
- **Solution:** Call `setState()` after `setLanguage()` in StatefulWidget

## 📚 Additional Resources

- Flutter Internationalization: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
- JSON in Flutter: https://flutter.dev/docs/development/data-and-backend/json
- Unicode Standard: https://unicode.org/

---

**Created:** April 2026  
**Version:** 1.0.0  
**License:** MIT
