import 'package:flutter/material.dart';
import 'package:vellio/components/onboardingItems.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int selectedItems = 0;
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
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
                        "Select your Primary Categories",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        "Choose the spending categories you track most frequently",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              ),
              Wrap(
                direction: Axis.horizontal,
                spacing: 8,
                runSpacing: 8,
                children: onboardingItems.map((item) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 16,
                    height: 150,
                    child: Card.filled(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            item['state'] = item['state'] == 'unselected'
                                ? 'selected'
                                : 'unselected';
                            selectedItems = item['state'] == 'selected'
                                ? selectedItems += 1
                                : selectedItems -= 1;
                          });
                        },
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 3,
                            children: [
                              Icon(
                                item["icon"],
                                size: 35.0,
                                color: Color(0xFFB1B8ED),
                              ),
                              Text(
                                "${item['name']} ${item['state'] == 'selected' ? '✔️' : '✖️'}",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: FilledButton(
                  onPressed: selectedItems >= 3 ? () => print("Clicked") : null,
                  child: Text(
                    selectedItems > 3
                        ? "Save and Continue"
                        : "3 items min($selectedItems items selected)",
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
