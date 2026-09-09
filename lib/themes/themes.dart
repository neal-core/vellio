import 'package:flutter/material.dart';

final ValueNotifier<ThemeMode> themeNotif = ValueNotifier(ThemeMode.dark);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF005AC1),
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: const Color(0xFFF8F9FF),
  textTheme: TextTheme(
    titleLarge: const TextStyle(
      fontSize: 22,
      fontFamily: "Josefin",
      fontWeight: FontWeight.bold,
      color: Color(0xFF005AC1),
    ),
    titleMedium: const TextStyle(
      fontSize: 18,
      fontFamily: "EduVic",
      fontWeight: FontWeight.w500,
      color: Color(0xFF1B1B1F),
    ),
    titleSmall: const TextStyle(
      fontSize: 12,
      color: Color(0xFF44474E),
      fontFamily: "ComicSans",
    ),
    labelSmall: TextStyle(
      color: Colors.grey[600],
      fontSize: 17,
      fontFamily: "Gadugi",
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
          return const Color(0xFFE1E2EC);
        }
        return const Color(0xFF005AC1);
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
