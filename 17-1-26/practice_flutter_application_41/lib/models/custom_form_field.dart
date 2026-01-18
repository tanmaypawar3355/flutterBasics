import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String hintText;
  final RegExp validationRegExp;
  final Function(String?) onSaved;
  final bool obscureText;
  const CustomFormField({
    super.key,
    required this.hintText,
    required this.validationRegExp,
    required this.onSaved,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      obscureText: obscureText,
      validator: (value) {
        if (validationRegExp.hasMatch(value!)) {
          return null;
        }
        if (hintText == "Name") {
          return "Please enter a valid name (Ex. Name).";
        }
        if (hintText == "Email") {
          return "Please enter a valid email address\n(Ex. user@example.com).";
        }
        if (hintText == "Password") {
          return "Please enter a valid password.\nPlease include at least one uppercase letter,\none number, and one special character.";
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }
}
