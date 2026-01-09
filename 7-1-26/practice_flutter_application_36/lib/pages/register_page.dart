import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_36/const.dart';
import 'package:practice_flutter_application_36/models/user_profile.dart';
import 'package:practice_flutter_application_36/services/alert_service.dart';
import 'package:practice_flutter_application_36/services/auth_Service.dart';
import 'package:practice_flutter_application_36/services/database_service.dart';
import 'package:practice_flutter_application_36/services/media_service.dart';
import 'package:practice_flutter_application_36/services/navigation_service.dart';
import 'package:practice_flutter_application_36/services/storage_service.dart';
import 'package:practice_flutter_application_36/widgets/custom_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
    return Form(
      key: _registerFormKey,
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.60,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _userPfp(),
            CustomFormField(
              hintText: "Name",
              height: MediaQuery.sizeOf(context).height * 0.10,
              validationRegExp: NAME_VALIDATION_REGEX,
              ObscureText: false,
              onSaved: (value) {
                name = value;
              },
            ),
            CustomFormField(
              hintText: "Email",
              height: MediaQuery.sizeOf(context).height * 0.10,
              validationRegExp: EMAIL_VALIDATION_REGEX,
              ObscureText: false,
              onSaved: (value) {
                email = value;
              },
            ),
            CustomFormField(
              hintText: "Password",
              height: MediaQuery.sizeOf(context).height * 0.10,
              validationRegExp: PASSWORD_VALIDATION_REGEX,
              ObscureText: true,
              onSaved: (value) {
                password = value;
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
        File? image = await _mediaService.selectImage();
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
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        onPressed: () async {
          if (_registerFormKey.currentState?.validate() ?? false) {
            _registerFormKey.currentState!.save();
            try {
              bool results = await _authService.signup(email!, password!);

              if (results) {
                String? pfpURL = await _storageService.uploadUserPfp(
                  file: _selectedImage ?? NetworkImage(PLACEHOLDER_TR) as File,
                  uid: _authService.user!.uid,
                );

                _databaseService.createUserProfile(
                  userProfile: UserProfile(
                    uid: _authService.user!.uid,
                    name: name,
                    pfpURL: pfpURL,
                  ),
                );
              }

              _alertService.showToast(
                message: "Successfully registered new user!",
                icon: Icons.done,
              );
            } catch (e) {
              print("here is the exception");
              _alertService.showToast(
                message: "Failed to register, try again!",
                icon: Icons.done,
              );
            }
          }
        },
        child: Text(
          "Register",
          style: TextStyle(color: Colors.white, fontSize: 20),
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
          Text("Already have an account?  "),
          Text("Log in", style: TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
