import 'package:flutter/material.dart';

void lnSnackBar(
  BuildContext ctx,
  IconData icon,
  Color iconColor,
  int duration,
) {
  bool isDark = Theme.of(ctx).brightness == Brightness.dark;
  ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      backgroundColor: isDark
          ? const Color(0xFF2F3150)
          : const Color(0xFFE8EAF6),
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.down,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      duration: Duration(seconds: duration),
      content: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 12),
          Text(
            "Budget saved successfully!",
            style: Theme.of(ctx).textTheme.titleSmall?.copyWith(
              // color: const Color(0xFFCCD2FF),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
  );
}
