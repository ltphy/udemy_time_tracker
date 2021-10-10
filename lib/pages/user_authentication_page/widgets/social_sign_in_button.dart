import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/common_widgets/custom_elevated_button.dart';

class SocialSignInButton extends CustomElevatedButton {
  final String imageAsset;
  final String title;
  final VoidCallback? onSignIn;
  final Color? fgColor;
  final Color? bgColor;

  SocialSignInButton({
    Key? key,
    this.fgColor,
    this.bgColor,
    required this.imageAsset,
    required this.title,
    this.onSignIn,
  }) : super(
          key: key,
          fgColor: fgColor,
          bgColor: bgColor,
          onSignIn: onSignIn,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(imageAsset),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
}
