import 'package:flutter/material.dart';

class CustomSignIn extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color bgColor;

  final Color fgColor;
  final VoidCallback onSignIn;

  const CustomSignIn({
    Key key,
    this.icon,
    this.title,
    this.bgColor,
    this.onSignIn,
    this.fgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(bgColor),
          foregroundColor: MaterialStateProperty.all<Color>(fgColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
          ),
        ),
        onPressed: () {
          this.onSignIn();
        },
        child: Container(
          height: 50,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(this.icon),
              ),
              SizedBox(width: 100),
              Text(
                this.title,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }
}
