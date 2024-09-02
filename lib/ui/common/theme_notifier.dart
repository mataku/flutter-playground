import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/repository/theme_repository.dart';
import 'package:state_app/ui/theme/app_theme.dart';

final themeNotifierProvider = ChangeNotifierProvider(
    (ref) => ThemeNotifier(ref.read(themeRepositoryProvider)));

class ThemeNotifier extends ChangeNotifier {
  final ThemeRepository _themeRepository;

  AppTheme? appTheme = AppTheme.dark;

  ThemeNotifier(
    ThemeRepository themeRepository,
  ) : _themeRepository = themeRepository;

  Future<AppTheme> getCurrentTheme() async {
    appTheme = await _themeRepository.getCurrentTheme();
    return appTheme ?? AppTheme.dark;
  }

  Future<void> setCurrentTheme(AppTheme newTheme) async {
    appTheme = newTheme;

    await _themeRepository.setTheme(newTheme);
    notifyListeners();
  }
}
