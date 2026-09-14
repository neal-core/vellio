import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vellio/components/input_field.dart';
import 'package:vellio/components/submit_button.dart';
import 'package:vellio/screens/onboarding.dart';
import 'package:vellio/services/onboarding_data_manager.dart';

class NameInput extends StatefulWidget {
  const NameInput({super.key});
  @override
  State<NameInput> createState() => _NameState();
}

class _NameState extends State<NameInput> {
  final TextEditingController _nameController = TextEditingController();
  late String finalName = "";
  void nameAlloc(String name) {
    setState(() {
      finalName = _nameController.text;
    });
  }

  Future<void> obEditor() async {
    final OnboardingDataManager manager = OnboardingDataManager();
    await manager.deleteFile();
  }

  @override
  Widget build(BuildContext context) {
    late bool successCondition =
        finalName.isNotEmpty && finalName.trim().length >= 4;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDark
                                ? const Color(0xFF27214F)
                                : const Color(0xFFE8E9F3),
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFFA1A4EA)
                                  : const Color(0xFFC7C9E5),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.person_4,
                            size: 50,
                            color: isDark
                                ? const Color(0xFF433E75)
                                : const Color(0xFF9EA1CA),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF38385C)
                                  : const Color(0xFFD6D8EE),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add,
                              size: 16,
                              color: isDark
                                  ? const Color(0XFFA1A4EA)
                                  : const Color(0xFF6B6E9C),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Let's get to know you?",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            "What should we call you throughout the app?",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                LNInput(
                  hintText: "e.g. Net Anderson",
                  labelText: "Name",
                  keyboardType: TextInputType.name,
                  textController: _nameController,
                  changeFn: nameAlloc,
                  successCondition: successCondition,
                  errorText: "Please input a valid name",
                  capitalization: TextCapitalization.words,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r"^[a-zA-Z\s\'\-]{1,30}$"),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 75,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: LNSubmitButton(
                      submit: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Onboarding(name: finalName),
                          ),
                        );
                      },
                      submitReq:
                          finalName.isNotEmpty && finalName.trim().length >= 4,
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
