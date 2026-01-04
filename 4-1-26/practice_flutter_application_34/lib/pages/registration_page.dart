import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_34/const.dart';
import 'package:practice_flutter_application_34/services/alert_service.dart';
import 'package:practice_flutter_application_34/services/auth_service.dart';
import 'package:practice_flutter_application_34/services/media_service.dart';
import 'package:practice_flutter_application_34/services/navigation_service.dart';
import 'package:practice_flutter_application_34/services/storage_service.dart';
import 'package:practice_flutter_application_34/widgets/custom_form_field.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _registrationFoKey = GlobalKey();

  String? email, password;
  File? _selectedImage;

  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  late NavigationService _navigationService;
  late MediaService _mediaService;
  late AlertService _alertService;
  late StorageService _storageService;

  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
    _mediaService = _getIt.get<MediaService>();
    _alertService = _getIt.get<AlertService>();
    _storageService = _getIt.get<StorageService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildUi());
  }

  Widget _buildUi() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerText(),
            _registrationForm(),
            _registrationButton(),
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
        Text("Let's, get going!", style: TextStyle(fontSize: 20)),
        Text(
          "Register an account using the form below",
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _registrationForm() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.60,
      child: Form(
        key: _registrationFoKey,
        child: Column(
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
        File? pickedImage = await _mediaService.pickImage();
        if (pickedImage != null) {
          setState(() {
            _selectedImage = pickedImage;
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

  Widget _registrationButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        onPressed: () async {
          if (_registrationFoKey.currentState?.validate() ?? false) {
            _registrationFoKey.currentState!.save();

            bool result = await _authService.signUp(email!, password!);
            print("$result");
            if (result) {
              _alertService.showToast(
                text: "Successfully registered new user!",
                icon: Icons.check,
              );

              String? pfpUrl = await _storageService.userPfp(
                file: _selectedImage!,
                uid: _authService.user!.uid,
              );

              print("$pfpUrl");

              print("hiii");
              _navigationService.pushReplacementNamed("/login");
            }
          }
        },
        color: Colors.blue,
        child: Text(
          "Register",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }

  Widget _logInLink() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Don't have an account? "),
          Text("Sign In", style: TextStyle(fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}
