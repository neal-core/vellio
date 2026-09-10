import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LNInput extends StatelessWidget {
  final String? prefixText;
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final Color? prefixCol;
  final TextEditingController textController;
  final Function(String) changeFn;
  final bool successCondition;
  final String errorText;
  final TextCapitalization? capitalization;
  final List<TextInputFormatter>? inputFormatters;
  const LNInput({
    super.key,
    this.prefixText,
    required this.hintText,
    required this.labelText,
    required this.keyboardType,
    this.prefixCol,
    required this.textController,
    required this.changeFn,
    required this.successCondition,
    required this.errorText,
    this.capitalization,
    this.inputFormatters,
  });
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.15,
      alignment: AlignmentGeometry.center,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF5E65A4) : const Color(0xFFE8EAF6),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0xFF6E75C3), width: 1),
      ),
      child: TextField(
        controller: textController,
        onChanged: changeFn,
        keyboardType: keyboardType,
        textCapitalization: capitalization ?? TextCapitalization.none,
        inputFormatters: inputFormatters ?? [],
        style: Theme.of(context).textTheme.labelLarge,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.labelSmall,
          prefixText: prefixText ?? "",
          prefixStyle: prefixCol != null
              ? Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: prefixCol)
              : null,
          errorText: successCondition ? null : errorText,
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
