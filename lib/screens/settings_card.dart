import 'package:flutter/material.dart';
import 'package:vellio/services/color_manager.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const SettingsCard({super.key, required this.title, required this.children});
  @override
  Widget build(BuildContext context) {
    final ColorManager colorManager = ColorManager(context: context);
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsGeometry.only(left: 4.0),
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
        SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            color: colorManager.themeColSet(0xFFFFFFFF, 0xFF1E293B),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: isDark
                ? [
                    BoxShadow(
                      color: Color(0x04000000),
                      blurRadius: 10,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : null,
            border: isDark ? Border.all(color: Color(0x08FFFFFF)) : null,
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}
