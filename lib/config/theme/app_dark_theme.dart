import 'package:flutter/material.dart';

class AppDarkTheme {
  static ThemeData? _instance;

  static ThemeData get instance {
    if (_instance == null) {
      throw Exception(
        'You must call AppDarkTheme.initialize() before using the theme',
      );
    }
    return _instance!;
  }

  static void initialize(BuildContext context) {
    _instance = _buildTheme(context);
  }

  static ThemeData _buildTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
