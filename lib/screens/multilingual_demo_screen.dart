import 'package:flutter/material.dart';
import 'package:aapka_sathi_app/services/language_service.dart';
import 'language_selection_screen.dart';

class MultilingualDemoScreen extends StatefulWidget {
  const MultilingualDemoScreen({Key? key}) : super(key: key);

  @override
  State<MultilingualDemoScreen> createState() => _MultilingualDemoScreenState();
}

class _MultilingualDemoScreenState extends State<MultilingualDemoScreen> {
  late LanguageService _languageService;

  @override
  void initState() {
    super.initState();
    _languageService = LanguageService();
  }

  void _switchLanguage(String languageCode) {
    setState(() {
      _languageService.setLanguage(languageCode);
    });
  }

  void _changeLanguageFromMenu() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LanguageSelectionScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _languageService.getText('app_title'),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
        elevation: 5,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.purple.shade50,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Current Language Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade400,
                      Colors.purple.shade400,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _languageService.getText('current_language'),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _languageService.getLanguageName(
                        _languageService.getCurrentLanguage(),
                      ),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Quick Language Switch Buttons
            Text(
              _languageService.getText('switch_language'),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _languageService.getSupportedLanguages().map((langCode) {
                final isCurrentLanguage =
                    langCode == _languageService.getCurrentLanguage();
                return ElevatedButton(
                  onPressed: () => _switchLanguage(langCode),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isCurrentLanguage
                        ? Colors.blue.shade700
                        : Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _languageService.getLanguageName(langCode),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          isCurrentLanguage ? Colors.white : Colors.black87,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),

            // Sample Text Strings
            Text(
              'Sample Translated Strings:',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _buildStringCard(
              key: 'welcome',
              icon: '👋',
            ),
            _buildStringCard(
              key: 'hello',
              icon: '😊',
            ),
            _buildStringCard(
              key: 'goodbye',
              icon: '👋',
            ),
            _buildStringCard(
              key: 'login',
              icon: '🔓',
            ),
            _buildStringCard(
              key: 'logout',
              icon: '🔐',
            ),
            _buildStringCard(
              key: 'settings',
              icon: '⚙️',
            ),
            _buildStringCard(
              key: 'help',
              icon: '❓',
            ),
            _buildStringCard(
              key: 'about',
              icon: 'ℹ️',
            ),
            const SizedBox(height: 32),

            // Demo Content Section
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          '📝 How It Works:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildBulletPoint(
                      'Strings are stored in assets/strings/strings.json',
                    ),
                    _buildBulletPoint(
                      'LanguageService manages language selection',
                    ),
                    _buildBulletPoint(
                      'getText(key) returns translated strings',
                    ),
                    _buildBulletPoint(
                      'No external APIs or libraries needed',
                    ),
                    _buildBulletPoint(
                      'Supports Hindi Unicode natively',
                    ),
                    _buildBulletPoint(
                      'Easily add more languages to strings.json',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Footer Button
            ElevatedButton.icon(
              onPressed: _changeLanguageFromMenu,
              icon: const Icon(Icons.language),
              label: Text(
                _languageService.getText('select_language'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade600,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildStringCard({
    required String key,
    required String icon,
  }) {
    final translatedText = _languageService.getText(key);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Text(
              icon,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    key,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    translatedText,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
