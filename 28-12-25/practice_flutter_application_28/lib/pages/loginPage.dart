import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_28/Widgets/costomFormField.dart';
import 'package:practice_flutter_application_28/const.dart';
import 'package:practice_flutter_application_28/services/authService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  final GetIt _getIt = GetIt.instance;
  late Authservice _authservice;

  String? email, password;

  @override
  void initState() {
    super.initState();
    _authservice = _getIt.get<Authservice>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildUI());
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerText(),
            _loginForm(),
            _loginButton(),
            _SignInNewUser(),
          ],
        ),
      ),
    );
  }

  Widget _headerText() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hi, Wecome Back!",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        Text(
          "Hello again, you have been missed",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _loginForm() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomFormField(
              hintText: "Email",
              validationRegEx: EMAIL_VALIDATION_REGEX,
              height: MediaQuery.sizeOf(context).height * 0.1,
              onSaved: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            CustomFormField(
              hintText: "Password",
              validationRegEx: PASSWORD_VALIDATION_REGEX,
              height: MediaQuery.sizeOf(context).height * 0.1,
              obscureText: true,
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
            _loginFormKey.currentState?.save();

            bool result = await _authservice.login(email!, password!);
          } else {
            print("Choohooo");
          }
          // return "Enter a valid"
        },
        color: Colors.blue,
        child: Text("Login", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _SignInNewUser() {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Don't have an account? "),
          Text("Sign in", style: TextStyle(fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}
