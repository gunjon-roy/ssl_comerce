import 'package:flutter/material.dart';
class Style {
  static ThemeData themeData(bool isDarkTheme) {
    return ThemeData(
      primaryColor: isDarkTheme ? Colors.black : Colors.deepPurple,
      scaffoldBackgroundColor: isDarkTheme ? Color(0xFF222222) : Colors.white,
    );
  }
}