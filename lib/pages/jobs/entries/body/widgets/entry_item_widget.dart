import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/model/entry/entry.dart';
import 'package:udemy_timer_tracker/model/job.dart';
import 'package:udemy_timer_tracker/pages/jobs/entry_page/entry_page.dart';
import 'package:udemy_timer_tracker/services/firestore_database.dart';

class EntryItemWidget extends StatelessWidget {
  final Entry entry;
  final Job job;

  const EntryItemWidget({
    Key? key,
    required this.entry,
    required this.job,
  }) : super(key: key);

  Future<void> removeEntry(BuildContext context) async {
    Database database = Provider.of<Database>(context, listen: false);
    await database.deleteEntry(entry);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(entry.id),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection dismissDirection) => removeEntry(context),
      child: InkWell(
        onTap: () {
          Database database = Provider.of<Database>(context, listen: false);
          EntryPage.show(
            context,
            database: database,
            entry: entry,
            job: job,
          );
        },
        child: Container(
          padding: EdgeInsets.all(
            8,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.5,
                color: Colors.grey,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          entry.weekDay,
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          entry.date,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Expanded(child: SizedBox()),
                        Text(
                          entry.wage(this.job.ratePerHour),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                  color: Theme.of(context).indicatorColor),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${entry.startTime(context)} - ${entry.endTime(context)}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontSize: 18),
                        ),
                        Expanded(child: SizedBox()),
                        Text(entry.hours,
                            style: Theme.of(context).textTheme.bodyText1),
                      ],
                    ),
                    Text(entry.comment ?? '',
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              ),
              Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
