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
                        border: item['state'] == 'selected' ? Border.all(
                            color: isDark == true ? Color(0xE22734CD) : Color(0xDB681340),
                            width: 1.5
                        ) : null,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            isDark == true ? Color(0xFF545EA6) : Color(0xDBE12B8D),
                            isDark == true ? Color(0xFF2F3150) : Color(0xDB5A0F37)
                          ]
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isDark == true ? Color(0xE2202361) : Color(0xDB5A1037),
                            blurRadius: 12,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: const Color(0x59000000),
                            blurRadius: 8,
                            offset: const Offset(0,4)
                          )
                        ]
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(18),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(18),
                          onTap: () => {
                            setState(() {
                              item['state'] = item['state'] == 'selected' ? 'unselected' : 'selected';
                              selectedItems = item['state'] == 'selected' ? selectedItems + 1 : selectedItems - 1;
                            })
                          },
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 3,
                              children: [
                                Icon(
                                  item['icon'], size: 35.0, color: const Color(0xFFCCD2FF),
                                ),
                                Text("${item['name']} ${item['state'] == 'selected' ? '✔️' : '✖️'}", style: Theme.of(context).textTheme.titleMedium,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // child: Card.filled(
                    //   child: InkWell(
                    //     onTap: () {
                    //       setState(() {
                    //         item['state'] = item['state'] == 'unselected'
                    //             ? 'selected'
                    //             : 'unselected';
                    //         selectedItems = item['state'] == 'selected'
                    //             ? selectedItems += 1
                    //             : selectedItems -= 1;
                    //       });
                    //     },
                    //     child: Center(
                    //       child: Column(
                    //         mainAxisSize: MainAxisSize.max,
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         spacing: 3,
                    //         children: [
                    //           Icon(
                    //             item["icon"],
                    //             size: 35.0,
                    //             color: Color(0xFFB1B8ED),
                    //           ),
                    //           Text(
                    //             "${item['name']} ${item['state'] == 'selected' ? '✔️' : '✖️'}",
                    //             style: Theme.of(context).textTheme.titleMedium,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  );
                }).toList(),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 35.0, 16.0, 5.0),
                  child: ElevatedButton(
                    onPressed: selectedItems >= 3 ? () => Navigator.pushNamed(context, '/trackmethod') : null,
                    child: Text("Save and Continue", style: TextStyle(color: Color(0xFFB1B8ED)),),
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
