import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vellio/components/forward_arrow.dart';
import 'package:vellio/components/list_modal.dart';
import 'package:vellio/components/settings_modal.dart';
import 'package:vellio/components/settings_tile.dart';
import 'package:vellio/screens/settings_card.dart';
import 'package:vellio/services/bank_services.dart';
import 'package:vellio/services/color_manager.dart';
import 'package:vellio/services/file_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen> {
  final List<Map<String, String>> formats = [
    {'id': 'standard', 'value': 'Standard—e.g. ₦15,000.00'},
    {'id': 'compact', 'value': 'Compact—e.g. ₦15k'},
    {'id': 'international', 'value': 'International—e.g. ₦15,000'},
  ];
  final List<Map<String, dynamic>> themes = [
    {'id': 'light', 'value': 'Light Mode', 'icon': Icons.light_mode_outlined},
    {'id': 'dark', 'value': 'Dark Mode', 'icon': Icons.dark_mode_outlined},
    {'id': 'system', 'value': 'System Mode', 'icon': Icons.laptop_mac_outlined},
  ];
  bool importedAppLockValue = false;
  bool importedPrivacyModeValue = false;
  String importedAppTheme = 'system';
  String importedCurrencyValueFormat = 'standard';
  String importedBank = 'access';
  Future<void> saveSettings() async {
    Map<String, dynamic> data = {
      "appLock": appLockValue,
      "privacyMode": privacyModeValue,
      "currencyValue": currencyFormatValue,
      "appTheme": appTheme,
    };
    final FileManager fileManager = FileManager(
      fileName: "stn-dt",
      keyName: "stn-key",
    );
    await fileManager.writeFile(data, DataTypes.settings);
  }

  late bool appLockValue = importedAppLockValue;
  late bool privacyModeValue = importedPrivacyModeValue;
  late String appTheme = importedAppTheme;
  IconData appThemeIcon = Icons.laptop_mac_outlined;
  late String currencyFormatValue = importedCurrencyValueFormat;
  late String selectedBank = importedBank;
  bool get unsavedChanges =>
      appLockValue != importedAppLockValue ||
      privacyModeValue != importedPrivacyModeValue ||
      currencyFormatValue != importedCurrencyValueFormat ||
      selectedBank != importedBank;

  Future<void> retrieveSettings() async {
    final FileManager fileManager = FileManager(
      fileName: "stn-dt",
      keyName: "stn-key",
    );
    final Map<String, dynamic> data = await fileManager.readFile();
    if (data.isNotEmpty) {
      setState(() {
        importedAppLockValue = data['appLock'];
        importedPrivacyModeValue = data['privacyMode'];
        importedCurrencyValueFormat = data['currencyValue'];
        importedAppTheme = data['appTheme'] ?? "system";
        importedBank = data['bank'] ?? 'access';
      });
      print("Data: $data");
    } else {
      setState(() {
        importedPrivacyModeValue = false;
        importedAppLockValue = false;
        importedCurrencyValueFormat = "standard";
        importedAppTheme = "system";
        importedBank = 'access';
      });
      print("No data found");
    }
    setState(() {});
  }

  void resetSettings() {
    setState(() {
      appLockValue = importedAppLockValue;
      privacyModeValue = importedPrivacyModeValue;
      currencyFormatValue = importedCurrencyValueFormat;
      appTheme = importedAppTheme;
      selectedBank = importedBank;
    });
  }

  late final StateSetter bankModalState;
  late final BuildContext modalCtx;
  void startupFn() async {
    await retrieveSettings();
    resetSettings();
  }

  @override
  void initState() {
    super.initState();
    startupFn();
  }

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
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              /*Text(
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
              ),*/
              SettingsCard(
                title: 'Automation',
                children: [
                  SettingsTile(
                    icon: Icons.account_balance,
                    title: 'Primary Bank',
                    subtitle: selectedBank,
                    submitFn: () async {
                      final BankServices bankServices = BankServices();
                      final ListModal listModal = ListModal(
                        modalValue: bankServices.bankList,
                        title: "Select a Primary Bank",
                        ctx: context,
                        defaultValue: selectedBank,
                        pageState: setState,
                        saveSelectedValue: (String importedBankValue) {
                          selectedBank = importedBankValue;
                        },
                        trailingWidget: Icon(
                          Icons.check_circle,
                          color: const Color(0xFF7D70C9),
                        ),
                      );
                      await listModal.showModal();
                    },
                  ),
                ],
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
                    icon: appThemeIcon,
                    title: "App Theme",
                    subtitle: appTheme,
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
                                (BuildContext ctx, StateSetter setThemeState) {
                                  return SafeArea(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 24.0,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "App Theme",
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleMedium,
                                          ),
                                          SizedBox(height: 16),
                                          RadioGroup<String>(
                                            groupValue: appTheme,
                                            onChanged: (String? value) {
                                              setThemeState(() {
                                                appTheme = value!;
                                                final themeLocation = themes
                                                    .firstWhere(
                                                      (theme) =>
                                                          theme['id'] == value,
                                                    );
                                                appThemeIcon =
                                                    themeLocation['icon'];
                                              });
                                              setState(() {
                                                appTheme = value!;
                                                final themeLocation = themes
                                                    .firstWhere(
                                                      (theme) =>
                                                          theme['id'] == value,
                                                    );
                                                appThemeIcon =
                                                    themeLocation['icon'];
                                              });
                                              Navigator.pop(ctx);
                                            },
                                            child: Column(
                                              children: [
                                                ...themes.map((theme) {
                                                  return RadioListTile<String>(
                                                    value: theme['id']!,
                                                    title: Text(
                                                      theme['value']!,
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
                    trailingWidget: forwardArrow,
                  ),
                  Divider(height: 1, color: Color(0x4C676767)),
                  SettingsTile(
                    icon: Icons.payment_outlined,
                    title: "Currency Format",
                    subtitle: currencyFormatValue,
                    trailingWidget: forwardArrow,
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
                      resetSettings();
                    },
                    child: Text(
                      "Discard",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 8),
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
                    onPressed: () async {
                      await saveSettings();
                      appLockValue = importedAppLockValue;
                      privacyModeValue = importedPrivacyModeValue;
                      currencyFormatValue = importedCurrencyValueFormat;
                      if (kDebugMode) {
                        print("Saved data");
                      }
                    },
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
