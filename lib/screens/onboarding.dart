import 'package:flutter/material.dart';
import 'package:vellio/components/submit_button.dart';
import 'package:vellio/data/onboarding_items.dart';
import 'package:vellio/screens/track_method_screen.dart';

class Onboarding extends StatefulWidget {
  final String name;
  const Onboarding({super.key, required this.name});
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int selectedItems = 0;
  List<String> sel = [];
  @override
  void initState() {
    super.initState();
    for (var cat in onboardingItems) {
      if (cat['state'] == 'selected') cat['state'] = 'unselected';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      top: true,
      bottom: false,
      left: true,
      right: true,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
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
                          "Select your Primary Categories ${selectedItems > 3 ? '' : '($selectedItems/3 min)'}",
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
                SizedBox(height: 15),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 8,
                  runSpacing: 8,
                  children: onboardingItems.map((item) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 16,
                      height: 150,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: item['state'] == 'selected'
                              ? Border.all(
                                  color: const Color(0xFF6E75C3),
                                  width: 1.5,
                                )
                              : null,
                          color: isDark
                              ? const Color(0xFF5E65A4)
                              : (item['state'] == 'selected'
                                    ? const Color(0x626E75C3)
                                    : const Color(0xFFE8EAF6)),
                          boxShadow: [
                            BoxShadow(
                              color: isDark
                                  ? const Color(0xFF5E65A4)
                                  : const Color(0xE27F74DD),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                            BoxShadow(
                              color: isDark
                                  ? const Color(0xFF5E65A4)
                                  : const Color(0xB3C3BAD5),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(18),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(18),
                            onTap: () => {
                              setState(() {
                                item['state'] = item['state'] == 'selected'
                                    ? 'unselected'
                                    : 'selected';
                                selectedItems = item['state'] == 'selected'
                                    ? selectedItems + 1
                                    : selectedItems - 1;
                              }),
                            },
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 3,
                                children: [
                                  Icon(
                                    item['icon'],
                                    size: 35.0,
                                    color: Theme.of(
                                      context,
                                    ).textTheme.titleMedium?.color,
                                  ),
                                  Text(
                                    "${item['name']} ${item['state'] == 'selected' ? '✔️' : '✖️'}",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 75,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: LNSubmitButton(
                      submit: () {
                        setState(() {
                          sel.clear();
                          for (var cat in onboardingItems) {
                            if (cat['state'] == 'selected') {
                              sel.add(cat['name']);
                            }
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TrackMethodScreen(
                                name: widget.name,
                                selectedCategories: sel,
                              ),
                            ),
                          );
                        });
                      },
                      submitReq: selectedItems == 3,
                      btnTxt: "Continue",
                    ),
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
