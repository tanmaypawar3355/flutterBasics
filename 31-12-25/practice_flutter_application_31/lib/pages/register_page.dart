import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_31/const.dart';
import 'package:practice_flutter_application_31/services/alert_service.dart';
import 'package:practice_flutter_application_31/services/auth_service.dart';
import 'package:practice_flutter_application_31/services/media_service.dart';
import 'package:practice_flutter_application_31/services/navigation_service.dart';
import 'package:practice_flutter_application_31/widgets/custom_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registrationKey = GlobalKey();
  File? _selectedImage;

  final GetIt _getIt = GetIt.instance;

  late MediaService _mediaService;
  late AuthService _authService;
  late NavigationService _navigationService;
  late AlertService _alertService;

  String? name, email, password;

  @override
  void initState() {
    super.initState();
    _mediaService = _getIt.get<MediaService>();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
    _alertService = _getIt.get<AlertService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false, body: _buildUI());
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerText(),
            _registerForm(),
            _registerButton(),
            _logInLink(),
          ],
        ),
      ),
    );
  }

  Widget _headerText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's, get going!",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        Text(
          "Register an account using the form below",
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _registerForm() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.60,
      // color: Colors.grey,
      child: Form(
        key: _registrationKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _pfpSelectionField(),
            CustomFormField(
              hintText: "Name",
              height: MediaQuery.sizeOf(context).height * 0.10,
              validationRegEx: NAME_VALIDATION_REGEX,
              onSaved: (value) {
                setState(() {
                  // email = value;
                });
              },
            ),
            CustomFormField(
              hintText: "Email",
              height: MediaQuery.sizeOf(context).height * 0.10,
              validationRegEx: EMAIL_VALIDATION_REGEX,
              onSaved: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            CustomFormField(
              hintText: "Password",
              height: MediaQuery.sizeOf(context).height * 0.10,
              obscureText: true,
              validationRegEx: PASSWORD_VALIDATION_REGEX,
              onSaved: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _pfpSelectionField() {
    return GestureDetector(
      onTap: () async {
        File? image = await _mediaService.imagePicker();
        if (image != null) {
          setState(() {
            _selectedImage = image;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 182, 182, 182),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: MediaQuery.sizeOf(context).width * 0.15,
          backgroundImage: _selectedImage != null
              ? FileImage(_selectedImage!)
              : NetworkImage(PLACEHOLDER_TR) as ImageProvider,
        ),
      ),
    );
  }

  Widget _registerButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        color: Theme.of(context).primaryColor,
        onPressed: () async {
          if (_registrationKey.currentState?.validate() ?? false) {
            _registrationKey.currentState!.save();
            bool result = await _authService.registerUser(
              email!.trim(),
              password!.trim(),
            );
            if (result) {
              print(result);
              _alertService.showToast(
                text: "Registered succesfully!",
                icon: Icons.check,
              );
              _navigationService.goBack();
            } else {
              _alertService.showToast(
                text: "Failed to register new user",
                icon: Icons.error,
              );
            }
            print("--------------------$result----------------");
          }
        },
        child: Text("Register", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _logInLink() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("Already have an account? "),
          GestureDetector(
            onTap: () {
              _navigationService.pushNamed("/login");
            },
            child: Text(
              "Log in",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
