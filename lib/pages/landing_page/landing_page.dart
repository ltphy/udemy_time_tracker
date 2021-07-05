import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/pages/home/home.dart';
import 'package:udemy_timer_tracker/pages/user_authentication_page/user_auththentication_page.dart';
import 'package:udemy_timer_tracker/services/sign_in_services.dart';

class LandingPage extends StatefulWidget {
  final Auth auth;

  const LandingPage({Key? key, required this.auth}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late User? user;

  @override
  void initState() {
    super.initState();
    user = widget.auth.currentUser;
  }

  void updateUser(User? user) {
    this.setState(() {
      this.user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return UserAuthenticationPage(
        signIn: updateUser,
        auth: widget.auth,
      );
    }
    return HomePage(
      signOut: () => updateUser(null),
      auth: widget.auth,
    );
  }
}
