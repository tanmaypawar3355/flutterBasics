import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String hintText;
  final double height;
  final bool obscureText;
  final RegExp validationRegExp;
  final Function(String?) onSaved;
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
          if (value != null && validationRegExp.hasMatch(value)) {
            return null;
          }
          return "Enter a valid ${hintText.toLowerCase()}";
        },

        onSaved: onSaved,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
        ),
      ),
    );
  }
}
