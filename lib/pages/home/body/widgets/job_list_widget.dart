import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/pages/home/screens/job_updater_widget.dart';
import 'package:udemy_timer_tracker/pages/sign_in_page/model/job.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/services/firestore_database.dart';

class JobItemWidget extends StatelessWidget {
  final Job job;
  final VoidCallback onPress;
  final void Function(DismissDirection dismissDirection)? onDismissed;

  const JobItemWidget(
      {Key? key, required this.job, required this.onPress, this.onDismissed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(job.id),
      child: ListTile(
        title: Text(job.name ?? ''),
        onTap: this.onPress,
        trailing: Icon(Icons.chevron_right),
      ),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: this.onDismissed,
    );
  }
}
