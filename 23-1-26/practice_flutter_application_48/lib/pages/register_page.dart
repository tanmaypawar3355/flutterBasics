import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_48/common/custom_form_field.dart';
import 'package:practice_flutter_application_48/const.dart';
import 'package:practice_flutter_application_48/models/user_profile.dart';
import 'package:practice_flutter_application_48/services/alert_service.dart';
import 'package:practice_flutter_application_48/services/auth_service.dart';
import 'package:practice_flutter_application_48/services/database_service.dart';
import 'package:practice_flutter_application_48/services/media_service.dart';
import 'package:practice_flutter_application_48/services/navigation_service.dart';
import 'package:practice_flutter_application_48/services/storage_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? name, email, password;
  File? _selectedImage;
  bool _isLoading = false;

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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerText(),
            if (!_isLoading) _regiserForm(),
            if (!_isLoading) _registerButton(),
            if (_isLoading)
              Container(
                height: MediaQuery.sizeOf(context).height * 0.60,
                child: Center(child: CircularProgressIndicator()),
              ),
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
        Text("Let's get going", style: TextStyle(fontSize: 20)),
        Text(
          "Register an account using the form below",
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _regiserForm() {
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
              validationRegExp: NAME_VALIDATION_REGEX,
              onSaved: (value) {
                setState(() {
                  name = value;
                });
              },
              whichPage: "RegisterPage",
            ),
            ///////////////////////////////
            CustomFormField(
              hintText: "Email",
              validationRegExp: EMAIL_VALIDATION_REGEX,
              onSaved: (value) {
                setState(() {
                  email = value;
                });
              },
              whichPage: "RegisterPage",
            ),
            ///////////////////////////////
            CustomFormField(
              hintText: "Password",
              validationRegExp: PASSWORD_VALIDATION_REGEX,
              obscureText: true,
              onSaved: (value) {
                setState(() {
                  password = value;
                });
              },
              whichPage: "RegisterPage",
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
      child: MaterialButton(
        color: Colors.blue,
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
          if (_registerFormKey.currentState?.validate() ?? false) {
            _registerFormKey.currentState!.save();

            bool result = await _authService.signIn(email!, password!);

            if (result) {
              String? pfpURL = await _storageService.uploadUserPFP(
                file: _selectedImage!,
                uid: _authService.user!.uid,
              );

              await _databaseService.createUserProfile(
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
              _navigationService.pushReplacementNamed("/home");
            } else {
              _alertService.showToast(
                title: "Registration failed, try again!",
                icon: Icons.error,
              );
            }

            print(result);
          }
          setState(() {
            _isLoading = false;
          });
        },
        child: Text(
          "Register",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _logInLink() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("Already have an account?  "),
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
