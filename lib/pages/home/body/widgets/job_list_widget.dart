import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/pages/sign_in_page/model/job.dart';

class JobItemWidget extends StatelessWidget {
  final Job job;
  final VoidCallback onPress;

  const JobItemWidget({
    Key? key,
    required this.job,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(job.name ?? ''),
      onTap: this.onPress,
      trailing: Icon(Icons.chevron_right),
    );
  }
}
