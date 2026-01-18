import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pracctice_flutter_application_41/const.dart';
import 'package:pracctice_flutter_application_41/models/custom_form_field.dart';
import 'package:pracctice_flutter_application_41/services/alert_service.dart';
import 'package:pracctice_flutter_application_41/services/auth_service.dart';
import 'package:pracctice_flutter_application_41/services/navigation_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email, password;
  bool _isLoading = false;
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

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 40,
      child: MaterialButton(
        color: Colors.blue,
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
          if (_loginFormKey.currentState?.validate() ?? false) {
            _loginFormKey.currentState!.save();

            bool result = await _authService.login(email!, password!);
            print(result);
            if (result) {
              _navigationService.pushReplacementNamed("/home");
              _alertService.showToast(
                title: "Login successful!",
                icon: Icons.check,
              );
            } else {
              _alertService.showToast(
                title: "Login failed, try again!",
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
                  "Login",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
        ),
      ),
    );
  }

  Widget _signInLink() {
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
