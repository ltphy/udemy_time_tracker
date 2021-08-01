import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/pages/sign_in_page/sign_in_page.dart';
import 'package:udemy_timer_tracker/pages/user_authentication_page/widgets/sign_in_button.dart';
import 'package:udemy_timer_tracker/pages/user_authentication_page/widgets/social_sign_in_button.dart';
import 'package:udemy_timer_tracker/provider/auth_provider.dart';
import 'package:udemy_timer_tracker/services/dialog_services.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  Future<void> signIn(BuildContext context) async {
    try {
      final user =
          await context.read<AuthenticateProvider>().auth.signInAnonymous();
    } on Exception catch (error) {
      await DialogService.instance.showExceptionDialog(context, error);
    }
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      final user =
          await context.read<AuthenticateProvider>().auth.signInWithFacebook();
      print('json ${user?.email} ${user?.displayName} ${user?.email}');
      final accessToken = await FacebookAuth.instance.accessToken;
      if (accessToken != null) {
        final userData = await FacebookAuth.instance.getUserData(
          fields: "email,birthday,friends,gender,link",
        );
        print(jsonEncode(userData));
      }
    } on Exception catch (error) {
      await DialogService.instance.showExceptionDialog(context, error);
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final user =
          await context.read<AuthenticateProvider>().auth.signInWithGoogle();
    } on Exception catch (error) {
      await DialogService.instance.showExceptionDialog(context, error);
    }
  }

  void signInWithEmail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
                  onSignIn: () => signInWithGoogle(context),
                  fgColor: Colors.black,
                ),
                SizedBox(height: 10),
                SocialSignInButton(
                  imageAsset: 'images/facebook-logo.png',
                  title: 'Sign in with Facebook',
                  bgColor: Colors.indigo,
                  onSignIn: () => signInWithFacebook(context),
                  fgColor: Colors.white,
                ),
                SizedBox(height: 10),
                SignInButton(
                  title: 'Sign in with email',
                  bgColor: Colors.green,
                  onSignIn: () {
                    signInWithEmail(context);
                  },
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
                  onSignIn: () => signIn(context),
                  fgColor: Colors.black,
                ),
              ],
            ),
          )),
    );
  }
}
