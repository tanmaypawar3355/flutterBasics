import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final double height;
  final String hintText;
  final bool obscureText;
  final RegExp validationRegExp;
  final Function(String?) onSaved;
  const CustomFormField({
    super.key,
    required this.height,
    required this.hintText,
    this.obscureText = false,
    required this.validationRegExp,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        validator: (newValue) {
          if (validationRegExp.hasMatch(newValue!)) {
            return null;
          }
          return "Enter a valid ${hintText.toLowerCase()}";
        },
        onSaved: onSaved,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
