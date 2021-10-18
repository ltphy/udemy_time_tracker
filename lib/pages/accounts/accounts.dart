import 'package:flutter/material.dart';

import 'widgets/body.dart';

class Account extends StatelessWidget {
  static final String route = 'user-information/';

  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
