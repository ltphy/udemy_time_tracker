import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/pages/home/home.dart';
import 'package:udemy_timer_tracker/pages/user_authentication_page/user_auththentication_page.dart';
import 'package:udemy_timer_tracker/provider/auth_provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          print(snapshot.hasData.toString());
          if (!snapshot.hasData) {
            return UserAuthenticationPage();
          } else {
            return HomePage();
          }
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      stream: context.read<AuthenticateProvider>().auth.streamUser,
    );
  }
}
