import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color? bgColor;
  final Widget? child;
  final Color? fgColor;
  final VoidCallback? onSignIn;
  final double borderRadius;
  final double height;

  CustomElevatedButton({
    Key? key,
    this.height: 50,
    this.borderRadius: 16,
    this.bgColor,
    this.fgColor,
    required this.onSignIn,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // local variable
    final bgColor = this.bgColor;
    final fgColor = this.fgColor;
    return SizedBox(
      height: this.height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: bgColor,
          onPrimary: fgColor,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(this.borderRadius))),
        ),
        onPressed: this.onSignIn,
        child: child,
      ),
    );
  }
}
