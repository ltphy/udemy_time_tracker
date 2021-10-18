import 'package:flutter/material.dart';

import 'widgets/body.dart';

class JobEntries extends StatelessWidget {
  const JobEntries({Key? key}) : super(key: key);
  static final String route = 'job_entries/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
