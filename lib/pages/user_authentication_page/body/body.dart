import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:udemy_timer_tracker/pages/user_authentication_page/widgets/sign_in_button.dart';
import 'package:udemy_timer_tracker/pages/user_authentication_page/widgets/social_sign_in_button.dart';
import 'package:udemy_timer_tracker/services/sign_in_services.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.auth,
  }) : super(key: key);
  final Auth auth;

  Future<void> signIn() async {
    try {
      final user = await auth.signInAnonymous();
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      final user = await auth.signInWithFacebook();
      print('json ${user?.email} ${user?.displayName} ${user?.email}');
      final accessToken = await FacebookAuth.instance.accessToken;
      if (accessToken != null) {
        final userData = await FacebookAuth.instance.getUserData(
          fields: "email,birthday,friends,gender,link",
        );
        print(jsonEncode(userData));
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final user = await auth.signInWithGoogle();
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[100],
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 120),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Sign In',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3),
              ),
              SocialSignInButton(
                imageAsset: 'images/google-logo.png',
                title: 'Sign in with Google',
                bgColor: Colors.white,
                onSignIn: signInWithGoogle,
                fgColor: Colors.black,
              ),
              SizedBox(height: 10),
              SocialSignInButton(
                imageAsset: 'images/facebook-logo.png',
                title: 'Sign in with Facebook',
                bgColor: Colors.indigo,
                onSignIn: signInWithFacebook,
                fgColor: Colors.white,
              ),
              SizedBox(height: 10),
              SignInButton(
                title: 'Sign in with email',
                bgColor: Colors.green,
                onSignIn: () {},
                fgColor: Colors.black,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'or',
                  textAlign: TextAlign.center,
                ),
              ),
              SignInButton(
                title: 'Go anonymous',
                bgColor: Colors.yellow,
                onSignIn: signIn,
                fgColor: Colors.black,
              ),
            ],
          ),
        ));
  }
}
