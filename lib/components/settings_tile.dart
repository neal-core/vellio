import 'package:flutter/material.dart';
import 'package:vellio/services/color_manager.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailingWidget;
  final bool? trailingValue;
  final ValueChanged<bool>? trailingFn;
  final VoidCallback submitFn;
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailingWidget,
    this.trailingValue,
    this.trailingFn,
    required this.submitFn,
  });
  @override
  Widget build(BuildContext context) {
    final ColorManager colorManager = ColorManager(context: context);
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: colorManager.themeColSet(0x197D70C9, 0x197D70C9),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Icon(
          icon,
          color: colorManager.themeColSet(0xFF7D70C9, 0xFF9CA5E6),
        ),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      subtitle: Text(
        subtitle ?? "",
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: (trailingValue != null && trailingFn != null)
          ? Switch(
              value: trailingValue ?? false,
              onChanged: trailingFn ?? (val) {},
              trackColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return colorManager.themeColSet(0xFF7D70C9, 0xFF7D70C9);
                }
                return Colors.grey[800];
              }),
            )
          : trailingWidget,
      onTap: submitFn,
    );
  }
}
