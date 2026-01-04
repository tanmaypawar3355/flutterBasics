import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String hintText;
  final double height;
  final bool obscureText;
  final Function(String?) onSaved;
  final RegExp validationRegExp;

  const CustomFormField({
    super.key,
    required this.hintText,
    required this.height,
    this.obscureText = false,
    required this.onSaved,
    required this.validationRegExp,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        validator: (value) {
          if (validationRegExp.hasMatch(value!)) {
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
