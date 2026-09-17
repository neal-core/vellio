import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:vellio/components/input_field.dart';
import 'package:vellio/components/ln_snackbar.dart';
import 'package:vellio/components/select_field.dart';
import 'package:vellio/components/submit_button.dart';
import 'package:vellio/data/transaction_data.dart';

enum TransactionType { income, expense }

// List<Map<String, dynamic>> categories = [
//   {
//     'id': 'income',
//     'name': 'Income',
//     'items': [
//       'Salary & Wages',
//       'Freelance & Client Work',
//       'Transfers Received',
//       'Investments & Yields',
//       'Gifts & Bonuses',
//       'Refunds & Reversals',
//     ],
//   },
//   {
//     'id': 'expense',
//     'name': 'Expense',
//     'items': [
//       'Food & Dining',
//       'Airtime & Data',
//       'Transportation',
//       'Bills & Utilities',
//       'Shopping & Gear',
//       'Transfer & Remittance',
//       'Tech & Digital Services',
//     ],
//   },
// ];

final List<String> months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

// void transactionModal(BuildContext ctx, TransactionType transactionType, Function(Map<String, dynamic>) saveFn) {
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//   late String title = "";
//   late double amount = 0.0;
//   late String titleComp = transactionType == TransactionType.expense
//       ? "Expense"
//       : "Income";
//   List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
//   showDialog(
//     context: ctx,
//     barrierDismissible: true,
//     builder: (BuildContext context) {
//       return StatefulBuilder(
//         builder: (BuildContext context, StateSetter setDialogState) {
//           final bool isDark = Theme.of(context).brightness == Brightness.dark;
//           bool successConditioner(
//             dynamic inp, [
//             int? length,
//             double? minAmount,
//           ]) {
//             if (inp is String) {
//               return inp.isNotEmpty && inp.length >= (length ?? 4);
//             } else if (inp is int || inp is double) {
//               return inp >= (minAmount ?? 0.0);
//             }
//             return false;
//           }
//
//           return Dialog(
//             backgroundColor: isDark ? Color(0xFF1A1D2E) : Color(0xFFF6F6FA),
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Add New $titleComp",
//                     style: Theme.of(context).textTheme.titleLarge,
//                   ),
//                   const SizedBox(height: 20),
//                   LNInput(
//                     hintText: "e.g. Airtime",
//                     labelText: "Title",
//                     keyboardType: TextInputType.text,
//                     textController: titleController,
//                     changeFn: (String value) {
//                       setDialogState(() {
//                         title = value;
//                       });
//                     },
//                     successCondition: successConditioner(title, 4),
//                     errorText: "Please input a valid title",
//                     capitalization: TextCapitalization.words,
//                   ),
//                   const SizedBox(height: 16),
//                   LNInput(
//                     hintText: "e.g. 1500",
//                     labelText: "Amount",
//                     keyboardType: TextInputType.numberWithOptions(
//                       decimal: true,
//                     ),
//                     textController: amountController,
//                     changeFn: (String value) {
//                       setDialogState(() {
//                         amount = double.parse(value);
//                       });
//                     },
//                     successCondition: successConditioner(amount, null, 500.00),
//                     errorText: "Invalid amount entered. Min. amount is ₦500",
//                     prefixText: '₦ ',
//                     prefixCol: Theme.of(context).textTheme.titleMedium?.color,
//                     inputFormatters: [
//                       FilteringTextInputFormatter.allow(
//                         RegExp(r'^\d{0,6}\.?\d{0,2}'),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 24),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 56,
//                     child: LNSubmitButton(
//                       submit: () {
//                         final DateTime currentTime = DateTime.now();
//                         String fmtTime = DateFormat("hh:mm a").format(currentTime);
//                         final Map<String, dynamic> transactionMap = {
//                           'title': title,
//                           'amount': amount,
//                           'isDebit': transactionType == TransactionType.expense,
//                           'time': "${months[currentTime.month - 1]} ${currentTime.day}, ${currentTime.year}, $fmtTime"
//                         };
//                         saveFn(transactionMap);
//                         Navigator.pop(context);
//                         lnSnackBar(context, Icons.check_circle_outline, Color(0xFF9AA4FF), 6);
//                       },
//                       submitReq:
//                           (successConditioner(title, 4) &&
//                           successConditioner(amount, null, 500.00)),
//                       btnTxt: "Save $titleComp",
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     },
//   );
// }

void transactionModal(
  BuildContext context,
  TransactionType transactionType,
  Function(Map<String, dynamic>) saveFn,
) {
  final TextEditingController titleController = TextEditingController();
  late String title = "";
  final TextEditingController amountController = TextEditingController();
  late double amount = 0.0;
  String titleComp = transactionType == TransactionType.expense
      ? "Expense"
      : "Income";
  final incomeCat = categories.firstWhere(
    (cat) => cat['id'] == 'income',
  )['items'];
  final List<String> expenses = [];
  expSet(expenses);
  String? selectedCategory;
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "LN Barrier",
    transitionDuration: const Duration(milliseconds: 700),
    pageBuilder: (context, animation, secondaryAnimation) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setDialogState) {
          bool isDark = Theme.of(context).brightness == Brightness.dark;
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

          ;
          return Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(24.0),
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1A1D2E)
                      : const Color(0xFFF6F6FA),
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add new $titleComp",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 20),
                    LNInput(
                      hintText: "e.g. Groceries",
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
                      successCondition: successConditioner(
                        amount,
                        null,
                        500.00,
                      ),
                      errorText:
                          "Invalid amount entered. Min. amount is 500.00",
                      prefixText: '₦ ',
                      prefixCol: Theme.of(context).textTheme.titleMedium?.color,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d{0,6}\.?\d{0,2}'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    LNSelect(
                      items: transactionType == TransactionType.expense
                          ? (expenses)
                          : (incomeCat as List<String>),
                      hintText: "Select a category",
                      changeFn: (dynamic value) {
                        setDialogState(() {
                          selectedCategory = value;
                        });
                      },
                      value: selectedCategory,
                    ),
                    const SizedBox(height: 16),
                    LNSubmitButton(
                      submit: () {
                        print("Category: $selectedCategory");
                        final DateTime currentTime = DateTime.now();
                        final formattedDate = DateFormat(
                          "hh:mm a",
                        ).format(currentTime);
                        final Map<String, dynamic> transactionData = {
                          'title': title,
                          'amount': amount,
                          'isDebit': transactionType == TransactionType.expense,
                          'category': expIdLocate(selectedCategory!),
                          'time':
                              "${months[currentTime.month - 1]} ${currentTime.day}, ${currentTime.year}, $formattedDate",
                        };
                        saveFn(transactionData);
                        Navigator.pop(context);
                        lnSnackBar(
                          context,
                          Icons.check_circle_outline,
                          Color(0xFF9AA4FF),
                          5,
                        );
                      },
                      submitReq:
                          (successConditioner(title, 4) &&
                          successConditioner(amount, null, 500.00) &&
                          successConditioner(selectedCategory, 2)),
                      btnTxt: "Save $titleComp",
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
    transitionBuilder:
        (BuildContext context, animation, secondaryAnimation, child) {
          final slideIn = Tween<Offset>(
            begin: Offset(0.0, 0.7),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeOutCubic));
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: animation.drive(slideIn),
              child: child,
            ),
          );
        },
  );
}
