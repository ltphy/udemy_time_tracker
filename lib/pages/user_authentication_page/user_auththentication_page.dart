import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/provider/animated_provider.dart';
import 'package:udemy_timer_tracker/provider/loading_provider.dart';
import 'package:udemy_timer_tracker/services/sign_in_services.dart';

import 'body/body.dart';

class UserAuthenticationPage extends StatefulWidget {
  static const String userAuthentication = '/user-authentication';

  const UserAuthenticationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<UserAuthenticationPage> createState() => _UserAuthenticationPageState();
}

class _UserAuthenticationPageState extends State<UserAuthenticationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AnimatedProvider>(
          create: (context) => AnimatedProvider(),
        ),
        ChangeNotifierProvider<LoadingProvider>(
          create: (context) => LoadingProvider(),
        ),
      ],
      child: Scaffold(
        body: Body(),
        appBar: AppBar(
          title: Center(
            child: Text('Time Tracker'),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
