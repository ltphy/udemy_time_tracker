// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Job _$JobFromJson(Map<String, dynamic> json) => Job(
      name: json['name'] as String?,
      ratePerHour: (json['ratePerHour'] as num?)?.toDouble(),
      id: json['id'] as String,
    );

Map<String, dynamic> _$JobToJson(Job instance) => <String, dynamic>{
      'name': instance.name,
      'ratePerHour': instance.ratePerHour,
      'id': instance.id,
    };
