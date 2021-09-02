import 'package:flutter/material.dart';

import 'body/body.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body.create(context),
      appBar: AppBar(
        title: Center(child: Text('Time Tracker')),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
