import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/pages/sign_in_page/model/job.dart';
import 'package:udemy_timer_tracker/provider/selected_job_provider.dart';
import 'package:udemy_timer_tracker/services/firestore_database.dart';

import 'body/body.dart';

class JobUpdaterWidget extends StatelessWidget {
  final Database database;

  const JobUpdaterWidget({Key? key, required this.database}) : super(key: key);

  static Future<void> show(BuildContext context,
      {required Database database}) async {
    await Navigator.of(context)
        .pushNamed(JobUpdaterWidget.route, arguments: database);
  }

  static String route = 'jobUpdater/';

  Future<void> createJob(BuildContext context) async {
    try {
      Job? job = context.read<SelectedJobProvider>().job;
      if (job != null) {
        await context.read<Database>().createJob(job);
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        providers: [
          Provider<SelectedJobProvider>(
            create: (BuildContext context) {
              return SelectedJobProvider();
            },
          ),
          Provider<Database>.value(value: database),
        ],
        child: Body(),
      ),
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Update job'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close),
        ),
        actions: [
          TextButton(
            onPressed: () => createJob(context),
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
