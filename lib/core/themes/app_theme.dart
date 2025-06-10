import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_font.dart';

abstract class AppTheme {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder()},
    ),
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      titleTextStyle: Typograph.subtitle18,
    ),
  );
}
