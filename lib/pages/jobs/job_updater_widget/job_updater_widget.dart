import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/model/job.dart';
import 'package:udemy_timer_tracker/provider/selected_job_provider.dart';
import 'package:udemy_timer_tracker/services/dialog_services.dart';
import 'package:udemy_timer_tracker/services/firestore_database.dart';

import 'body/body.dart';

class JobUpdateArgument {
  final Database database;
  final Job? job;

  JobUpdateArgument({required this.database, this.job});
}

class JobUpdaterWidget extends StatefulWidget {
  final Database database;
  final Job? job;

  JobUpdaterWidget({
    Key? key,
    required this.database,
    this.job,
  }) : super(key: key);

  static Future<void> show(BuildContext context,
      {required Database database, Job? job}) async {
    JobUpdateArgument jobUpdateArgument =
        JobUpdateArgument(database: database, job: job);
    await context
        .read<NavigatorState>()
        .pushNamed(JobUpdaterWidget.route, arguments: jobUpdateArgument);
  }

  static String route = 'jobUpdater/';

  @override
  State<JobUpdaterWidget> createState() => _JobUpdaterWidgetState();
}

class _JobUpdaterWidgetState extends State<JobUpdaterWidget> {
  late SelectedJobProvider selectedJobProvider;

  Future<void> createJob(BuildContext context) async {
    try {
      await selectedJobProvider.updateJobInDatabase();
      Navigator.of(context).pop();
    } on FirebaseException catch (error) {
      DialogService.instance.showMyDialog(
        context,
        message: error.message ?? 'Cannot save job ',
        defaultActionText: 'OK',
      );
    }
  }

  @override
  void initState() {
    selectedJobProvider = SelectedJobProvider(
      job: widget.job ?? Job(id: documentIdFromCurrentDate()),
      database: widget.database,
    );
    super.initState();
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
              title: Text(widget.job != null ? 'Update job' : 'Add new job'),
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
