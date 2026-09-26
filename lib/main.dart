import "package:flutter/material.dart";
import "package:flutter_windowmanager_plus/flutter_windowmanager_plus.dart";
import "package:vellio/executors/sms_executor.dart";
import "package:vellio/screens/dashboard_screen.dart";
import "package:vellio/screens/name_input_screen.dart";
import "package:vellio/services/onboarding_data_manager.dart";
import "package:vellio/themes/themes.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final OnboardingDataManager datamanager = OnboardingDataManager();
  final userdata = await datamanager.readFile();
  bool syncComplete = userdata != null ? true : false;
  /*  if (syncComplete) {
    await SmsExecutor.initialize();
  }*/
  await FlutterWindowManagerPlus.setSecure(true);
  await FlutterWindowManagerPlus.addFlags(FlutterWindowManagerPlus.FLAG_KEEP_SCREEN_ON);
  runApp(MainScreen(syncComplete: syncComplete));
}

class MainScreen extends StatelessWidget {
  final bool syncComplete;
  const MainScreen({super.key, required this.syncComplete});
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
          home: syncComplete ? const Dashboard() : const NameInput(),
          initialRoute: '/',
        );
      },
    );
  }
}
