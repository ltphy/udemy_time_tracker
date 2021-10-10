import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/common_widgets/list_items_builder.dart';
import 'package:udemy_timer_tracker/model/job.dart';
import 'package:udemy_timer_tracker/pages/entries/entries.dart';
import 'package:udemy_timer_tracker/pages/home/body/widgets/job_list_widget.dart';
import 'package:udemy_timer_tracker/services/dialog_services.dart';
import 'package:udemy_timer_tracker/services/firestore_database.dart';

class Body extends StatelessWidget {
  Future<void> deleteJob(BuildContext context, Job job) async {
    final firestoreDatabase = Provider.of<Database>(context, listen: false);
    try {
      await firestoreDatabase.deleteJob(job);
    } on FirebaseException catch (error) {
      DialogService.instance.showExceptionDialog(context, error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final firestoreDatabase = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>?>(
      stream: firestoreDatabase.streamJobs(),
      builder: (BuildContext context, AsyncSnapshot<List<Job>?> snapshot) {
        return ListItemsBuilder<Job>(
          itemWidgetBuilder: (BuildContext context, Job value) {
            return Dismissible(
              key: Key(value.id),
              onDismissed: (DismissDirection direction) async =>
                  await deleteJob(context, value),
              background: Container(
                color: Colors.red,
              ),
              direction: DismissDirection.endToStart,
              child: JobItemWidget(
                job: value,
                onPress: () => Entries.show(
                  context,
                  database: firestoreDatabase,
                  job: value,
                ),
              ),
            );
          },
          snapshot: snapshot,
        );
      },
    );
  }
}
