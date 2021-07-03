import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/common_widgets/custom_elevated_button.dart';

class SignInButton extends CustomElevatedButton {
  @required
  final String title;
  final VoidCallback? onSignIn;
  final Color? fgColor;
  final Color? bgColor;

  SignInButton({
    Key? key,
    required this.title,
    required this.onSignIn,
    this.fgColor,
    this.bgColor,
  }) : super(
            key: key,
            fgColor: fgColor,
            bgColor: bgColor,
            onSignIn: onSignIn,
            child: Text(
              title,
              textAlign: TextAlign.center,
            ));
}
