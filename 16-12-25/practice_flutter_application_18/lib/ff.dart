import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: IfUserPutSpace());
  }
}

class IfUserPutSpace extends StatefulWidget {
  const IfUserPutSpace({super.key});

  @override
  State<IfUserPutSpace> createState() => _IfUserPutSpaceState();
}

class _IfUserPutSpaceState extends State<IfUserPutSpace> {
  TextEditingController controller1 = TextEditingController();
  bool _isInputInvalid = false;

  @override
  Widget build(BuildContext context) {
    final String? errorMsg = _isInputInvalid
        ? "Fill the field first (spaces are not allowed)"
        : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Input Validation Example')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  controller: controller1,
                  onChanged: (_) {
                    if (_isInputInvalid) {
                      setState(() {
                        _isInputInvalid = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter text here',
                    errorText: errorMsg,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _isInputInvalid ? Colors.red : Colors.black,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _isInputInvalid ? Colors.red : Colors.black,
                        width: 2.0,
                      ),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  bool isValid = controller1.text.trim().isNotEmpty;
                  

                  setState(() {
                    _isInputInvalid = !isValid;
                  });
                },
                child: const Text("Validate Input"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
