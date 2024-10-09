import 'app_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static _border([Color color = AppPalette.borderColor]) => OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: 3,
    ),
    borderRadius: BorderRadius.circular(10),
  );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPalette.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.backgroundColor,
    ),
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(
        AppPalette.backgroundColor,
      ),
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPalette.gradient2),
      errorBorder: _border(AppPalette.errorColor),
    ),
  );
}