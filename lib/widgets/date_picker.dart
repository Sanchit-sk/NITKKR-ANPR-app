import 'package:flutter/material.dart';

class MyDatePicker extends StatefulWidget {
  final Function(DateTime) onDateChanged;
  const MyDatePicker({Key? key, required this.onDateChanged}) : super(key: key);

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime date = DateTime.now();

  String getText() {
    return "${date.day}/${date.month}/${date.year}";
  }

  Future<void> pickDate() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 1));

    if (selectedDate == null) return;
    setState(() {
      date = selectedDate;
      widget.onDateChanged(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          pickDate();
        },
        child: Text(getText()));
  }
}
