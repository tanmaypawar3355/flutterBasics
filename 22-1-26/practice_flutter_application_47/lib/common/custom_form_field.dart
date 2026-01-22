import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final RegExp validationRegExp;
  final String whichPage;
  final Function(String?) onSaved;

  const CustomFormField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    required this.validationRegExp,
    required this.onSaved,
    required this.whichPage,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (validationRegExp.hasMatch(value!)) {
          return null;
        } else {
          if (hintText == "Email" && whichPage == "LoginPage") {
            return "Enter a valid email address";
          }
          if (hintText == "Password" && whichPage == "LoginPage") {
            return "Enter a valid password";
          }

          if (hintText == "Name" && whichPage == "RegisterPage") {
            return "Enter a valid name (ex. Name)";
          }

          if (hintText == "Email" && whichPage == "RegisterPage") {
            return "Enter a valid email address\n(ex. name@example.com)";
          }

          if (hintText == "Password" && whichPage == "RegisterPage") {
            return "Enter a valid password\nPassword must include one uppercase letter, one\nlowecase letter, one number, & one special character";
          }
          return null;
        }
      },
      obscureText: obscureText,
      onSaved: onSaved,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
