import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/services/sign_in_services.dart';

class HomePage extends StatefulWidget {
  HomePage({required this.auth, required this.signOut});

  static const String route = '/date-tracker';
  final Auth auth;
  final VoidCallback signOut;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> signOut() async {
    try {
      await widget.auth.signOut();
      widget.signOut();
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
