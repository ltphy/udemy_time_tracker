import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/model/entry/entry.dart';
import 'package:udemy_timer_tracker/model/job.dart';
import 'package:udemy_timer_tracker/provider/selected_entry_provider.dart';
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

  Future<void> updateEntry(BuildContext context) async {
    await context.read<SelectedEntryProvider>().updateEntryInDatabase();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SelectedEntryProvider>(
          create: (context) => SelectedEntryProvider(
            entry: this.entry,
            jobId: this.job.id,
            database: database,
          ),
        )
      ],
      child: Scaffold(
        body: Body(),
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, kTextTabBarHeight),
          child: Builder(
            builder: (BuildContext context) {
              return AppBar(
                title: Text('Entries'),
                actions: [
                  TextButton(
                    onPressed: () => updateEntry(context),
                    child: Text(
                      entry != null ? 'Done' : 'Create',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
