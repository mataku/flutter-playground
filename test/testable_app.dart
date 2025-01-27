import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sunrisescrob/ui/theme/app_theme.dart';

Widget testableApp({
  required Widget child,
  required AppTheme appTheme,
}) {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: appTheme.brightness,
      statusBarIconBrightness: appTheme.brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: appTheme.brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    ),
  );

  return MaterialApp(
    theme: ThemeData(
      colorScheme: appTheme.colorScheme,
      useMaterial3: true,
      fontFamily: 'Noto Sans JP',
      brightness: appTheme.brightness,
    ),
    debugShowCheckedModeBanner: false,
    home: ColoredBox(
      color: appTheme.colorScheme.surface,
      child: child,
    ),
  );
}
