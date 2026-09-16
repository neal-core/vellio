import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:vellio/components/input_field.dart';
import 'package:vellio/components/ln_snackbar.dart';
import 'package:vellio/components/submit_button.dart';

enum TransactionType { income, expense }

void transactionModal(BuildContext ctx, TransactionType transactionType, Function(Map<String, dynamic>) saveFn) {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  late String title = "";
  late double amount = 0.0;
  late String titleComp = transactionType == TransactionType.expense
      ? "Expense"
      : "Income";
  List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  showDialog(
    context: ctx,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setDialogState) {
          final bool isDark = Theme.of(context).brightness == Brightness.dark;
          bool successConditioner(
            dynamic inp, [
            int? length,
            double? minAmount,
          ]) {
            if (inp is String) {
              return inp.isNotEmpty && inp.length >= (length ?? 4);
            } else if (inp is int || inp is double) {
              return inp >= (minAmount ?? 0.0);
            }
            return false;
          }

          return Dialog(
            backgroundColor: isDark ? Color(0xFF1A1D2E) : Color(0xFFF6F6FA),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add New $titleComp",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  LNInput(
                    hintText: "e.g. Airtime",
                    labelText: "Title",
                    keyboardType: TextInputType.text,
                    textController: titleController,
                    changeFn: (String value) {
                      setDialogState(() {
                        title = value;
                      });
                    },
                    successCondition: successConditioner(title, 4),
                    errorText: "Please input a valid title",
                    capitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: 16),
                  LNInput(
                    hintText: "e.g. 1500",
                    labelText: "Amount",
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textController: amountController,
                    changeFn: (String value) {
                      setDialogState(() {
                        amount = double.parse(value);
                      });
                    },
                    successCondition: successConditioner(amount, null, 500.00),
                    errorText: "Invalid amount entered. Min. amount is ₦500",
                    prefixText: '₦ ',
                    prefixCol: Theme.of(context).textTheme.titleMedium?.color,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d{0,6}\.?\d{0,2}'),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: LNSubmitButton(
                      submit: () {
                        final DateTime currentTime = DateTime.now();
                        String fmtTime = DateFormat("hh:mm a").format(currentTime);
                        final Map<String, dynamic> transactionMap = {
                          'title': title,
                          'amount': amount,
                          'isDebit': transactionType == TransactionType.expense,
                          'time': "${months[currentTime.month - 1]} ${currentTime.day}, ${currentTime.year}, $fmtTime"
                        };
                        saveFn(transactionMap);
                        Navigator.pop(context);
                        lnSnackBar(context, Icons.check_circle_outline, Color(0xFF9AA4FF), 6);
                      },
                      submitReq:
                          (successConditioner(title, 4) &&
                          successConditioner(amount, null, 500.00)),
                      btnTxt: "Save $titleComp",
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
}
