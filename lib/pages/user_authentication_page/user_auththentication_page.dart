import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/provider/animated_provider.dart';
import 'package:udemy_timer_tracker/services/sign_in_services.dart';

import 'body/body.dart';

class UserAuthenticationPage extends StatefulWidget {
  static const String userAuthentication = '/user-authentication';

  const UserAuthenticationPage({
    Key? key,
    required this.signIn,
    required this.auth,
  }) : super(key: key);
  final Function(User? user) signIn;
  final Auth auth;

  @override
  _UserAuthenticationPageState createState() => _UserAuthenticationPageState();
}

class _UserAuthenticationPageState extends State<UserAuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AnimatedProvider>(
              create: (context) => AnimatedProvider())
        ],
        child: Scaffold(
          body: Body(
            signIn: widget.signIn,
            auth: widget.auth,
          ),
          appBar: AppBar(
            title: Center(child: Text('Time Tracker')),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ));
  }
}
