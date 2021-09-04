import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/pages/sign_in_page/model/job.dart';
import 'package:udemy_timer_tracker/provider/selected_job_provider.dart';
import 'package:udemy_timer_tracker/services/firestore_database.dart';

import 'body/body.dart';

class JobUpdateArgument {
  final Database database;
  final Job? job;

  JobUpdateArgument({required this.database, this.job});
}

class JobUpdaterWidget extends StatelessWidget {
  final Database database;
  final Job? job;
  late SelectedJobProvider selectedJobProvider;

  JobUpdaterWidget({Key? key, required this.database, this.job})
      : super(key: key) {
    selectedJobProvider = SelectedJobProvider(
      job: job ?? Job(id: documentIdFromCurrentDate()),
      database: database,
    );
  }

  static Future<void> show(BuildContext context,
      {required Database database, Job? job}) async {
    JobUpdateArgument jobUpdateArgument =
        JobUpdateArgument(database: database, job: job);
    await Navigator.of(context)
        .pushNamed(JobUpdaterWidget.route, arguments: jobUpdateArgument);
  }

  static String route = 'jobUpdater/';

  Future<void> createJob(BuildContext context) async {
    try {
      await selectedJobProvider.updateJobInDatabase();
      Navigator.of(context).pop();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SelectedJobProvider>.value(
          value: selectedJobProvider,
        ),
      ],
      child: Scaffold(
        body: Body(),
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: Builder(
            builder: (BuildContext context) => AppBar(
              title: Text(job != null ? 'Update job' : 'Add new job'),
              leading: IconButton(
                onPressed: context.watch<SelectedJobProvider>().loading
                    ? null
                    : () => Navigator.of(context).pop(),
                icon: Icon(Icons.close),
                disabledColor: Colors.white,
              ),
              actions: [
                TextButton(
                  onPressed: context.watch<SelectedJobProvider>().loading
                      ? null
                      : () => createJob(context),
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
