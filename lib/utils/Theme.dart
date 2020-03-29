import 'package:flutter/material.dart';

final ThemeData CustomThemeData = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: MaterialColor(0xFFD32F2F, ThemeColors.primaryColor),
  primaryColor: ThemeColors.primaryColor[50],
//    primaryColorBrightness: Brightness.light,
  accentColor: ThemeColors.accentColor[500],
//    appBarTheme: ,
//    accentColorBrightness: Brightness.light
);

class ThemeColors {
  ThemeColors._(); // #329254
  static const Map<int, Color> accentColor  = const <int, Color>{
    50: const Color(0xFF329254),
    100: const Color(0xFF329254),
    200: const Color(0xFF329254),
    300: const Color(0xFF329254),
    400: const Color(0xFF329254),
    500: const Color(0xFF329254),
    600: const Color(0xFF329254),
    700: const Color(0xFF329254),
    800: const Color(0xFF329254),
    900: const Color(0xFF329254)
  };

//#D32F2F
  static const Map<int, Color> primaryColor = const <int, Color>{
    50: const Color(0xFFD32F2F),
    100: const Color(0xFFD32F2F),
    200: const Color(0xFFD32F2F),
    300: const Color(0xFFD32F2F),
    400: const Color(0xFFD32F2F),
    500: const Color(0xFFD32F2F),
    600: const Color(0xFFD32F2F),
    700: const Color(0xFFD32F2F),
    800: const Color(0xFFD32F2F),
    900: const Color(0xFFD32F2F)
  };
}