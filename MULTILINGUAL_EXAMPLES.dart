// Example: How to Use the Multilingual System in Different Scenarios

import 'package:flutter/material.dart';
import 'package:aapka_sathi_app/services/language_service.dart';

// ============================================================================
// EXAMPLE 1: Simple StatelessWidget with Translated Text
// ============================================================================

class Example1_SimpleText extends StatelessWidget {
  final ls = LanguageService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ls.getText('app_title')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ls.getText('welcome'),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              ls.getText('hello'),
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// EXAMPLE 2: StatefulWidget with Language Switching
// ============================================================================

class Example2_LanguageSwitcher extends StatefulWidget {
  @override
  State<Example2_LanguageSwitcher> createState() => _Example2State();
}

class _Example2State extends State<Example2_LanguageSwitcher> {
  final ls = LanguageService();

  void _switchLanguage(String langCode) {
    setState(() {
      ls.setLanguage(langCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ls.getText('app_title')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ls.getText('current_language'),
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              ls.getLanguageName(ls.getCurrentLanguage()),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _switchLanguage('en'),
                  child: Text('English'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => _switchLanguage('hi'),
                  child: Text('हिंदी'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// EXAMPLE 3: Complete Form with Multiple Languages
// ============================================================================

class Example3_MultilingualForm extends StatefulWidget {
  @override
  State<Example3_MultilingualForm> createState() => _Example3State();
}

class _Example3State extends State<Example3_MultilingualForm> {
  final ls = LanguageService();
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  void _handleLanguageChange(String langCode) {
    setState(() {
      ls.setLanguage(langCode);
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Handle form submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ls.getText('login'))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ls.getText('app_title')),
        actions: [
          PopupMenuButton<String>(
            onSelected: _handleLanguageChange,
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'en',
                child: Text('English'),
              ),
              PopupMenuItem(
                value: 'hi',
                child: Text('हिंदी'),
              ),
            ],
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: ls.getText('login'),
                hintText: ls.getText('welcome'),
              ),
              validator: (value) =>
                  value?.isEmpty ?? true ? ls.getText('help') : null,
              onSaved: (value) => _username = value ?? '',
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: ls.getText('logout'),
              ),
              obscureText: true,
              onSaved: (value) => _password = value ?? '',
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text(ls.getText('login')),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// EXAMPLE 4: List View with Translated Items
// ============================================================================

class Example4_TranslatedListView extends StatefulWidget {
  @override
  State<Example4_TranslatedListView> createState() => _Example4State();
}

class _Example4State extends State<Example4_TranslatedListView> {
  final ls = LanguageService();

  final List<String> _menuKeys = [
    'home',
    'settings',
    'help',
    'about',
    'login',
    'logout',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ls.getText('app_title')),
      ),
      body: ListView.builder(
        itemCount: _menuKeys.length,
        itemBuilder: (context, index) {
          final key = _menuKeys[index];
          return ListTile(
            title: Text(ls.getText(key)),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(ls.getText(key))),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            final currentLang = ls.getCurrentLanguage();
            ls.setLanguage(currentLang == 'en' ? 'hi' : 'en');
          });
        },
        child: Text(ls.getCurrentLanguage().toUpperCase()),
      ),
    );
  }
}

// ============================================================================
// EXAMPLE 5: Dialog with Multilingual Support
// ============================================================================

class Example5_MultilingualDialog extends StatefulWidget {
  @override
  State<Example5_MultilingualDialog> createState() => _Example5State();
}

class _Example5State extends State<Example5_MultilingualDialog> {
  final ls = LanguageService();

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(ls.getText('welcome')),
          content: Text(ls.getText('hello')),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(ls.getText('logout')),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(ls.getText('login')),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ls.getText('app_title')),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _showDialog,
          child: Text(ls.getText('help')),
        ),
      ),
    );
  }
}

// ============================================================================
// EXAMPLE 6: Using getText in Custom Widgets
// ============================================================================

class Example6_CustomWidgets extends StatelessWidget {
  final ls = LanguageService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ls.getText('app_title')),
      ),
      body: Column(
        children: [
          _buildCustomCard(
            icon: '👤',
            title: ls.getText('login'),
            subtitle: ls.getText('welcome'),
          ),
          _buildCustomCard(
            icon: '⚙️',
            title: ls.getText('settings'),
            subtitle: ls.getText('language'),
          ),
          _buildCustomCard(
            icon: '❓',
            title: ls.getText('help'),
            subtitle: ls.getText('about'),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomCard({
    required String icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      child: ListTile(
        leading: Text(icon, style: TextStyle(fontSize: 24)),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}

// ============================================================================
// EXAMPLE 7: Bottom Sheet with Language Selection
// ============================================================================

class Example7_LanguageBottomSheet extends StatefulWidget {
  @override
  State<Example7_LanguageBottomSheet> createState() => _Example7State();
}

class _Example7State extends State<Example7_LanguageBottomSheet> {
  final ls = LanguageService();

  void _showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                ls.getText('select_language'),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24),
              ...ls.getSupportedLanguages().map((langCode) {
                return ListTile(
                  title: Text(ls.getLanguageName(langCode)),
                  trailing: ls.getCurrentLanguage() == langCode
                      ? Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    setState(() {
                      ls.setLanguage(langCode);
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ls.getText('app_title')),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _showLanguageBottomSheet,
          child: Text(ls.getText('select_language')),
        ),
      ),
    );
  }
}

// ============================================================================
// EXAMPLE 8: Combining with String Interpolation
// ============================================================================

class Example8_StringInterpolation extends StatelessWidget {
  final ls = LanguageService();

  @override
  Widget build(BuildContext context) {
    String userName = "John";
    String greeting = "${ls.getText('hello')}, $userName!";

    return Scaffold(
      appBar: AppBar(
        title: Text(ls.getText('app_title')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              greeting,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              "${ls.getText('welcome')} to ${ls.getText('app_title')}",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// USAGE TIPS:
// ============================================================================
// 
// 1. Always access LanguageService as a singleton:
//    final ls = LanguageService();
//
// 2. In StatefulWidgets, call setState() to refresh UI after language change:
//    setState(() => ls.setLanguage('hi'));
//
// 3. Wrap text-only updates in setState() for automatic rebuild
//
// 4. Use getText() with keys defined in assets/strings/strings.json
//
// 5. Keys follow snake_case naming convention: 'my_key'
//
// 6. Hindi and all Unicode characters are fully supported
//
// 7. If a key is missing, it falls back gracefully (returns key name)
//
// 8. Initialize LanguageService in main() before building the widget tree
//
// ============================================================================
