import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/common_widgets/list_items_builder.dart';
import 'package:udemy_timer_tracker/pages/home/body/widgets/job_list_widget.dart';
import 'package:udemy_timer_tracker/pages/home/screens/job_updater_widget.dart';
import 'package:udemy_timer_tracker/pages/sign_in_page/model/job.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/services/firestore_database.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreDatabase = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>?>(
      stream: firestoreDatabase.streamJobs(),
      builder: (BuildContext context, AsyncSnapshot<List<Job>?> snapshot) {
        return ListItemsBuilder<Job>(
          itemWidgetBuilder: (value) {
            return JobItemWidget(
              job: value,
              onPress: () => JobUpdaterWidget.show(
                context,
                database: firestoreDatabase,
                job: value,
              ),
              onDismissed: (DismissDirection dismiss) async {
                if (dismiss == DismissDirection.endToStart) {
                  await firestoreDatabase.deleteJob(value);
                }
              },
            );
          },
          snapshot: snapshot,
        );
      },
    );
  }
}
