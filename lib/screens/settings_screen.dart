import 'package:flutter/material.dart';
import 'package:vellio/components/settings_tile.dart';
import 'package:vellio/screens/settings_card.dart';
import 'package:vellio/services/color_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen> {
  late bool appLockValue = false;
  late bool privacyModeValue = false;
  final List<Map<String, String>> formats = [
    {'id': 'standard', 'value': 'Standard—e.g. ₦15,000.00'},
    {'id': 'compact', 'value': 'Compact—e.g. ₦15k'},
    {'id': 'international', 'value': 'International—e.g. ₦15,000'},
  ];
  String currencyFormatValue = "standard";
  late bool unsavedChanges = false;
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
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              Text(
                "Automation",
                style: Theme.of(context).textTheme.titleMedium,
              ),
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
                          color: colorManager.themeColSet(
                            0x197D70C9,
                            0x197D70C9,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Icon(
                          Icons.account_balance,
                          color: colorManager.themeColSet(
                            0xFF7D70C9,
                            0xFF9CA5E6,
                          ),
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
              SizedBox(height: 32),
              Text(
                "Security & Privacy",
                style: Theme.of(context).textTheme.titleMedium,
              ),
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
                    SettingsTile(
                      icon: Icons.lock,
                      title: "App Lock",
                      subtitle: "Require PIN or fingerprint to open",
                      submitFn: () {},
                      /*trailingWidget: Switch(
                    value: false,
                    onChanged: (val) {
                      s
                    },
                    trackColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return colorManager.themeColSet(0xFF7D70C9, 0xFF7D70C9);
                      }
                      return Colors.grey[800];
                    }),
                  ),*/
                      trailingValue: appLockValue,
                      trailingFn: (val) => setState(() {
                        appLockValue = val;
                      }),
                    ),
                    Divider(height: 1, color: Color(0x4C676767)),
                    SettingsTile(
                      icon: Icons.visibility_off_outlined,
                      title: "Privacy Mode",
                      subtitle: "Blur total balance on startup",
                      submitFn: () {},
                      trailingValue: privacyModeValue,
                      trailingFn: (val) => setState(() {
                        privacyModeValue = val;
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              SettingsCard(
                title: "Appearance & Formatting",
                children: [
                  SettingsTile(
                    icon: isDark
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined,
                    title: "App Theme",
                    subtitle: isDark ? "Dark Mode" : "Light Mode",
                    submitFn: () {},
                    trailingValue: isDark,
                    trailingFn: (val) => setState(() {
                      isDark = val;
                    }),
                  ),
                  Divider(height: 1, color: Color(0x4C676767)),
                  SettingsTile(
                    icon: Icons.payment_outlined,
                    title: "Currency Format",
                    subtitle: currencyFormatValue,
                    submitFn: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Theme.of(context).cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder:
                                (
                                  BuildContext ctx,
                                  StateSetter setCurrencyState,
                                ) {
                                  return SafeArea(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 24.0,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Currency Format",
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleMedium,
                                          ),
                                          SizedBox(height: 16),
                                          RadioGroup<String>(
                                            groupValue: currencyFormatValue,
                                            onChanged: (String? value) {
                                              setCurrencyState(() {
                                                currencyFormatValue = value!;
                                              });
                                              setState(() {
                                                currencyFormatValue = value!;
                                              });
                                              unsavedChanges = !unsavedChanges;
                                              Navigator.pop(ctx);
                                            },
                                            child: Column(
                                              children: [
                                                ...formats.map((format) {
                                                  return RadioListTile<String>(
                                                    value: format['id']!,
                                                    title: Text(
                                                      format['value']!,
                                                      style: Theme.of(
                                                        context,
                                                      ).textTheme.bodyLarge,
                                                    ),
                                                    activeColor: colorManager
                                                        .themeColSet(
                                                          0xFF7D70C9,
                                                          0xFF7D70C9,
                                                        ),
                                                  );
                                                }),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            top: unsavedChanges ? 12 : -100,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                color: colorManager.themeColSet(0xFFFFFFFF, 0xFF111827),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: colorManager.themeColSet(0x337D70C9, 0x667D70C9),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: colorManager.themeColSet(0x14000000, 0X66000000),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Careful—unsaved changes!",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(width: 8),
                  TextButton(
                    style: Theme.of(context).elevatedButtonTheme.style
                        ?.copyWith(
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.redAccent,
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                    onPressed: () {
                      setState(() {
                        unsavedChanges = false;
                      });
                    },
                    child: Text(
                      "Discard",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 8,),
                  TextButton(
                    style: Theme.of(context).elevatedButtonTheme.style
                        ?.copyWith(
                          backgroundColor: WidgetStatePropertyAll(
                            Color(0xFF10B981),
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                    onPressed: () {},
                    child: Text(
                      "Save",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
