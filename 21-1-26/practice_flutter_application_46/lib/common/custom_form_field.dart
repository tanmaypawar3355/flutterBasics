import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String hintText;
  final bool obsureText;
  final String whichPage;
  final RegExp validationRegExp;
  final Function(String?) onSaved;

  const CustomFormField({
    super.key,
    required this.hintText,
    this.obsureText = false,
    required this.whichPage,
    required this.validationRegExp,
    required this.onSaved,
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
      onSaved: onSaved,
      obscureText: obsureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
