import 'package:json_annotation/json_annotation.dart';

part 'job.g.dart';

@JsonSerializable()
class Job {
  String? name;
  double ratePerHour;
  String id;

  Job({
    this.name,
    this.ratePerHour = 0.0,
    required this.id,
  });

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

  Map<String, dynamic> toJson() => _$JobToJson(this);
}
