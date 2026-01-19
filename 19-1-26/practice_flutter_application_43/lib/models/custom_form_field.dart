import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final RegExp validationRegExp;
  final Function(String?) onSaved;
  const CustomFormField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    required this.validationRegExp,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (validationRegExp.hasMatch(value!)) {
          return null;
        }

        if (hintText == "Name") {
          return "Enter a valid name\n(Ex. Name)";
        }

        if (hintText == "Email") {
          return "Enter a valid email address\n(Ex. name@example.com)";
        }

        if (hintText == "Password") {
          return "Enter a valid password\nPassword must include one uppercase letter,\none lowercase letter, one number, and one\nspecial character ";
        }
        return null;
      },
      onSaved: onSaved,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
