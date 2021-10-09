import 'package:flutter/material.dart';

class InputDropdown extends StatelessWidget {
  final String? titleText;
  final String valueText;
  final VoidCallback? onPressed;
  final TextStyle? valueStyle;

  const InputDropdown({
    Key? key,
    this.titleText,
    required this.valueText,
    this.onPressed,
    this.valueStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: InputDecorator(
        baseStyle: this.valueStyle,
        decoration: InputDecoration(labelText: this.valueText),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(this.valueText),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
      onTap: this.onPressed,
    );
  }
}
