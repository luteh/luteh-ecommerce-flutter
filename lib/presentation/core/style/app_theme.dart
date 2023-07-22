import 'package:flutter/material.dart';

enum ThemeType { light, dark }

class AppTheme {
  const AppTheme._();

  static ThemeData getThemeData({required ThemeType themeType}) {
    late ThemeData themeData;
    switch (themeType) {
      case ThemeType.light:
        themeData = ThemeData.light(useMaterial3: true);
        return themeData.copyWith(
          appBarTheme: themeData.appBarTheme.copyWith(
            centerTitle: true,
          ),
        );
      case ThemeType.dark:
        themeData = ThemeData.dark(useMaterial3: true);
        return themeData.copyWith(
          appBarTheme: themeData.appBarTheme.copyWith(
            centerTitle: true,
          ),
        );
    }
  }
}
