import 'package:blog_nest/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border({Color borderColor = AppPallete.borderColor}) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: borderColor, width: 3),
        borderRadius: BorderRadius.circular(10),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(backgroundColor: AppPallete.backgroundColor),
    inputDecorationTheme: InputDecorationTheme(
      focusedErrorBorder: _border(borderColor: AppPallete.errorColor),
      contentPadding: const EdgeInsets.all(22),
      enabledBorder: _border(),
      focusedBorder: _border(borderColor: AppPallete.gradient2),
      errorBorder: _border(borderColor: AppPallete.errorColor)
    ),
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(AppPallete.backgroundColor),
      side: BorderSide.none
    )
  );
}
