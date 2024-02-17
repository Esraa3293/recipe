import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  String languageCode = "en";

  void changeLanguage(String lang) {
    languageCode = lang;
    notifyListeners();
  }
}
