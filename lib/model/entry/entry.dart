import 'package:json_annotation/json_annotation.dart';

part 'entry.g.dart';

@JsonSerializable()
class Entry {
  final String id;
  final String jobId;
  final DateTime start;
  final DateTime end;
  final String? comment;

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
}
