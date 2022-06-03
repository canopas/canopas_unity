// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveDetail _$LeaveDetailFromJson(Map<String, dynamic> json) => LeaveDetail(
      all: (json['all'] as List<dynamic>)
          .map((e) => Leave.fromJson(e as Map<String, dynamic>))
          .toList(),
      upcoming: (json['upcoming'] as List<dynamic>)
          .map((e) => Leave.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LeaveDetailToJson(LeaveDetail instance) =>
    <String, dynamic>{
      'all': instance.all,
      'upcoming': instance.upcoming,
    };
