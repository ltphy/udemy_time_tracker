import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:udemy_timer_tracker/services/sign_in_services.dart';

class Body extends StatefulWidget {
  final Auth auth;

  const Body({
    Key? key,
    required this.auth,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  bool isSingedIn = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: TextFormField(
                    controller: _emailEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: _passwordEditingController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (isSingedIn) {
                        final user = await widget.auth.signInWithEmail(
                          email: _emailEditingController.text,
                          password: _passwordEditingController.text,
                        );
                        if (user != null) {
                          Navigator.of(context).pop();
                        }
                      } else {
                        final user = await widget.auth.registerNewAccount(
                          email: _emailEditingController.text,
                          password: _passwordEditingController.text,
                        );
                        if (user != null) {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: isSingedIn ? Text('Sign in') : Text('Register'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    this.isSingedIn = !this.isSingedIn;
                    this.setState(() {});
                  },
                  child: this.isSingedIn
                      ? Text('Need an account, Register?')
                      : Text('Got an account, Sign in'),
                )
              ],
            ),
          ),
        ));
  }
}
