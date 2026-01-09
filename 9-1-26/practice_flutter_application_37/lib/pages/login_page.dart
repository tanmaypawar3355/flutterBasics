import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_37/const.dart';
import 'package:practice_flutter_application_37/models/custom_form_field.dart';
import 'package:practice_flutter_application_37/services/alert_service.dart';
import 'package:practice_flutter_application_37/services/auth_service.dart';
import 'package:practice_flutter_application_37/services/navigation_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  String? email, password;

  final GetIt _getIt = GetIt.instance;
  late NavigationService _navigationService;
  late AuthService _authService;
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
            _loginForm(),
            _loginButton(),
            _signinLink(),
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
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _loginForm() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.40,
      color: Colors.white,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        onPressed: () async {
          try {
            if (_loginFormKey.currentState?.validate() ?? false) {
              _loginFormKey.currentState!.save();
              bool result = await _authService.login(email!, password!);

              if (result) {
                _navigationService.pushReplacementNamed("/home");
                _alertService.showToast(
                  text: "Successfully logged in!",
                  icon: Icons.check,
                );
              } else {
                _alertService.showToast(
                  text: "Logging failed, try again!",
                  icon: Icons.error,
                );
              }
            }
          } catch (e) {
            print("here");
          }
        },
        color: Colors.blue,
        child: Text(
          "Login",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }

  Widget _signinLink() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("Don't have an account? "),
          GestureDetector(
            onTap: () {
              _navigationService.pushNamed("/register");
            },
            child: Text(
              "Sign In",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
