import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pracctice_flutter_application_41/const.dart';
import 'package:pracctice_flutter_application_41/models/custom_form_field.dart';
import 'package:pracctice_flutter_application_41/models/user_profile.dart';
import 'package:pracctice_flutter_application_41/services/alert_service.dart';
import 'package:pracctice_flutter_application_41/services/auth_service.dart';
import 'package:pracctice_flutter_application_41/services/database_service.dart';
import 'package:pracctice_flutter_application_41/services/media_service.dart';
import 'package:pracctice_flutter_application_41/services/navigation_service.dart';
import 'package:pracctice_flutter_application_41/services/storage_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  String? name, email, password;
  bool _isLoading = false;
  File? _selectedImage;
  final GlobalKey<FormState> _registerFormKey = GlobalKey();

  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  late NavigationService _navigationService;
  late AlertService _alertService;
  late MediaService _mediaService;
  late StorageService _storageService;
  late DatabaseService _databaseService;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
    _alertService = _getIt.get<AlertService>();
    _mediaService = _getIt.get<MediaService>();
    _storageService = _getIt.get<StorageService>();
    _databaseService = _getIt.get<DatabaseService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildUI());
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerText(),
            if (!_isLoading) _registerForm(),
            if (!_isLoading) _registerButton(),
            if (_isLoading)
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.60,
                child: Center(child: CircularProgressIndicator()),
              ),
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
        Text("Hi, Welcome Back!", style: TextStyle(fontSize: 20)),
        Text(
          "Hello again, you've been missed",
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _registerForm() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.60,
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _userPFP(),
            CustomFormField(
              hintText: "Name",
              onSaved: (value) {
                setState(() {
                  name = value;
                });
              },
              validationRegExp: NAME_VALIDATION_REGEX,
              obscureText: false,
            ),
            CustomFormField(
              hintText: "Email",
              onSaved: (value) {
                setState(() {
                  email = value;
                });
              },
              validationRegExp: EMAIL_VALIDATION_REGEX,
              obscureText: false,
            ),
            CustomFormField(
              hintText: "Password",
              onSaved: (value) {
                setState(() {
                  password = value;
                });
              },
              validationRegExp: PASSWORD_VALIDATION_REGEX,
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _userPFP() {
    return GestureDetector(
      onTap: () async {
        File? image = await _mediaService.selectImageFormGallery();
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
            : NetworkImage(PLACEHOLDER_TR),
      ),
    );
  }

  Widget _registerButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 40,
      child: MaterialButton(
        color: Colors.blue,
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
          if (_registerFormKey.currentState?.validate() ?? false) {
            _registerFormKey.currentState!.save();

            bool result = await _authService.signup(email!, password!);
            print(result);
            if (result) {
              String? pfpURL = await _storageService.uploadUserPFP(
                file: _selectedImage!,
                uid: _authService.user!.uid,
              );

              _databaseService.createUserProfileCollection(
                userProfile: UserProfile(
                  uid: _authService.user!.uid,
                  name: name,
                  pfpURL: pfpURL,
                ),
              );

              _navigationService.goBack();
              _navigationService.pushReplacementNamed("/home");
              _alertService.showToast(
                title: "Resgitration successful!",
                icon: Icons.check,
              );
            } else {
              _alertService.showToast(
                title: "Registration failed, try again!",
                icon: Icons.error,
              );
            }
          }
          setState(() {
            _isLoading = false;
          });
        },
        child: Center(
          child: _isLoading == true
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 160,
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      padding: EdgeInsets.all(5),
                      strokeWidth: 3,
                    ),
                  ),
                )
              : Text(
                  "Register",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
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
