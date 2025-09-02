import 'package:flutter/material.dart';

class AppLightTheme {
  static ThemeData? _instance;

  static ThemeData get instance {
    if (_instance == null) {
      throw Exception(
        'You must call AppLightTheme.initialize() before using the theme',
      );
    }
    return _instance!;
  }

  static void initialize(BuildContext context) {
    _instance = _buildTheme(context);
  }

  static ThemeData _buildTheme(BuildContext context) {
    return ThemeData(
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.green[200],
      ),
      appBarTheme: AppBarTheme(backgroundColor: Colors.green[200]),
      brightness: Brightness.light,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
