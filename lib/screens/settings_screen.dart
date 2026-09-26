import 'package:flutter/material.dart';
import 'package:vellio/services/color_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final ColorManager colorManager = ColorManager(context: context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorManager.themeColSet(0xFFF6F6FA, 0XFF1A1D2E),
        elevation: 3,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Color(0xFF1E293B),
          ),
        ),
        title: Text("Settings", style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Text("Automation", style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: 12.0),
          Container(
            decoration: BoxDecoration(
              color: colorManager.themeColSet(0xFFFFFFFF, 0xFF1E293B),
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: isDark
                  ? null
                  : [
                      BoxShadow(
                        color: Color(0x04000000),
                        blurRadius: 10,
                        offset: const Offset(0, 10),
                      ),
                    ],
              border: isDark ? Border.all(color: Color(0x08FFFFFF)) : null,
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: colorManager.themeColSet(0x197D70C9, 0x197D70C9),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(
                      Icons.account_balance,
                      color: colorManager.themeColSet(0xFF7D70C9, 0xFF9CA5E6),
                    ),
                  ),
                  title: Text(
                    "Primary Bank",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
