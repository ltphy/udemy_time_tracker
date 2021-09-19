import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:udemy_timer_tracker/services/format.dart';

part 'entry.g.dart';

@JsonSerializable()
class Entry {
  final String id;
  final String jobId;
  DateTime start;
  DateTime end;
  String? comment;

  Entry({
    required this.id,
    required this.jobId,
    required this.start,
    required this.end,
    this.comment,
  });

  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);

  Map<String, dynamic> toJson() => _$EntryToJson(this);

  double get durationHours => end.difference(start).inMinutes / 60;

  String get weekDay => Format.instance.dayOfWeek(start);

  String get date => Format.instance.date(start);

  String get hours => Format.instance.hours(durationHours);

  String wage(double ratePerHour) {
    return Format.instance.currency(ratePerHour * this.durationHours);
  }

  String startTime(BuildContext context) {
    return TimeOfDay.fromDateTime(start).format(context);
  }

  String endTime(BuildContext context) {
    return TimeOfDay.fromDateTime(end).format(context);
  }
}
