import 'package:flutter/material.dart';
import 'package:state_app/ui/theme/app_theme.dart';

Widget testableApp({
  required Widget child,
  required AppTheme appTheme,
}) {
  return MaterialApp(
    theme: ThemeData(
      colorScheme: appTheme.colorScheme,
      useMaterial3: true,
      fontFamily: 'Noto Sans JP',
    ),
    debugShowCheckedModeBanner: false,
    home: child,
  );
}
