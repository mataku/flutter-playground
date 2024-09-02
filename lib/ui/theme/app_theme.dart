import 'package:flutter/material.dart';

enum AppTheme {
  light(
    'light',
    'Light',
    lightColorScheme,
    Brightness.light,
  ),
  dark(
    'dark',
    'Dark',
    darkColorScheme,
    Brightness.dark,
  ),
  lastfmDark(
    'lastfmdark',
    'Last.fm Dark',
    lastfmDarkColorScheme,
    Brightness.dark,
  );

  const AppTheme(
    this.id,
    this.label,
    this.colorScheme,
    this.brightness,
  );

  final String id;
  final String label;
  final ColorScheme colorScheme;
  final Brightness brightness;
}

const lightColorScheme = ColorScheme.light(
  primary: Color(0xFFEEEEEE),
  onPrimary: Colors.black,
  secondary: Colors.white,
  onSecondary: Color(0xFF757575),
  surface: Color(0xFFF5F5F5),
  onSurface: Colors.black,
);
const darkColorScheme = ColorScheme.dark(
  primary: Color(0xFF444444),
  onPrimary: Colors.white,
  primaryContainer: Color(0xFF444444),
  onPrimaryContainer: Colors.white,
  secondary: Colors.white,
  onSecondary: Color(0xFF90A4AE),
  secondaryContainer: Colors.white,
  onSecondaryContainer: Color(0xFF90A4AE),
  surface: Color(0xFF37474F),
  onSurface: Colors.white,
  surfaceContainer: Color(0xFF37474F),
);
const lastfmDarkColorScheme = ColorScheme.dark(
  primary: Color(0xFF444444),
  onPrimary: Colors.white,
  secondary: Colors.white,
  onSecondary: Color(0xFF90A4AE),
  surface: Color(0xFF263238),
  onSurface: Colors.white,
);

extension AppThemeExt on AppTheme {
  Color accentColor() {
    return switch (this) {
      AppTheme.light => const Color(0xFFC0CA33),
      AppTheme.dark => const Color(0xFFC0CA33),
      AppTheme.lastfmDark => const Color(0xFFbb0414)
    };
  }
}
