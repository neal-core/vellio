import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NameInput extends StatefulWidget {
  const NameInput({super.key});
  @override
  State<NameInput> createState() => _NameState();
}

class _NameState extends State<NameInput> {
  final TextEditingController _nameController = TextEditingController();
  late String finalName = "";
  void NameSaver(String name) {
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
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: (MediaQuery.of(context).size.height * 0.15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Let's get to know you",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        "What should we call you throughout the app?",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.15,
                  alignment: AlignmentGeometry.center,
                  decoration: BoxDecoration(
                    color: Color(0xFF545EA6),
                    borderRadius: BorderRadius.circular(18.0),
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
                    border: Border.all(
                      color: const Color(0xFF6E75C3),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: AlignmentGeometry.centerLeft,
                          child: Text(
                            "Name",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        TextField(
                          controller: _nameController,
                          onChanged: NameSaver,
                          textCapitalization: TextCapitalization.words,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z\s\'\-]{1,30}$"))
                          ],
                          style: Theme.of(context).textTheme.labelLarge,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: "e.g. Net Anderson",
                            hintStyle: Theme.of(context).textTheme.labelSmall
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 75,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: finalName.isNotEmpty ? () => print("Name inputted") : null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Continue",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
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
