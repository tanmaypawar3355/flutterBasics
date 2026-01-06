import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_35/const.dart';
import 'package:practice_flutter_application_35/models/user_profile.dart';
import 'package:practice_flutter_application_35/services/alert_service.dart';
import 'package:practice_flutter_application_35/services/auth_service.dart';
import 'package:practice_flutter_application_35/services/database_service.dart';
import 'package:practice_flutter_application_35/services/media_service.dart';
import 'package:practice_flutter_application_35/services/navigation_service.dart';
import 'package:practice_flutter_application_35/services/storage_service.dart';
import 'package:practice_flutter_application_35/widgets/custom_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? name, email, password;
  bool _isLoading = false;
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
    return Scaffold(resizeToAvoidBottomInset: true, body: _buildUi());
  }

  Widget _buildUi() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
    return SizedBox(
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
                setState(() {
                  name = value;
                });
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

  Widget _userPfp() {
    return GestureDetector(
      onTap: () async {
        File? image = await _mediaService.selectUserPfp();
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
            : NetworkImage(PLACEHOLDER_TR) as ImageProvider,
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

            bool result = await _authService.signUp(email!, password!);

            String? pfpURL = await _storageService.uploadUserPfp(
              file: _selectedImage!,
              uid: _authService.user!.uid,
            );
            print("-------------${_authService.user!.uid}----------------");

            print("-------------$result----------------");
            print("-------------$pfpURL----------------");

            
            _databaseService.createUserProfile(
              userProfile: UserProfile(uid: _authService.user!.uid, name: name, pfpURL: pfpURL),
            );
            if (result && pfpURL != null) {
              _alertService.showCard(
                title: "Registered user successfully!",
                icon: Icons.check,
              );
              _navigationService.goBack();
            _navigationService.pushReplacementNamed("/home");
            } else {
              _alertService.showCard(
                title: "Registered nahi zala!",
                icon: Icons.check,
              );
            }
          }
          setState(() {
            _isLoading = false;
          });
        },
        color: Colors.blue,
        child: (_isLoading)
            ? CircularProgressIndicator(
                color: Colors.white,
                constraints: BoxConstraints.tight(Size(20, 20)),
              )
            : Text(
                "Register",
                style: TextStyle(color: Colors.white, fontSize: 17),
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
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
