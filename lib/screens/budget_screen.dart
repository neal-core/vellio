import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vellio/components/input_field.dart';
import 'package:vellio/components/submit_button.dart';
import 'package:vellio/services/onboarding_data_manager.dart';

class BudgetScreen extends StatefulWidget {
  final String name;
  final List<String> selectedCategories;
  final String selectedMethod;
  const BudgetScreen({
    super.key,
    required this.name,
    required this.selectedCategories,
    required this.selectedMethod,
  });
  @override
  State<BudgetScreen> createState() => _BudgetState();
}

class _BudgetState extends State<BudgetScreen> {
  final TextEditingController _budgetControl = TextEditingController();
  late String finalBudget = "";

  void budgetAlloc(String budgetInput) {
    setState(() {
      finalBudget = budgetInput;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void storeOBData(double budget) async {
    OnboardingDataManager obs = OnboardingDataManager();
    await obs.writeFile(
      name: widget.name,
      categories: widget.selectedCategories,
      trackMethod: widget.selectedMethod,
      budget: budget,
    );
  }

  @override
  Widget build(BuildContext context) {
    late bool successCondition =
        finalBudget.isNotEmpty &&
        finalBudget.trim().length >= 3 &&
        double.parse(finalBudget) >= 500.00;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentGeometry.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Set your monthly budget",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        "How much are you working with for this month?",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                LNInput(
                  hintText: "0.00",
                  labelText: "Starting Amount",
                  prefixText: "₦ ",
                  prefixCol: Theme.of(context).textTheme.titleMedium?.color,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r"^\d{0,7}\.?\d{0,2}"),
                    ),
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  textController: _budgetControl,
                  changeFn: budgetAlloc,
                  successCondition: successCondition,
                  errorText: "Invalid amount entered. Min. amount is ₦500.00",
                ),
                SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: LNSubmitButton(
                    submit: () async {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: const Color(0xFF2F3150),
                          elevation: 10,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 24,
                          ),
                          behavior: SnackBarBehavior.floating,
                          dismissDirection: DismissDirection.down,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          duration: Duration(seconds: 5),
                          content: Row(
                            children: [
                              const Icon(
                                Icons.check_circle_outline,
                                color: Color(0xFF9AA4FF),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "Budget saved successfully!",
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(
                                      color: const Color(0xFFCCD2FF),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    submitReq: successCondition,
                    btnTxt: "Continue",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
