import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PickADate extends StatefulWidget {
  const PickADate({super.key});

  @override
  State<PickADate> createState() => _PickADateState();
}

class _PickADateState extends State<PickADate> {
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> selectDate() async {
      DateTime? datePicked = await showDatePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
      );
      if (datePicked != null) {
        String fomratDate = DateFormat('dd/MM/yyyy').format(datePicked);
        // print(fomratDate);

        setState(() {
          dateController.text = fomratDate;
        });
      }
    }

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: TextField(
            controller: dateController,
            readOnly: true,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.calendar_month),
              border: OutlineInputBorder(),
            ),
            onTap: selectDate,
          ),
        ),
      ),
    );
  }
}
