import 'package:flutter/material.dart';

class AppTheme {
  static const _bg1 = Color(0xFF2F3E3A);
  static const _bg2 = Color(0xFF1F2A28);
  static const _mint = Color(0xFFBFE7D3);
  static const _accent = Color(0xFF98D8B4);

  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _bg2,
    fontFamily: 'Roboto',
    colorScheme: const ColorScheme.dark(
      primary: _accent,
      secondary: _mint,
      surface: Color(0xFF22302D),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
    ),
  );

  static BoxDecoration backgroundGradient() => BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [_bg1, _bg2, _bg1.withValues(alpha: 0.75)],
    ),
  );

  static Color glassColor() => Colors.white.withValues(alpha: 0.10);

  static Color glassBorder() => Colors.white.withValues(alpha: 0.18);
}
