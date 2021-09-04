import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/pages/home/body/widgets/job_list_widget.dart';
import 'package:udemy_timer_tracker/pages/sign_in_page/model/job.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/services/firestore_database.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreDatabase = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>?>(
      stream: firestoreDatabase.streamJobs(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          List<Job>? jobs = snapshot.data;
          if (jobs != null) {
            return JobListWidget(jobs: jobs);
          }
          return Center(
            child: Text(
              'Some error occured!',
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
