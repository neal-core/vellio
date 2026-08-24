import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BudgetScreen extends StatefulWidget {
  final List<String> selectedCategories;
  final String selectedMethod;
  const BudgetScreen({
    super.key,
    required this.selectedCategories,
    required this.selectedMethod,
  });
  @override
  State<BudgetScreen> createState() => _BudgetState();
}

class _BudgetState extends State<BudgetScreen> {
  final TextEditingController _budgetControl = TextEditingController();
  late String descriptor = "";
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark
        ? true
        : false;
    return SafeArea(
      top: true,
      bottom: false,
      left: true,
      right: true,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Scaffold(
          body: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Set Your Starting Balance",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        "Enter your current balance. We'll use this baseline to calculate your daily running funds entirely offline.",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF331D3E),
                        spreadRadius: 8.0,
                        blurRadius: 14.0,
                      ),
                      BoxShadow(
                        color: const Color(0xFF403845),
                        offset: Offset(2, 2),
                        spreadRadius: 10.0,
                        blurRadius: 15.0,
                      ),
                      BoxShadow(
                        color: const Color(0xE8342A51),
                        offset: Offset(2, 5),
                        spreadRadius: 12.0,
                        blurRadius: 16.0,
                      ),
                    ],
                    border: Border.all(
                      color: const Color(0xE2283081),
                      width: 0.5,
                    ),
                    color: isDark
                        ? const Color(0xFF545EA6)
                        : const Color(0xFF22CF20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Balance",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextField(
                        controller: _budgetControl,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d{0,7}\.?\d{0,2}'),
                          ),
                        ],
                        decoration: InputDecoration(
                          prefixText: "₦ ",
                          prefixStyle: Theme.of(context).textTheme.titleMedium,
                          hintText: "0.00",
                          hintStyle: TextStyle(color: Color(0xFF535252)),
                        ),
                      ),
                      if (descriptor.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.error_outline,
                                size: 16,
                                color: Color(0xFFBA1A1A),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  descriptor,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!.copyWith(
                                    color: const Color(0xFFBA1A1A),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: double.infinity, height: 20),
              SizedBox(
                width: double.infinity,
                height: 75,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_budgetControl.text != "") {
                          descriptor = "";
                          if (double.tryParse(_budgetControl.text)! >= 500.00) {
                            descriptor = "";
                          } else {
                            descriptor = "Amount must be at least ₦500.00";
                          }
                        } else {
                          descriptor = "No amount specified";
                        }
                      });
                    },
                    child: Text(
                      "Continue",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
