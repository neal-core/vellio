import 'package:flutter/material.dart';
import 'package:vellio/components/transaction_dialog.dart';

class TransactionCard extends StatelessWidget {
  final String title;
  final String amount;
  final String category;
  final String time;
  final TransactionType transactionType;
  const TransactionCard({
    super.key,
    required this.title,
    required this.amount,
    required this.category,
    required this.time,
    required this.transactionType,
  });
  @override
  Widget build(BuildContext context) {
    final bool isDebit = transactionType == TransactionType.expense
        ? true
        : false;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE8EAF6),
          borderRadius: BorderRadius.circular(16),
          border: isDark
              ? null
              : Border.all(color: const Color(0xFFA9AABC), width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDebit
                    ? const Color(0xFF450A0A)
                    : const Color(0xFF064E3B),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isDebit ? Icons.arrow_outward : Icons.arrow_downward,
                color: isDebit
                    ? const Color(0xFFF87171)
                    : const Color(0xFF34D399),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    category,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 12,
                      color: isDark
                          ? Color(0xFFD3CBCB)
                          : Theme.of(context).textTheme.labelSmall?.color,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    time,
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(fontSize: 11),
                  ),
                ],
              ),
            ),
            Text(
              amount,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isDebit
                    ? Theme.of(context).textTheme.titleMedium?.color
                    : Color(0xFF34D399),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
