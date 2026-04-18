# 🚀 Getting Started - 5 Minute Quick Start

**Time to first success:** 5 minutes  
**Difficulty:** Beginner-friendly  
**Requirements:** Flutter SDK installed

---

## ⚡ Step 1: Run the App (2 minutes)

```bash
# Navigate to your project
cd /home/kaptaan/Videos/Apkasarthi/Aapka_sathi_app

# Get dependencies
flutter pub get

# Run the app
flutter run
```

**What happens:**
- App starts with language selection screen
- You see "English" and "हिंदी (Hindi)" options
- Select a language and tap "Continue"

---

## 🌍 Step 2: Test Language Switching (1 minute)

On the demo screen:

1. See current language displayed
2. Press "English" button → See text change to English
3. Press "हिंदी" button → See text change to Hindi
4. Observe sample translated strings below

**Success!** Language switching works! ✅

---

## 💻 Step 3: Use in Your Code (2 minutes)

### Option A: Simple Text (Easiest)

```dart
import 'package:aapka_sathi_app/services/language_service.dart';

class MyScreen extends StatelessWidget {
  final ls = LanguageService();

  @override
  Widget build(BuildContext context) {
    return Text(
      ls.getText('welcome'),
      // Shows "Welcome" in English
      // Shows "स्वागत है" in Hindi
    );
  }
}
```

### Option B: With Language Switcher

```dart
class MyScreen extends StatefulWidget {
  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  final ls = LanguageService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(ls.getText('welcome')),
        
        ElevatedButton(
          onPressed: () {
            setState(() {
              ls.setLanguage('hi');  // Switch to Hindi
            });
          },
          child: Text('Switch to Hindi'),
        ),
      ],
    );
  }
}
```

---

## 📝 Step 4: Add Your Own Strings (Optional)

Edit `assets/strings/strings.json`:

```json
{
  "en": {
    "my_greeting": "Hello there!"
  },
  "hi": {
    "my_greeting": "नमस्ते!"
  }
}
```

Use it:
```dart
Text(ls.getText('my_greeting'))
```

---

## 🎉 You're Done!

Your multilingual app is ready. Now:

1. **Explore:** Review the demo screens
2. **Learn:** Read [MULTILINGUAL_GUIDE.md](MULTILINGUAL_GUIDE.md)
3. **Build:** Add getText() to your screens
4. **Expand:** Add more strings to JSON

---

## 📚 What's Available

| Item | Location | Use For |
|------|----------|---------|
| **Service** | `lib/services/language_service.dart` | Core language logic |
| **Strings** | `assets/strings/strings.json` | All translations |
| **Demo Screen** | `lib/screens/multilingual_demo_screen.dart` | See it in action |
| **Language Picker** | `lib/screens/language_selection_screen.dart` | User selects language |

---

## 💡 API Cheat Sheet

```dart
// Get translated text
ls.getText('key_name')

// Change language
ls.setLanguage('hi')      // Hindi
ls.setLanguage('en')      // English

// Get current language
ls.getCurrentLanguage()    // Returns 'en' or 'hi'

// List all languages
ls.getSupportedLanguages() // Returns ['en', 'hi']

// Get language name
ls.getLanguageName('en')   // Returns 'English'
ls.getLanguageName('hi')   // Returns 'हिंदी (Hindi)'
```

---

## ✅ Common Strings Already Available

You can use these right now:

```
welcome      -  स्वागत है
login        -  लॉगिन
logout       -  लॉगआउट
hello        -  नमस्ते
goodbye      -  अलविदा
home         -  घर
settings     -  सेटिंग्स
help         -  मदद
about        -  परिचय
language     -  भाषा
```

---

## 🐛 Quick Troubleshooting

**Q: App shows language selection every time I run it**  
A: That's normal! The demo is set to show the language picker. Update main.dart if you want to skip it.

**Q: getText() returns the key name instead of text**  
A: The key doesn't exist in strings.json. Add it in both English and Hindi.

**Q: Hindi shows as boxes or weird characters**  
A: Make sure strings.json is saved as UTF-8 encoding.

**Q: Language doesn't change when I call setLanguage()**  
A: In StatefulWidget, wrap it in setState(): `setState(() => ls.setLanguage('hi'))`

---

## 🎯 Next Steps

### Immediate (Today)
- ✅ Run the app
- ✅ Test language switching
- ✅ Review the demo

### Short Term (This Week)
- [ ] Read [MULTILINGUAL_QUICK_START.md](MULTILINGUAL_QUICK_START.md)
- [ ] Update strings.json with your app's text
- [ ] Add getText() to your screens

### Medium Term (This Month)
- [ ] Read [MULTILINGUAL_GUIDE.md](MULTILINGUAL_GUIDE.md)
- [ ] Complete integration
- [ ] Add more languages if needed

---

## 📞 Need Help?

### Reference Docs
- **Quick answers:** [MULTILINGUAL_QUICK_START.md](MULTILINGUAL_QUICK_START.md)
- **Complete guide:** [MULTILINGUAL_GUIDE.md](MULTILINGUAL_GUIDE.md)
- **Code examples:** [MULTILINGUAL_EXAMPLES.dart](MULTILINGUAL_EXAMPLES.dart)
- **Architecture:** [ARCHITECTURE_OVERVIEW.md](ARCHITECTURE_OVERVIEW.md)
- **All files:** [DOCUMENTATION_INDEX.md](DOCUMENTATION_INDEX.md)

### Common Tasks

**Add a new language:**
- Section 2.2 of [MULTILINGUAL_QUICK_START.md](MULTILINGUAL_QUICK_START.md)

**Create language-switching UI:**
- Example 2, 7 in [MULTILINGUAL_EXAMPLES.dart](MULTILINGUAL_EXAMPLES.dart)

**Handle language in forms:**
- Example 3 in [MULTILINGUAL_EXAMPLES.dart](MULTILINGUAL_EXAMPLES.dart)

**Show translated lists:**
- Example 4 in [MULTILINGUAL_EXAMPLES.dart](MULTILINGUAL_EXAMPLES.dart)

---

## 🌟 That's It!

You now have a fully functional multilingual Flutter app with:

✅ English & Hindi support  
✅ Language switching  
✅ Clean, maintainable code  
✅ Full Unicode support  
✅ No external APIs  

**Happy coding!** 🚀

---

*Created: April 18, 2026*  
*Version: 1.0.0*
