import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final String hintText;
  final RegExp validationRegExp;
  final bool obscureText;
  final Function(String?) onSaved;
  const CustomFormField({
    super.key,
    required this.hintText,
    required this.validationRegExp,
    this.obscureText = false,
    required this.onSaved,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (widget.validationRegExp.hasMatch(value!)) {
          return null;
        }

        if (widget.hintText == "Email") {
          return "Enter a valid email address \n (Ex. name@example.com).";
        }

        if (widget.hintText == "Password") {
          return "Enter a valid password (Contains atleast one uppercase\nletter, one lowercase letter one number and one\nspecial characte).";
        }
      },
      onSaved: widget.onSaved,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: widget.hintText,
      ),
    );
  }
}
