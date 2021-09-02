import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/services/dialog_services.dart';

import 'body/body.dart';

class JobsPage extends StatelessWidget {
  JobsPage();

  static const String route = '/date-tracker';

  Future<void> signOut(BuildContext context) async {
    try {
      await context.read<AuthenticateProvider>().auth.signOut();
    } catch (error) {
      await DialogService.instance.showMyDialog(
        context,
        message: error.toString(),
        defaultActionText: 'OK',
        title: 'Log out',
      );
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final bool? requestSignOut = await DialogService.instance.showMyDialog(
      context,
      message: 'Are you sure that you want to logout?',
      defaultActionText: 'Logout',
      title: 'Error',
      cancelActionText: 'Cancel',
    );
    if (requestSignOut == true) {
      await this.signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          TextButton(
            onPressed: () => _confirmSignOut(context),
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
