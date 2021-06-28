import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/provider/animated_provider.dart';

import 'body/body.dart';

class UserAuthenticationPage extends StatefulWidget {
  @override
  _UserAuthenticationPageState createState() =>
      _UserAuthenticationPageState();
}

class _UserAuthenticationPageState extends State<UserAuthenticationPage> {
  void doSth = () {
    const b = 5;
  };

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AnimatedProvider>(
              create: (context) => AnimatedProvider())
        ],
        child: Scaffold(
          body: Body(),
          appBar: AppBar(
            title: Center(child: Text('Time Tracker')),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ));
  }
}
