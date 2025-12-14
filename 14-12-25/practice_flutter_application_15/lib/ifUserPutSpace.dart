import 'package:flutter/material.dart';

class IfUserPutSpace extends StatefulWidget {
  const IfUserPutSpace({super.key});

  @override
  State<IfUserPutSpace> createState() => _IfUserPutSpaceState();
}

class _IfUserPutSpaceState extends State<IfUserPutSpace> {
  TextEditingController controller1 = TextEditingController();
  bool isNotValid = false;
  @override
  Widget build(BuildContext context) {
    Color borderColor = isNotValid ? Colors.red : Colors.black;
    String? errorMsg = isNotValid ? "Enter this field first" : null;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: controller1,
                onChanged: (value) {
                  if (isNotValid) {
                    setState(() {
                      isNotValid = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: "Enter your name",
                  errorText: errorMsg,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor, width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                bool isValid = controller1.text.trim().isNotEmpty;
                print(controller1.text);

                setState(() {
                  isNotValid = !isValid;
                });
              },
              child: Text("Valiadte"),
            ),
          ],
        ),
      ),
    );
  }
}
