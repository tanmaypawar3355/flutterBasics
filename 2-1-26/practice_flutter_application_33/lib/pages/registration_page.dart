import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_33/const.dart';
import 'package:practice_flutter_application_33/services/auth_service.dart';
import 'package:practice_flutter_application_33/services/media_service.dart';
import 'package:practice_flutter_application_33/services/navigation_service.dart';
import 'package:practice_flutter_application_33/widgets/custom_form_field.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _HomePageState();
}

class _HomePageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _registrationFormKey = GlobalKey();

  File? _selectedImage;
  bool _isLoading = false;

  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  late NavigationService _navigationService;
  late MediaService _mediaService;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
    _mediaService = _getIt.get<MediaService>();
  }

  String? email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: true, body: _buildUi());
  }

  Widget _buildUi() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerText(),
            if (!_isLoading) _loginForm(),
            if (!_isLoading) _registerButton(),
            if (!_isLoading) _loginLink(),

            if (_isLoading)
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
          "Let's, get going!",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        Text(
          "Register an account usint the form below",
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _loginForm() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.60,
      child: Form(
        key: _registrationFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _userPfp(),
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
              validationRegExp: PASSWORD_VALIDATION_REGEX,
              obscureText: true,
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

  Widget _userPfp() {
    return GestureDetector(
      onTap: () async {
        print("On Tap");
        File? image = await _mediaService.selecteImage();
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
            : NetworkImage(PLACEHOLDER_PFP) as ImageProvider,
      ),
    );
  }

  Widget _registerButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
          if (_registrationFormKey.currentState?.validate() ?? false) {
            _registrationFormKey.currentState!.save();
            print("hiii");

            try {
              bool result = await _authService.registerNewUser(
                email!,
                password!,
              );
              print(result);
              // if()
            } catch (e) {
              print(e);
            }
          }
          setState(() {
            _isLoading = false;
          });
        },
        color: Colors.blue,
        child: Text("Register", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _loginLink() {
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
              " Log in",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
