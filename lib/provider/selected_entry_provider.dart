import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/model/entry/entry.dart';
import 'package:udemy_timer_tracker/pages/job_updater_widget/body/body.dart';
import 'package:udemy_timer_tracker/services/firestore_database.dart';

class SelectedEntryProvider extends ChangeNotifier {
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? comment;
  final String jobId;
  late final Database database;
  Entry? entry;
  bool loading;

  SelectedEntryProvider({
    required this.entry,
    required this.jobId,
    required this.database,
    this.loading = false,
  }) {
    final currentDate = this.entry?.start ?? DateTime.now();

    this.startDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    this.startTime = TimeOfDay.fromDateTime(currentDate);
    final endCurrentDate = this.entry?.end ?? DateTime.now();
    this.endDate =
        DateTime(endCurrentDate.year, endCurrentDate.month, endCurrentDate.day);
    this.endTime = TimeOfDay.fromDateTime(endCurrentDate);
  }

  DateTime get startDateTime => DateTime(
        this.startDate!.year,
        this.startDate!.month,
        this.startDate!.day,
        this.startTime!.hour,
        this.startTime!.minute,
      );

  DateTime get endDateTime => DateTime(
        this.endDate!.year,
        this.endDate!.month,
        this.endDate!.day,
        this.endTime!.hour,
        this.endTime!.minute,
      );

  Future<void> updateEntryInDatabase() async {
    try {
      String entryId = this.entry?.id ?? documentIdFromCurrentDate();
      if (startTime == null) return;
      DateTime startDate = startDateTime;
      DateTime endDate = endDateTime;
      Entry entry = Entry(
        jobId: jobId,
        end: endDate,
        start: startDate,
        comment: this.comment,
        id: entryId,
      );
      await this.database.updateEntry(entry);
    } catch (error) {
      rethrow;
    }
  }

  void updateLoading() {
    this.loading = !loading;
    notifyListeners();
  }

  void updateEntry({
    DateTime? startDate,
    DateTime? endDate,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    String? comment,
  }) {
    this.startDate = startDate ?? this.startDate;
    this.endDate = endDate ?? this.endDate;
    this.startTime = startTime ?? this.startTime;
    this.endTime = endTime ?? this.endTime;
    notifyListeners();
  }

  void updateComment(String comment) {
    this.comment = comment;
  }

  double get duration =>
      this.endDateTime.difference(startDateTime).inMinutes / 60;
}
