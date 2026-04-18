import 'dart:convert';
import 'package:flutter/services.dart';

class LanguageService {
  static final LanguageService _instance = LanguageService._internal();
  
  late Map<String, dynamic> _strings;
  late String _currentLanguage;
  
  // List of supported languages
  static const List<String> supportedLanguages = ['en', 'hi'];
  static const Map<String, String> languageNames = {
    'en': 'English',
    'hi': 'हिंदी (Hindi)',
  };

  factory LanguageService() {
    return _instance;
  }

  LanguageService._internal();

  /// Initialize the language service with strings and set the default language
  Future<void> init({String defaultLanguage = 'en'}) async {
    try {
      // Load the JSON file from assets
      final jsonString = await rootBundle.loadString('assets/strings/strings.json');
      _strings = jsonDecode(jsonString);
      
      // Set the current language
      if (supportedLanguages.contains(defaultLanguage)) {
        _currentLanguage = defaultLanguage;
      } else {
        _currentLanguage = 'en'; // Fallback to English
      }
    } catch (e) {
      print('Error loading language strings: $e');
      _strings = {};
      _currentLanguage = 'en';
    }
  }

  /// Get a localized string by key
  /// Returns the string in the current language, or the English version as fallback
  String getText(String key) {
    try {
      if (_strings.isEmpty) {
        return key; // Return key if strings not loaded
      }
      
      final languageStrings = _strings[_currentLanguage];
      if (languageStrings != null && languageStrings[key] != null) {
        return languageStrings[key];
      }
      
      // Fallback to English if key not found in current language
      final englishStrings = _strings['en'];
      if (englishStrings != null && englishStrings[key] != null) {
        return englishStrings[key];
      }
      
      // Return the key itself if not found in any language
      return key;
    } catch (e) {
      print('Error getting text for key "$key": $e');
      return key;
    }
  }

  /// Get the current language code
  String getCurrentLanguage() {
    return _currentLanguage;
  }

  /// Get the display name of a language
  String getLanguageName(String languageCode) {
    return languageNames[languageCode] ?? languageCode;
  }

  /// Set the current language
  void setLanguage(String languageCode) {
    if (supportedLanguages.contains(languageCode)) {
      _currentLanguage = languageCode;
    }
  }

  /// Get list of supported languages
  List<String> getSupportedLanguages() {
    return List.unmodifiable(supportedLanguages);
  }

  /// Get all strings for the current language
  Map<String, String> getAllStrings() {
    try {
      final languageStrings = _strings[_currentLanguage];
      if (languageStrings != null) {
        return Map<String, String>.from(languageStrings);
      }
      return {};
    } catch (e) {
      print('Error getting all strings: $e');
      return {};
    }
  }
}
