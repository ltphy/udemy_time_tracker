import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/model/job.dart';
import 'package:udemy_timer_tracker/pages/entry_page/entry_page.dart';
import 'package:udemy_timer_tracker/pages/job_updater_widget/job_updater_widget.dart';
import 'package:udemy_timer_tracker/services/firestore_database.dart';

import 'body/body.dart';

class Entries extends StatelessWidget {
  static const String route = '/entries';
  final Job job;
  final Database database;

  const Entries({
    Key? key,
    required this.job,
    required this.database,
  }) : super(key: key);

  static show(BuildContext context,
      {required Job job, required Database database}) async {
    JobUpdateArgument jobUpdateArgument =
        JobUpdateArgument(database: database, job: job);
    await Navigator.of(context)
        .pushNamed(Entries.route, arguments: jobUpdateArgument);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Database>.value(value: database),
      ],
      child: Scaffold(
        body: Body(
          job: this.job,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => EntryPage.show(context, database: database),
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('Entries'),
          actions: [
            TextButton(
              onPressed: () =>
                  JobUpdaterWidget.show(context, database: database, job: job),
              child: Text(
                'Edit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
