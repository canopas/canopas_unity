import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:projectunity/data/core/converters%20/date_converter.dart';

part 'hr_desk_request.g.dart';

@JsonSerializable(
    fieldRename: FieldRename.snake,
    includeIfNull: false,
    converters: [DateTimeConverter()])
class HrDeskRequest extends Equatable {
  final String id;
  final String requestBy;
  final DateTime requestedAt;
  final HRDeskRequestType type;
  final String description;
  final HRDeskRequestStatus status;

  HrDeskRequest({
    required this.id,
    required this.type,
    required this.requestBy,
    required this.description,
    this.status = HRDeskRequestStatus.pending,
  }) : requestedAt = DateTime.now();

  factory HrDeskRequest.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    Map<String, dynamic>? data = snapshot.data();
    return HrDeskRequest.fromJson(data!);
  }

  factory HrDeskRequest.fromJson(Map<String, dynamic> map) =>
      _$HrDeskRequestFromJson(map);

  Map<String, dynamic> toFireStore() => _$HrDeskRequestToJson(this);

  @override
  List<Object?> get props => [id, type, requestBy, description];
}

@JsonEnum(valueField: 'value')
enum HRDeskRequestType {
  employeeRelations(1),
  training(2),
  payroll(3),
  timeAndAttendance(4),
  hrBenefits(5),
  technicalIssue(6),
  other(7);

  final int value;

  const HRDeskRequestType(this.value);
}

@JsonEnum(valueField: 'value')
enum HRDeskRequestStatus {
  pending(1),
  done(2);

  final int value;

  const HRDeskRequestStatus(this.value);
}
