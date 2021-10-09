import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/pages/sign_in_page/sign_in_page.dart';
import 'package:udemy_timer_tracker/pages/user_authentication_page/widgets/background_sequence_animation.dart';
import 'package:udemy_timer_tracker/pages/user_authentication_page/widgets/sign_in_button.dart';
import 'package:udemy_timer_tracker/pages/user_authentication_page/widgets/social_sign_in_button.dart';
import 'package:udemy_timer_tracker/provider/auth_provider.dart';
import 'package:udemy_timer_tracker/provider/loading_provider.dart';
import 'package:udemy_timer_tracker/services/dialog_services.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLogin = false;

  Future<void> signIn() async {
    try {
      context.read<LoadingProvider>().updateLoading();
      final user =
          await context.read<AuthenticateProvider>().auth.signInAnonymous();
    } on Exception catch (error) {
      await DialogService.instance.showExceptionDialog(context, error);
    } finally {
      context.read<LoadingProvider>().updateLoading();
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      context.read<LoadingProvider>().updateLoading();
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
    } finally {
      if (this.mounted) {
        context.read<LoadingProvider>().updateLoading();
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      context.read<LoadingProvider>().updateLoading();
      final user =
          await context.read<AuthenticateProvider>().auth.signInWithGoogle();
    } on Exception catch (error) {
      await DialogService.instance.showExceptionDialog(context, error);
      context.read<LoadingProvider>().updateLoading();
    }
  }

  void signInWithEmail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: context.watch<LoadingProvider>().isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                        onSignIn: () => signInWithGoogle(),
                        fgColor: Colors.black,
                      ),
                      SizedBox(height: 10),
                      SocialSignInButton(
                        imageAsset: 'images/facebook-logo.png',
                        title: 'Sign in with Facebook',
                        bgColor: Colors.indigo,
                        onSignIn: () async => await signInWithFacebook(),
                        fgColor: Colors.white,
                      ),
                      SizedBox(height: 10),
                      SignInButton(
                        title: 'Sign in with email',
                        bgColor: Colors.green,
                        onSignIn: () {
                          signInWithEmail();
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
                        onSignIn: () => signIn(),
                        fgColor: Colors.black,
                      ),
                      this.isLogin ? Text('isLogin') : Text(''),
                      BackgroundSequenceAnimation(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
