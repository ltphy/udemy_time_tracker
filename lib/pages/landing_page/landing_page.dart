import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/pages/home/home.dart';
import 'package:udemy_timer_tracker/pages/user_authentication_page/user_auththentication_page.dart';
import 'package:udemy_timer_tracker/services/sign_in_services.dart';

class LandingPage extends StatelessWidget {
  final Auth auth;

  const LandingPage({Key? key, required this.auth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          print(snapshot.hasData.toString());
          if (!snapshot.hasData) {
            return UserAuthenticationPage(
              auth: auth,
            );
          } else {
            return HomePage(
              auth: auth,
            );
          }
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      stream: auth.streamUser,
    );
  }
}
