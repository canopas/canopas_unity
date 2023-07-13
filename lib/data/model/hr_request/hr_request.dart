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
  final String? response;

  const HrRequest({
    required this.id,
    required this.type,
    required this.uid,
    required this.description,
    required this.requestedAt,
    this.response,
    this.status = HrRequestStatus.pending,
  });

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
  employeeRelations(0),
  training(1),
  payroll(2),
  timeAndAttendance(3),
  hrBenefits(4),
  technicalIssue(5),
  other(6);

  final int value;

  const HrRequestType(this.value);
}

@JsonEnum(valueField: 'value')
enum HrRequestStatus {
  pending(0),
  resolved(1),
  canceled(2);

  final int value;

  const HrRequestStatus(this.value);
}
