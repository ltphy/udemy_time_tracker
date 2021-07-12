import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/provider/animated_provider.dart';
import 'package:udemy_timer_tracker/services/sign_in_services.dart';

import 'body/body.dart';

class UserAuthenticationPage extends StatelessWidget {
  static const String userAuthentication = '/user-authentication';

  const UserAuthenticationPage({
    Key? key,
    required this.auth,
  }) : super(key: key);
  final Auth auth;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AnimatedProvider>(
          create: (context) => AnimatedProvider(),
        ),
      ],
      child: Scaffold(
        body: Body(
          auth: auth,
        ),
        appBar: AppBar(
          title: Center(child: Text('Time Tracker')),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
