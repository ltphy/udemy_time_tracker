import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/common_widgets/list_items_builder.dart';
import 'package:udemy_timer_tracker/model/entry/entry.dart';
import 'package:udemy_timer_tracker/model/job.dart';
import 'package:udemy_timer_tracker/pages/entries/body/widgets/entry_item_widget.dart';
import 'package:udemy_timer_tracker/services/firestore_database.dart';

class Body extends StatelessWidget {
  final Job job;

  const Body({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Database database = Provider.of(context, listen: false);
    return StreamBuilder<List<Entry>?>(
      stream: database.streamEntries(job: job),
      builder: (_, snapshot) {
        return ListItemsBuilder<Entry>(
          itemWidgetBuilder: (context, entry) {
            return EntryItemWidget(
              entry: entry,
              job: this.job,
            );
          },
          snapshot: snapshot,
        );
      },
    );
  }
}
