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
        if (widget.hintText == "Name") {
          return "Please enter a valid name\n(e.g., Name)";
        }
        if (widget.hintText == "Email") {
          return "Please enter a valid email\n(e.g., name@example.com)";
        }

        if (widget.hintText == "Password") {
          return "Please enter a valid password\nInclude at least one uppercase letter, one number\nand one special character (e.g., !, @, #)";
        }
        return null;
      },
      onSaved: widget.onSaved,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
