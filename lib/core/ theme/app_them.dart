import 'package:flutter/material.dart';

import '../utiles/app_colors.dart';

class AppTheme {
  // 👇 تقدر تعدّل الـ Light لو حابب، أنا سيبته بسيط
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF007AFF),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF007AFF),
      secondary: const Color(0xFF007AFF),
      surface: Colors.white,
      onSurface: Colors.black87,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 0,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: const Color(0xFF212121),

    colorScheme:  ColorScheme.dark(
      primary: AppColors.primary,        // عدّلها للـ primary بتاعك
      secondary: Color(0xFF007AFF),
      surface: Color(0xFF2A2A2A),
      onSurface: Color(0xFFF5F5F5),
    ),

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF212121),
      foregroundColor: Color(0xFFF5F5F5),
      elevation: 0,
      iconTheme: IconThemeData(
        color: Color(0xFFF5F5F5),
      ),
    ),

    // BottomNavigationBar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF212121),
      selectedItemColor: Color(0xFF007AFF),
      unselectedItemColor: Color(0xFFBDBDBD),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // النصوص
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Color(0xFFF5F5F5),
      ),
      bodySmall: TextStyle(
        color: Color(0xFFBDBDBD),
      ),
      titleMedium: TextStyle(
        color: Color(0xFFF5F5F5),
        fontWeight: FontWeight.w600,
      ),
    ),

    // TextField / FormField
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2A2A2A),
      hintStyle: const TextStyle(
        color: Color(0xFFBDBDBD),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFF424242),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFF007AFF),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),


    cardColor: const Color(0xFF2A2A2A),


    shadowColor: Colors.black.withOpacity(0.5),


    iconTheme: const IconThemeData(
      color: Color(0xFFF5F5F5),
    ),
  );
}
