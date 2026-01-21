import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_45/common/custom_form_field.dart';
import 'package:practice_flutter_application_45/const.dart';
import 'package:practice_flutter_application_45/services/alert_service.dart';
import 'package:practice_flutter_application_45/services/auth_service.dart';
import 'package:practice_flutter_application_45/services/navigation_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email, password;

  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  late NavigationService _navigationService;
  late AlertService _alertService;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
    _alertService = _getIt.get<AlertService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: true, body: _buildUI());
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerText(),
            _loginForm(),
            _loginButton(),
            _signInLink(),
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

  Widget _loginForm() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.40,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomFormField(
              hintText: "Email",
              whichPage: "LoginPage",
              validationRegExp: EMAIL_VALIDATION_REGEX,
              onSaved: (value) {
                setState(() {
                  email = value;
                });
              },
            ),

            ///
            CustomFormField(
              hintText: "Password",
              whichPage: "LoginPage",
              validationRegExp: PASSWORD_VALIDATION_REGEX,
              obsureText: true,
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

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        onPressed: () async {
          if (_loginFormKey.currentState?.validate() ?? false) {
            _loginFormKey.currentState!.save();

            bool result = await _authService.login(email!, password!);

            if (result) {
              print(result);
              _navigationService.pushReplacementNamed("/home");
              _alertService.showToast(
                title: "Login Successful!",
                icon: Icons.check,
              );
            } else {
              _alertService.showToast(
                title: "Login failed, try again!",
                icon: Icons.error,
              );
            }
          }
        },
        color: Colors.blue,
        child: Text(
          "Login",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _signInLink() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Don't have an account? "),
          GestureDetector(
            onTap: () {
              _navigationService.pushNamed("/register");
            },
            child: Text(
              " Sign In",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
