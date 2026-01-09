import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_37/const.dart';
import 'package:practice_flutter_application_37/models/custom_form_field.dart';
import 'package:practice_flutter_application_37/models/user_profile.dart';
import 'package:practice_flutter_application_37/services/alert_service.dart';
import 'package:practice_flutter_application_37/services/auth_service.dart';
import 'package:practice_flutter_application_37/services/database_service.dart';
import 'package:practice_flutter_application_37/services/media_service.dart';
import 'package:practice_flutter_application_37/services/navigation_service.dart';
import 'package:practice_flutter_application_37/services/storage_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey();
  String? name, email, password;
  File? _selectedImage;
  bool _isLoading = false;

  final GetIt _getIt = GetIt.instance;
  late NavigationService _navigationService;
  late AuthService _authService;
  late MediaService _mediaService;
  late AlertService _alertService;
  late StorageService _storageService;
  late DatabaseService _databaseService;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
    _mediaService = _getIt.get<MediaService>();
    _alertService = _getIt.get<AlertService>();
    _storageService = _getIt.get<StorageService>();
    _databaseService = _getIt.get<DatabaseService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildUi());
  }

  Widget _buildUi() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerText(),
            if (!_isLoading) _registerFrom(),
            if (!_isLoading) _registerButton(),
            if (_isLoading)
              Container(
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
        Text("Let's get going!", style: TextStyle(fontSize: 20)),
        Text(
          "Register an account using the form below",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _registerFrom() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.60,
      color: Colors.white,
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _userPFP(),
            CustomFormField(
              height: MediaQuery.sizeOf(context).height * 0.10,
              hintText: "Name",
              validationRegExp: NAME_VALIDATION_REGEX,
              onSaved: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            CustomFormField(
              height: MediaQuery.sizeOf(context).height * 0.10,
              hintText: "Email",
              validationRegExp: EMAIL_VALIDATION_REGEX,
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

  Widget _userPFP() {
    return GestureDetector(
      onTap: () async {
        File? image = await _mediaService.pickAnImage();
        if (image != null) {
          setState(() {
            _selectedImage = image;
          });
        } else {
          _selectedImage = NetworkImage(PLACEHOLDER_TR) as File;
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
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
          try {
            if (_registerFormKey.currentState?.validate() ?? false) {
              _registerFormKey.currentState!.save();
              bool result = await _authService.signup(email!, password!);
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

              if (result && pfpURL != null) {
                _navigationService.goBack();
                _navigationService.pushReplacementNamed("/home");
                _alertService.showToast(
                  text: "Registered user successfully!",
                  icon: Icons.check,
                );
              } 
            }
          } catch (e) {
            print(e);
            _alertService.showToast(
                  text: "Registering user failed, try again!",
                  icon: Icons.error,
                );
          }
          setState(() {
            _isLoading = false;
          });
        },
        color: Colors.blue,
        child: Text(
          "Register",
          style: TextStyle(color: Colors.white, fontSize: 15),
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
