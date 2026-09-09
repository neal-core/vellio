import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vellio/components/submit_button.dart';

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

  @override
  Widget build(BuildContext context) {
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
                            color: const Color(0xFF27214F),
                            border: Border.all(
                              color: const Color(0xFFA1A4EA),
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.person_4,
                            size: 50,
                            color: Color(0xFF433E75),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF38385C),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 16,
                              color: Color(0XFFA1A4EA),
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 5.0,
                  ),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.15,
                  alignment: AlignmentGeometry.center,
                  decoration: BoxDecoration(
                    color: const Color(0XFF545EA6),
                    borderRadius: BorderRadius.circular(18.0),
                    border: Border.all(
                      color: const Color(0xFF6E75C3),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xE2202361),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Color(0X59000000),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        onChanged: nameAlloc,
                        textCapitalization: TextCapitalization.words,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"^[a-zA-Z\s\'\-]{1,30}$"),
                          ),
                        ],
                        style: Theme.of(context).textTheme.labelLarge,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "e.g. Net Anderson",
                          hintStyle: Theme.of(context).textTheme.labelSmall,
                          errorText:
                              finalName.isNotEmpty &&
                                  finalName.trim().length >= 4
                              ? ""
                              : "Please input a valid name",
                          labelText: "Name",
                          labelStyle: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 75,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: LNSubmitButton(
                      submit: () => print("Name Inputted"),
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
