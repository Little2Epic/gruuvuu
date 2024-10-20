import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../models/settings_model.dart';

class SettingsProvider with ChangeNotifier {
  Settings _settings = Settings(); // Default settings

  Settings get settings => _settings;

  SettingsProvider() {
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final settingsJson = prefs.getString('settings');
    if (settingsJson != null) {
      final settingsMap = json.decode(settingsJson) as Map<String, dynamic>;
      _settings = Settings.fromMap(settingsMap);
      notifyListeners();
    }
  }

  Future<void> saveSettings(Settings newSettings) async {
    _settings = newSettings;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('settings', json.encode(_settings.toMap()));
    notifyListeners();
  }
}
