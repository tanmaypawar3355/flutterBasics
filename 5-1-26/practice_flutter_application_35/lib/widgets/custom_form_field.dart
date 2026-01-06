import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String hintText;
  final double height;
  final Function(String?) onSaved;
  final RegExp validationRegExp;
  final bool obscureText;
  const CustomFormField({
    super.key,
    required this.hintText,
    required this.height,
    required this.onSaved,
    required this.validationRegExp,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.10,
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
