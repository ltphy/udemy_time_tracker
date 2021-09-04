import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/pages/home/screens/job_updater_widget.dart';
import 'package:udemy_timer_tracker/pages/sign_in_page/model/job.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/services/firestore_database.dart';

class JobListWidget extends StatelessWidget {
  final List<Job> jobs;

  const JobListWidget({Key? key, required this.jobs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Database database = Provider.of<Database>(context, listen: false);
    return Container(
      child: ListView.builder(
        itemBuilder: (_, index) {
          return ListTile(
            onTap: () => JobUpdaterWidget.show(
              context,
              database: database,
              job: jobs[index],
            ),
            title: Text(
              jobs[index].name ?? '',
            ),
            trailing: Icon(Icons.arrow_right),
          );
        },
        itemCount: jobs.length,
      ),
    );
  }
}
