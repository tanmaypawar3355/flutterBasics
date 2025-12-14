import 'package:flutter/material.dart';

class KeyHierranchyCheck extends StatefulWidget {
  const KeyHierranchyCheck({super.key});

  @override
  State<KeyHierranchyCheck> createState() => _KeyHierranchyCheckState();
}

class _KeyHierranchyCheckState extends State<KeyHierranchyCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Same Key(Same level/same hierarchy key)"),
      ),
      body: Column(
        children: [


          // 1]  Not Allowed(Same key in same hierarchy)
          Text("Hello world", key: Key("Text 1")),
          const SizedBox(height: 30),
          Text("Hello world", key: Key("Text 1")),
          // Not Allowed


          /////////////////////////////////////////////////
          
          
          // 2] Not Allowed (Same key in same hierarchy(Although the text is diff))
          Text("Hello world", key: Key("Text 1")),
          const SizedBox(height: 30),
          Text("Hello tammy", key: Key("Text 1")),
          // Not Allowed

           /////////////////////////////////////////////////
          
          
          // 3] Allowed(Same hierarchy but Key changed)
          Text("Hello world", key: Key("Text 1")),
          const SizedBox(height: 30),
          Text("Hello tammy", key: Key("Text 2")),
          // Allowed


          // 4] Allowed (Although the key is same but the hierarchy changed)
          Text("Hello world", key: Key("Text 1")),
          const SizedBox(height: 30),
          Row(
            children: [
                        Text("Hello world", key: Key("Text 1")),
            ],
          )

        ],
      ),
    );
  }
}
