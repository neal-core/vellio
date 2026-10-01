import 'package:flutter/material.dart';

class ColorManager {
  final BuildContext _context;
  const ColorManager({required this._context});
  Color themeColSet(int lightCol, int darkCol) {
    bool isDark = Theme.of(_context).brightness == Brightness.dark;
    return isDark ? Color(darkCol) : Color(lightCol);
  }
}
