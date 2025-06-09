
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF4CAF50), // Forest Green
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF4CAF50), // Forest Green
      secondary: const Color(0xFF81C784), // Lighter green
      surface: const Color(0xFFF1F8E9), // Very light green
      error: const Color(0xFFD32F2F), // Default destructive red
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: const Color(0xFF212121),
      onError: Colors.white,
      brightness: Brightness.light,
      tertiary: const Color(0xFFFFC107), // Earthy Yellow/Gold (Accent)
      onTertiary: Colors.black,
    ),
    scaffoldBackgroundColor: const Color(0xFFF1F8E9), // Very light green
    appBarTheme: const AppBarTheme(
      color: Color(0xFFF1F8E9), // Very light green for appbar bg
      elevation: 1,
      iconTheme: IconThemeData(color: Color(0xFF212121)),
      titleTextStyle: TextStyle(
        color: Color(0xFF212121),
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      buttonColor: const Color(0xFF4CAF50), // Forest Green
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4CAF50), // Forest Green
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF4CAF50), // Forest Green
      )
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color(0xFFBDBDBD)), // Subtle green-gray border
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2.0), // Forest Green
      ),
      filled: true,
      fillColor: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF4CAF50), // Forest Green
      unselectedItemColor: Colors.grey[600],
      elevation: 8.0,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFC8E6C9), // Light green for chips
      labelStyle: const TextStyle(color: Color(0xFF2E7D32)), // Darker green text
      secondarySelectedColor: const Color(0xFF4CAF50), // Forest Green
      selectedColor: const Color(0xFF4CAF50),
      padding: const EdgeInsets.all(4.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    ),
    // fontFamily: 'YourCustomFont', // if you add one
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF66BB6A), // Forest Green (slightly brighter for dark mode)
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFF66BB6A),
      secondary: const Color(0xFF388E3C), // Darker muted green
      surface: const Color(0xFF1E1E1E), // Very Dark Gray
      error: const Color(0xFFEF5350), // Default destructive red
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onSurface: const Color(0xFFE0E0E0),
      onError: Colors.black,
      brightness: Brightness.dark,
      tertiary: const Color(0xFFFFD54F), // Earthy Yellow/Gold (slightly muted for dark)
      onTertiary: Colors.black,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF1E1E1E), // Darker appbar
      elevation: 1,
      iconTheme: IconThemeData(color: Color(0xFFE0E0E0)),
      titleTextStyle: TextStyle(
        color: Color(0xFFE0E0E0),
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF2C2C2C),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      buttonColor: const Color(0xFF66BB6A),
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF66BB6A),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),
     textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF66BB6A),
      )
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color(0xFF424242)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color(0xFF66BB6A), width: 2.0),
      ),
      filled: true,
      fillColor: const Color(0xFF333333),
    ),
     bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF1E1E1E),
      selectedItemColor: const Color(0xFF66BB6A),
      unselectedItemColor: Colors.grey[500],
      elevation: 8.0,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFF388E3C), // Darker green for chips
      labelStyle: const TextStyle(color: Colors.white),
      secondarySelectedColor: const Color(0xFF66BB6A),
      selectedColor: const Color(0xFF66BB6A),
      padding: const EdgeInsets.all(4.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    ),
    // fontFamily: 'YourCustomFont',
  );
}
