import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_44/const.dart';
import 'package:practice_flutter_application_44/models/custom_form_field.dart';
import 'package:practice_flutter_application_44/models/user_profile.dart';
import 'package:practice_flutter_application_44/services/alert_service.dart';
import 'package:practice_flutter_application_44/services/auth_service.dart';
import 'package:practice_flutter_application_44/services/database_service.dart';
import 'package:practice_flutter_application_44/services/media_service.dart';
import 'package:practice_flutter_application_44/services/navigation_service.dart';
import 'package:practice_flutter_application_44/services/storage_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  String? name, email, password;
  File? _selectedImage;
  final GlobalKey<FormState> _registrationFormKey = GlobalKey();

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
        Text("Let's, get  going!", style: TextStyle(fontSize: 20)),
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
        key: _registrationFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _userPFP(),
            CustomFormField(
              hinteText: "Name",
              validationRegExp: NAME_VALIDATION_REGEX,
              forWhichPage: "RegisterPage",
              onSaved: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            CustomFormField(
              hinteText: "Email",
              validationRegExp: EMAIL_VALIDATION_REGEX,
              forWhichPage: "RegisterPage",
              onSaved: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            CustomFormField(
              hinteText: "Password",
              validationRegExp: PASSWORD_VALIDATION_REGEX,
              forWhichPage: "RegisterPage",
              onSaved: (value) {
                setState(() {
                  password = value;
                });
              },
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
        File? image = await _mediaService.selectImageFromGallery();
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

  Widget _registerButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 40,
      child: MaterialButton(
        color: Colors.blue,
        onPressed: () async {
          try {
            if (_registrationFormKey.currentState?.validate() ?? false) {
              _registrationFormKey.currentState!.save();

              await _authService.signin(email!, password!);

              String? pfpURL;
              if (_selectedImage != null) {
                pfpURL = await _storageService.uploadImageToFirebase(
                  file: _selectedImage!,
                  uid: _authService.user!.uid,
                );
              }

              try {
                _databaseService.createNewUserProfile(
                  UserProfile(
                    uid: _authService.user!.uid,
                    name: name,
                    pfpURL: pfpURL,
                  ),
                );

                _alertService.showToast(
                  title: "Registration successful!",
                  icon: Icons.check,
                );
                _navigationService.goBack();
                _navigationService.pushReplacementNamed("/home");
              } catch (e) {
                print("Unable to create database");
                print(e);
              }
            }
          } catch (e) {
            print(e);
            _alertService.showToast(
              title: "Registration failed, try again!",
              icon: Icons.check,
            );
          }
        },
        child: Text(
          "Register",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginLink() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
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
