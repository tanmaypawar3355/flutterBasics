import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_33/const.dart';
import 'package:practice_flutter_application_33/services/alert_service.dart';
import 'package:practice_flutter_application_33/services/auth_service.dart';
import 'package:practice_flutter_application_33/services/navigation_service.dart';
import 'package:practice_flutter_application_33/widgets/custom_form_field.dart';

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
    return Scaffold(resizeToAvoidBottomInset: true, body: _buildUi());
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
            _logicButton(),
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
        Text(
          "Hi, Welcome again",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        Text(
          "Hello again, you've been missed",
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _loginForm() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.40,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
              validationRegExp: PASSWORD_VALIDATION_REGEX,
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

  Widget _logicButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        onPressed: () async {
          if (_loginFormKey.currentState?.validate() ?? false) {
            _loginFormKey.currentState!.save();
            print("hiii");

            try {
              bool result = await _authService.login(email!, password!);
              print(result);
              _alertService.showToast(
                text: "Successfully logged in!",
                icon: Icons.check,
              );
              _navigationService.pushReplacementNamed("/home");
            } catch (e) {
              print(e);
            }
          }
        },
        color: Colors.blue,
        child: Text("Login", style: TextStyle(color: Colors.white)),
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
              " Sign in",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
