import 'package:flutter/material.dart';
import '../preferences.dart';

class ModelTheme extends ChangeNotifier {
  late bool _isDark;
  bool get isDark => _isDark;

  ModelTheme() {
    _isDark = false;
    getPreferences();
  }
  set isDark(bool value) {
    _isDark = value;
    AppPreferences.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await AppPreferences.getTheme();
    notifyListeners();
  }
}