import 'package:flutter/material.dart';

final ValueNotifier<ThemeMode> themeNotif = ValueNotifier(ThemeMode.system);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xDBE12B8D),
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: Color(0xFFF6F6F6),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 26,
      fontFamily: "Griffy",
      fontWeight: FontWeight.bold,
      color: Color(0xFF6978E6),
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      fontFamily: "EduVic",
      fontWeight: FontWeight.w500,
      color: Color(0xFF1A1D2E),
    ),
    titleSmall: TextStyle(fontSize: 14, color: Color(0xFFB1B8ED)),
  ),
  cardTheme: CardThemeData(
    color: Color(0xDBE12B8D),
    surfaceTintColor: Color(0xDB5A0F37),
    elevation: 6.0,
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFF6E1B4B),
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: Color(0xFF1A1D2E),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 26,
      fontFamily: "Griffy",
      fontWeight: FontWeight.bold,
      color: Color(0xFF9AA4FF),
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamily: "EduVic",
      color: Color(0xFFCCD2FF),
    ),
    titleSmall: TextStyle(fontSize: 14, color: Color(0xFFCCD2FF)),
  ),
  cardTheme: CardThemeData(
    color: Color(0xFF545EA6),
    surfaceTintColor: Color(0xFF2F3150),
    elevation: 6.0,
  ),
);
