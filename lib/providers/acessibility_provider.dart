import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Accessibility mode follows the system unless the student sets an override.
class AccessibilityProvider with ChangeNotifier {
  static const preferenceKey = 'isAccessible';

  bool? _override;
  bool _loaded = false;

  bool get loaded => _loaded;

  /// Null means "follow the system".
  bool? get overridePreference => _override;

  AccessibilityProvider() {
    _loadAccessibility();
  }

  /// The long accessible lesson is for a screen reader, or for the in-app
  /// switch. Bold text and reduced motion only change presentation.
  bool followsSystem(MediaQueryData media) {
    return media.accessibleNavigation;
  }

  bool isEnabled(BuildContext context) {
    return _override ?? followsSystem(MediaQuery.of(context));
  }

  Future<void> _loadAccessibility() async {
    final preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(preferenceKey)) {
      _override = preferences.getBool(preferenceKey);
    } else {
      _override = null;
    }
    _loaded = true;
    notifyListeners();
  }

  Future<void> setAccessibility(bool value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(preferenceKey, value);
    _override = value;
    notifyListeners();
  }

  Future<void> clearOverride() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(preferenceKey);
    _override = null;
    notifyListeners();
  }
}
