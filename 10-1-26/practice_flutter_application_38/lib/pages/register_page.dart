import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_38/const.dart';
import 'package:practice_flutter_application_38/models/custom_form_field.dart';
import 'package:practice_flutter_application_38/models/user_profile.dart';
import 'package:practice_flutter_application_38/services/alert_servie.dart';
import 'package:practice_flutter_application_38/services/auth_service.dart';
import 'package:practice_flutter_application_38/services/database_service.dart';
import 'package:practice_flutter_application_38/services/media_service.dart';
import 'package:practice_flutter_application_38/services/navigation_service.dart';
import 'package:practice_flutter_application_38/services/storage_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  String? name, email, password;
  File? _selectedImage;
  final GlobalKey<FormState> _registerFormKey = GlobalKey();

  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  late NavigationService _navigationService;
  late MediaService _mediaService;
  late StorageService _storageService;
  late AlertService _alertService;
  late DatabaseService _databaseService;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
    _mediaService = _getIt.get<MediaService>();
    _storageService = _getIt.get<StorageService>();
    _alertService = _getIt.get<AlertService>();
    _databaseService = _getIt.get<DatabaseService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false, body: _buildUi());
  }

  Widget _buildUi() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerText(),
            _registerForm(),
            _registerButton(),
            _loginLink(),
          ],
        ),
      ),
    );
  }

  Widget _headerText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Let's get going!", style: TextStyle(fontSize: 20)),
        Text(
          "Register an account using the form below",
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _registerForm() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.60,
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _userPFP(),
            CustomFormField(
              height: MediaQuery.sizeOf(context).height * 0.10,
              hintText: "Name",
              obscureText: false,
              validationRegexp: NAME_VALIDATION_REGEX,
              onSaved: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            CustomFormField(
              height: MediaQuery.sizeOf(context).height * 0.10,
              hintText: "Email",
              obscureText: false,
              validationRegexp: EMAIL_VALIDATION_REGEX,
              onSaved: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            CustomFormField(
              height: MediaQuery.sizeOf(context).height * 0.10,
              hintText: "Password",
              obscureText: true,
              validationRegexp: PASSWORD_VALIDATION_REGEX,
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

  Widget _userPFP() {
    return GestureDetector(
      onTap: () async {
        File? image = await _mediaService.image();
        if (image != null) {
          setState(() {
            _selectedImage = image;
          });
        }
      },
      child: CircleAvatar(
        radius: MediaQuery.sizeOf(context).width * 0.15,
        backgroundColor: Colors.white,
        backgroundImage: _selectedImage != null
            ? FileImage(_selectedImage!)
            : NetworkImage(PLACEHOLDER_TR),
      ),
    );
  }

  Widget _registerButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        onPressed: () async {
          try {
            if (_registerFormKey.currentState?.validate() ?? false) {
              _registerFormKey.currentState!.save();

              bool results = await _authService.signin(email!, password!);
              String? pfpURL = await _storageService.uploadUserPFP(
                file: _selectedImage!,
                uid: _authService.user!.uid,
              );
              _databaseService.createUserProfile(
                userProfile: UserProfile(
                  uid: _authService.user!.uid,
                  name: name,
                  pfpURL: pfpURL,
                ),
              );

              _navigationService.goBack();
              _navigationService.pushReplacementNamed("/home");
            }
            _alertService.showToast(
              text: "Registered user successfully!",
              icon: Icons.check,
            );
          } catch (e) {
            print(e);
            _alertService.showToast(
              text: "Unable to register user, try again!",
              icon: Icons.error,
            );
          }
        },
        color: Colors.blue,
        child: Text(
          "Register",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
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
              "Log In",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
