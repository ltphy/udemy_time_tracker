import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/model/entry/entry.dart';
import 'package:udemy_timer_tracker/model/job.dart';
import 'package:udemy_timer_tracker/services/firestore_database.dart';

import 'body/body.dart';

class EntryArgument {
  final Entry? entry;
  final Database database;
  final Job job;

  EntryArgument({
    required this.job,
    this.entry,
    required this.database,
  });
}

class EntryPage extends StatelessWidget {
  EntryPage({
    Key? key,
    required this.database,
    required this.job,
    this.entry,
  }) : super(key: key);
  final Database database;
  final Entry? entry;
  final Job job;

  static String route(String entryId) => 'entry/$entryId';

  static show(
    BuildContext context, {
    Entry? entry,
    required Database database,
    required Job job,
  }) async {
    EntryArgument entryArguments =
        EntryArgument(database: database, entry: entry, job: job);
    await Navigator.of(context)
        .pushNamed(EntryPage.route(entry?.id ?? ''), arguments: entryArguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      appBar: AppBar(
        title: Text('Entries'),
        actions: [
          TextButton(
            onPressed: () => {},
            child: Text(
              entry != null ? 'Done' : 'Create',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
