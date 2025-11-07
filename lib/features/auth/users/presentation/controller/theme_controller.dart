import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/app_constants.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  final _themeMode = ThemeMode.system.obs;
  late SharedPreferences _prefs;

  ThemeMode get themeMode => _themeMode.value;
  bool get isDarkMode => _themeMode.value == ThemeMode.dark;

  @override
  void onInit() {
    super.onInit();
    _initTheme();
  }

  Future<void> _initTheme() async {
    _prefs = await SharedPreferences.getInstance();
    final savedTheme = _prefs.getString(AppConstants.themeKey);
    
    if (savedTheme != null) {
      _themeMode.value = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == savedTheme,
        orElse: () => ThemeMode.system,
      );
    }
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    _themeMode.value = themeMode;
    Get.changeThemeMode(themeMode);
    await _prefs.setString(AppConstants.themeKey, themeMode.toString());
  }

  void toggleTheme() {
    final newMode = _themeMode.value == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    changeTheme(newMode);
  }
}
