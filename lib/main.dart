import "package:flutter/material.dart";
import "package:vellio/screens/onboarding.dart";
import "package:vellio/screens/track_method_screen.dart";
import "package:vellio/themes/themes.dart";

void main() {
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotif,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: "Vellio",
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: currentMode,
          home: const Onboarding(),
          initialRoute: '/',
          routes: {
            '/trackmethod': (context) => const TrackMethodScreen(),
          },
        );
      },
    );
  }
}
