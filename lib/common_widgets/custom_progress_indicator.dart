import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final Color? valueColor;
  final Color? color;

  CustomProgressIndicator({this.valueColor, this.color});

  @override
  Widget build(BuildContext context) {
    final assignValueColor = valueColor;
    return CircularProgressIndicator(
      color: color,
      valueColor: assignValueColor != null
          ? AlwaysStoppedAnimation<Color>(assignValueColor)
          : null,
    );
  }
}
