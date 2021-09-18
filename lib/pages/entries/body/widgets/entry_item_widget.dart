import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/model/entry/entry.dart';
import 'package:udemy_timer_tracker/services/firestore_database.dart';

class EntryItemWidget extends StatelessWidget {
  final Entry entry;

  const EntryItemWidget({Key? key, required this.entry}) : super(key: key);

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
      child: Container(
        child: Padding(
          child: Row(children: [

          ],),
          padding: EdgeInsets.all(
            8,
          ),
        ),
      ),
    );
  }
}
