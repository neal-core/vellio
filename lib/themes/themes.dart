import 'package:flutter/material.dart';

final ValueNotifier<ThemeMode> themeNotif = ValueNotifier(ThemeMode.system);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFB8BBE0),
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: const Color(0xFFF6F6FA),
  textTheme: TextTheme(
    titleLarge: const TextStyle(
      fontSize: 22,
      fontFamily: "Josefin",
      fontWeight: FontWeight.bold,
      color: Color(0xFF5A5C7F),
    ),
    titleMedium: const TextStyle(
      fontSize: 18,
      fontFamily: "EduVic",
      fontWeight: FontWeight.w500,
      color: Color(0xFF797C9E),
    ),
    titleSmall: const TextStyle(
      fontSize: 12,
      color: Color(0xFF8688A5),
      fontFamily: "ComicSans",
    ),
    labelSmall: TextStyle(
      color: Colors.grey[600],
      fontSize: 17,
      fontFamily: "Gadugi",
    ),
    labelLarge: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Color(0xFF4A4C6A),
    ),
  ),
  cardTheme: const CardThemeData(
    color: Colors.white,
    surfaceTintColor: Color(0xFFD8E2FF),
    elevation: 2.0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return const Color(0xFF706D6D);
        }
        return const Color(0xFFB8BBE0);
      }),
      foregroundColor: const WidgetStatePropertyAll(Colors.white),
      elevation: const WidgetStatePropertyAll(2),
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFF6E1B4B),
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: Color(0xFF1A1D2E),
  textTheme: TextTheme(
    titleLarge: const TextStyle(
      fontSize: 22,
      fontFamily: "Josefin",
      fontWeight: FontWeight.bold,
      color: Color(0xFF9AA4FF),
    ),
    titleMedium: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: "EduVic",
      color: Color(0xFFCCD2FF),
    ),
    titleSmall: const TextStyle(
      fontSize: 12,
      color: Color(0xFFCCD2FF),
      fontFamily: "ComicSans",
    ),
    labelLarge: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Color(0xFFCCD2FF),
    ),
    labelSmall: TextStyle(
      color: Colors.grey[500],
      fontSize: 17,
      fontFamily: "Bricolage",
    ),
  ),
  cardTheme: CardThemeData(
    color: Color(0xFF545EA6),
    surfaceTintColor: Color(0xFF2F3150),
    elevation: 6.0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return Color(0xFF353535);
        }
        return Color(0xFF545EA6);
      }),
      elevation: WidgetStatePropertyAll(10),
    ),
  ),
);
