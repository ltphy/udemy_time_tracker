import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/services/format.dart';

import 'input_dropdown.dart';

class DateTimePicker extends StatelessWidget {
  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> onSelectedDate;
  final ValueChanged<TimeOfDay> onSelectedTime;

  const DateTimePicker({
    Key? key,
    required this.selectedDate,
    required this.selectedTime,
    required this.labelText,
    required this.onSelectedDate,
    required this.onSelectedTime,
  }) : super(key: key);

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: this.selectedDate,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime(2100));
    if (pickedDate != null && pickedDate != selectedDate) {
      this.onSelectedDate(pickedDate);
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: this.selectedTime,
    );
    if (pickedTime != null && pickedTime != this.selectedTime) {
      this.onSelectedTime(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: InputDropdown(
              valueText: Format.instance.date(this.selectedDate),
              titleText: this.labelText,
              onPressed: () => this.selectDate(context),
            ),
          ),
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: InputDropdown(
              valueText: selectedTime.format(context),
              valueStyle: Theme.of(context).textTheme.headline6,
              onPressed: () => this.selectTime(context),
            ),
          ),
        ],
      ),
    );
  }
}
