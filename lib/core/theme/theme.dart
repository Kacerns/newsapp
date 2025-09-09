import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/core/constants/news_app_constants.dart';

class NewsAppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: NewsAppColors.highContBlue,
        onPrimary: NewsAppColors.whiteMain,
        surface: NewsAppColors.whiteMain,
        onSurface: NewsAppColors.lightOnSurface,
      ),
      textTheme: GoogleFonts.interTextTheme(),
      appBarTheme: AppBarTheme(
        titleTextStyle: GoogleFonts.inter(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: NewsAppColors.highContBlue,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: NewsAppColors.highContBlue,
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w500),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: NewsAppColors.whiteSmoke,
        contentTextStyle: TextStyle(
          color: NewsAppColors.lightOnSurface,
          fontSize: 12,
        ),
        actionTextColor: NewsAppColors.highContBlue,
      ),
      cardTheme: CardThemeData(
        shadowColor: NewsAppColors.highContBlue,
        elevation: 2.5,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: NewsAppColors.darkHighContBlue,
        onPrimary: NewsAppColors.darkWhite,
        surface: NewsAppColors.darkSurface,
        onSurface: NewsAppColors.darkWhite,
      ),
      textTheme: GoogleFonts.interTextTheme().apply(
        bodyColor: NewsAppColors.darkWhite,
        displayColor: NewsAppColors.darkWhite,
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: GoogleFonts.inter(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: NewsAppColors.darkHighContBlue,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: NewsAppColors.darkHighContBlue,
          foregroundColor: NewsAppColors.darkWhite,
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w500),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: NewsAppColors.lightOnSurface,
        contentTextStyle: TextStyle(
          color: NewsAppColors.darkWhite,
          fontSize: 12,
        ),
        actionTextColor: NewsAppColors.darkHighContBlue,
      ),
      cardTheme: CardThemeData(
        shadowColor: NewsAppColors.darkHighContBlue,
        elevation: 2.5,
      ),
    );
  }
}
