import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/pages/home/home.dart';
import 'package:udemy_timer_tracker/pages/user_authentication_page/user_auththentication_page.dart';
import 'package:udemy_timer_tracker/provider/auth_provider.dart';
import 'package:udemy_timer_tracker/services/firestore_database.dart';

class LandingPage extends StatelessWidget {
  static final String route = '/landing-page';

  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return UserAuthenticationPage();
          } else {
            return Provider<Database>(
              create: (BuildContext context) =>
                  FirestoreDatabase(uid: user.uid),
              child: HomePage(),
            );
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
