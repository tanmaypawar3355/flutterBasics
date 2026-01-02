import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_32/const.dart';
import 'package:practice_flutter_application_32/services/alert_service.dart';
import 'package:practice_flutter_application_32/services/auth_service.dart';
import 'package:practice_flutter_application_32/services/media_services.dart';
import 'package:practice_flutter_application_32/services/navigation_service.dart';
import 'package:practice_flutter_application_32/widgets/custom_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email, password;

  final GlobalKey<FormState> _registrationFormKey = GlobalKey();
  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  late NavigationService _navigationService;
  late AlertService _alertService;
  late MediaService _mediaService;
  File? _selectedImage;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
    _alertService = _getIt.get<AlertService>();
    _mediaService = _getIt.get<MediaService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: true, body: _buildUI());
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerText(),
            if (!isLoading) _registerForm(),
            if (!isLoading) _registerFormButton(),
            if (!isLoading) _logInLink(),
            if (isLoading)
              Expanded(child: Center(child: CircularProgressIndicator())),
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
          "Let's get going!",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        Text(
          "Register an account using the form below",
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _registerForm() {
    return Container(
      color: Colors.white,
      height: MediaQuery.sizeOf(context).height * 0.65,
      child: Form(
        key: _registrationFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _selectPfp(),
            CustomFormField(
              hintText: "Name",
              height: MediaQuery.sizeOf(context).height * 0.10,
              validationRegExp: NAME_VALIDATION_REGEX,
              onSaved: (value) {
                setState(() {});
              },
            ),
            CustomFormField(
              hintText: "Email",
              height: MediaQuery.sizeOf(context).height * 0.10,
              validationRegExp: EMAIL_VALIDATION_REGEX,
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
              validationRegExp: PASSWORD_VALIDATION_REGEX,
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

  Widget _selectPfp() {
    return GestureDetector(
      onTap: () async {
        print("tapping");
        File? image = await _mediaService.selectImage();
        if (image != null) {
          setState(() {
            _selectedImage = image;
          });
        }
      },
      child: CircleAvatar(
        radius: MediaQuery.sizeOf(context).width * 0.15,
        backgroundImage: _selectedImage != null
            ? FileImage(_selectedImage!)
            : NetworkImage(PLACEHOLDER_TR) as ImageProvider,
      ),
    );
  }

  Widget _registerFormButton() {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          if (_registrationFormKey.currentState?.validate() ?? false) {
            _registrationFormKey.currentState!.save();

            bool result = await _authService.registerNewUser(email!, password!);
            if (result) {
              print("-----------$result------------");
              // _navigationService.pushReplacementNamed("/login");
              _alertService.showToast(
                title: "Registered succesfully!",
                icon: Icons.check,
              );
            } else {
              _alertService.showToast(
                title: "Failed to register, please try gain!",
                icon: Icons.error,
              );
            }
          }
          setState(() {
            isLoading = false;
          });
        },
        color: Theme.of(context).primaryColor,
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
          Text("Log in", style: TextStyle(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}
