import 'package:flutter/material.dart';

enum ThemeType { light, dark }

class AppTheme {
  const AppTheme._();

  static ThemeData getThemeData({required ThemeType themeType}) {
    switch (themeType) {
      case ThemeType.light:
        return ThemeData.light(useMaterial3: true);
      case ThemeType.dark:
        return ThemeData.dark(useMaterial3: true);
    }
  }
}
