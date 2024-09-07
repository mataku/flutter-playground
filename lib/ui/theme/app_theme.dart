import 'package:flutter/material.dart';
import 'package:sunrisescrob/ui/theme/app_colors.dart';

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
  primary: Color(0xFFF5F5F5),
  onPrimary: Colors.black,
  secondary: Colors.white,
  onSecondary: AppColors.grey600,
  surface: Color(0xFFF5F5F5),
  onSurface: Colors.black,
);
const darkColorScheme = ColorScheme.dark(
  primary: Color(0xFF444444),
  onPrimary: Colors.white,
  primaryContainer: Color(0xFF444444),
  onPrimaryContainer: Colors.white,
  secondary: Colors.white,
  onSecondary: AppColors.blueGrey300,
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
  onSecondary: AppColors.blueGrey300,
  surface: AppColors.blueGrey900,
  onSurface: Colors.white,
);

extension AppThemeExt on AppTheme {
  Color accentColor() {
    return switch (this) {
      AppTheme.light => AppColors.lime,
      AppTheme.dark => AppColors.lime,
      AppTheme.lastfmDark => AppColors.lastFmRed,
    };
  }
}

extension ColorSchemeExt on ColorScheme {
  Color accentColor() {
    if (brightness == Brightness.light) {
      return AppColors.lime;
    } else if (brightness == Brightness.dark &&
        primary == const Color(0xFF444444)) {
      return AppColors.lime;
    } else {
      return AppColors.lastFmRed;
    }
  }
}
