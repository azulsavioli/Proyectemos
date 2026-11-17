import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccessibilityProvider with ChangeNotifier {
  bool _isAccessible = false;

  bool get isAccessible => _isAccessible;

  AccessibilityProvider() {
    _loadAccessibility();
  }

  Future<void> _loadAccessibility() async {
    final preferences = await SharedPreferences.getInstance();
    final isAccessibleOn = preferences.getBool("isAccessible");
    if (isAccessibleOn != null) {
      _isAccessible = isAccessibleOn;
    }
    notifyListeners();
  }

  Future<void> setAccessibility(bool value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool("isAccessible", value);
    _isAccessible = value;
    notifyListeners();
  }
}
