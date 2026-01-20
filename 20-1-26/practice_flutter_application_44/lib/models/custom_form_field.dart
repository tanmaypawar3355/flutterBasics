import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String hinteText;
  final bool obscureText;
  final RegExp validationRegExp;
  final String forWhichPage;
  final Function(String?) onSaved;
  const CustomFormField({
    super.key,
    required this.hinteText,
    required this.validationRegExp,
    this.obscureText = false,
    required this.onSaved,
    required this.forWhichPage,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (validationRegExp.hasMatch(value!)) {
          return null;
        }

        if (forWhichPage == "LoginPage" && hinteText == "Email") {
          return "Enter a valid email address";
        }

        if (forWhichPage == "LoginPage" && hinteText == "Password") {
          return "Enter a valid password";
        }

        if (forWhichPage == "RegisterPage" && hinteText == "Name") {
          return "Enter a valid name\n(Ex. Name)";
        }

        if (forWhichPage == "RegisterPage" && hinteText == "Email") {
          return "Enter a valid email address\n(Ex. name@example.com)";
        }

        if (forWhichPage == "RegisterPage" && hinteText == "Password") {
          return "Enter a valid password\nPassword must contain atleast one uppercase\nletter, one lowercase letter, one number & one\nspecial charater";
        }
        return null;
      },
      onSaved: onSaved,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hinteText,
      ),
    );
  }
}
