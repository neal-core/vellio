import 'package:flutter/material.dart';

class LNSelect extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final Function(dynamic) changeFn;
  final String? value;
  const LNSelect({
    super.key,
    required this.items,
    required this.hintText,
    required this.changeFn,
    required this.value,
  });
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      width: double.infinity,
      height: 80,
      alignment: AlignmentGeometry.center,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF5E65A4) : const Color(0xFFE8EAF6),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0xFF6E75C3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Category", style: Theme.of(context).textTheme.titleSmall),
          DropdownButton<String>(
            hint: Text(hintText),
            value: value,
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            }).toList(),
            onChanged: changeFn,
            elevation: 4,
            isExpanded: true,
          ),
        ],
      ),
    );
  }
}
