import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/pages/user_authentication_page/widgets/sign_in_button.dart';
import 'package:udemy_timer_tracker/pages/user_authentication_page/widgets/social_sign_in_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
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
                onSignIn: () {},
                fgColor: Colors.black,
              ),
              SizedBox(height: 10),
              SocialSignInButton(
                imageAsset: 'images/facebook-logo.png',
                title: 'Sign in with Facebook',
                bgColor: Colors.indigo,
                onSignIn: () {},
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
                onSignIn: () {},
                fgColor: Colors.black,
              ),
            ],
          ),
        ));
  }
}
