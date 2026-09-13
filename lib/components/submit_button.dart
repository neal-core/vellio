import 'package:flutter/material.dart';

class LNSubmitButton extends StatelessWidget {
  final VoidCallback submit;
  final String btnTxt;
  final bool submitReq;
  const LNSubmitButton({
    super.key,
    required this.submit,
    required this.submitReq,
    required this.btnTxt,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: submitReq ? submit : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(btnTxt, style: Theme.of(context).textTheme.titleMedium),
          SizedBox(width: 10),
          Padding(
            padding: const EdgeInsetsGeometry.only(top: 2),
            child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}
