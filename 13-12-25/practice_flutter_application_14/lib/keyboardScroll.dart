import 'package:flutter/material.dart';

class ScreenScroller extends StatefulWidget {
  const ScreenScroller({super.key});

  @override
  State<ScreenScroller> createState() => _ScreenScrollerState();
}

class _ScreenScrollerState extends State<ScreenScroller> {
  showMyModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: 350,
            width: MediaQuery.of(context).size.width - 100,
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(),
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 200,
                    height: 50,
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        "POP",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () => showMyModalBottomSheet(context),
          child: Container(
            width: 200,
            height: 50,
            color: Colors.grey,
            child: Center(
              child: Text(
                "TAP",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
