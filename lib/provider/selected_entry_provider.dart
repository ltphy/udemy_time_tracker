import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:udemy_timer_tracker/model/entry/entry.dart';
import 'package:udemy_timer_tracker/services/firestore_database.dart';

class SelectedEntryProvider extends ChangeNotifier {
  Entry entry;
  late final Database database;
  bool loading;
  final formKey = GlobalKey<FormState>();

  SelectedEntryProvider({
    required this.entry,
    required this.database,
    this.loading = false,
  });

  Future<void> updateEntryInDatabase() async {
    try {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        this.updateWith(loading: true);
        await this.database.updateEntry(this.entry);
      }
    } catch (error) {
      rethrow;
    }
  }

  void updateWith({bool? loading, Entry? entry}) {
    this.loading = loading ?? this.loading;
    this.entry = entry ?? this.entry;
    notifyListeners();
  }

  void updateEntry({
    String? comment,
    DateTime? start,
    DateTime? end,
  }) {
    this.entry.comment = comment ?? this.entry.comment;
    this.entry.start = start ?? this.entry.start;
    this.entry.end = end ?? this.entry.end;
  }
}
