import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/services/sign_in_services.dart';

import 'body/body.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({
    Key? key,
    required this.auth,
  }) : super(key: key);
  final Auth auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        auth: auth,
      ),
      appBar: AppBar(
        title: Center(child: Text('Time Tracker')),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
