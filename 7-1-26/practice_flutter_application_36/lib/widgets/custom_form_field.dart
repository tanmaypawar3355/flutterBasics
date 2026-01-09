import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String hintText;
  final double height;
  final void Function(String?) onSaved;
  final RegExp validationRegExp;
  final bool ObscureText;
  const CustomFormField({
    super.key,
    required this.hintText,
    required this.height,
    required this.onSaved,
    required this.validationRegExp,
    this.ObscureText = false,
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
        obscureText: ObscureText,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
