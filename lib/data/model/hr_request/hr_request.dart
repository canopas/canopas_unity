import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:projectunity/data/core/converters%20/date_converter.dart';

part 'hr_request.g.dart';

@JsonSerializable(
    fieldRename: FieldRename.snake,
    includeIfNull: false,
    converters: [DateTimeConverter()])
class HrRequest extends Equatable {
  final String id;
  final String uid;
  final DateTime requestedAt;
  final HrRequestType type;
  final String description;
  final HrRequestStatus status;

  HrRequest({
    required this.id,
    required this.type,
    required this.uid,
    required this.description,
    this.status = HrRequestStatus.pending,
  }) : requestedAt = DateTime.now();

  factory HrRequest.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    Map<String, dynamic>? data = snapshot.data();
    return HrRequest.fromJson(data!);
  }

  factory HrRequest.fromJson(Map<String, dynamic> map) =>
      _$HrRequestFromJson(map);

  Map<String, dynamic> toFireStore() => _$HrRequestToJson(this);

  @override
  List<Object?> get props => [id, type, uid, description];
}

@JsonEnum(valueField: 'value')
enum HrRequestType {
  employeeRelations(1),
  training(2),
  payroll(3),
  timeAndAttendance(4),
  hrBenefits(5),
  technicalIssue(6),
  other(7);

  final int value;

  const HrRequestType(this.value);
}

@JsonEnum(valueField: 'value')
enum HrRequestStatus {
  pending(1),
  done(2);

  final int value;

  const HrRequestStatus(this.value);
}
