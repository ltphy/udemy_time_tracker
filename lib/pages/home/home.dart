import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/services/sign_in_services.dart';

class HomePage extends StatelessWidget {
  HomePage({required this.auth});

  static const String route = '/date-tracker';
  final Auth auth;

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          TextButton(
            onPressed: signOut,
            child: Text(
              'Sign out',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
