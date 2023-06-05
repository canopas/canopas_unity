import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave.g.dart';

@JsonSerializable(includeIfNull: false)
class Leave extends Equatable {
  @JsonKey(name: 'leave_id')
  final String leaveId;
  final String uid;
  @JsonKey(name: 'type')
  final LeaveType type;
  @JsonKey(name: 'start_date', fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime startDate;
  @JsonKey(name: 'end_date', fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime endDate;
  final double total;
  final String reason;
  final LeaveStatus status;
  final String? response;
  @JsonKey(name: 'applied_on', fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime appliedOn;
  @JsonKey(name: 'per_day_duration')
  final List<LeaveDayDuration> perDayDuration;

  const Leave(
      {required this.leaveId,
      required this.uid,
      required this.type,
      required this.startDate,
      required this.endDate,
      required this.total,
      required this.reason,
      required this.status,
      required this.appliedOn,
      required this.perDayDuration,
      this.response});

  static int _dateToJson(DateTime value) => value.millisecondsSinceEpoch;

  static DateTime _dateFromJson(int value) =>
      DateTime.fromMillisecondsSinceEpoch(value);

  factory Leave.fromFireStore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    Map<String, dynamic>? data = snapshot.data();
    return Leave.fromJson(data!);
  }

  factory Leave.fromJson(Map<String, dynamic> map) => _$LeaveFromJson(map);

  Map<String, dynamic> toFireStore(Leave instance) => _$LeaveToJson(instance);

  @override
  List<Object?> get props => [
        leaveId,
        uid,
        type,
        startDate,
        endDate,
        total,
        reason,
        status,
        appliedOn,
        response
      ];
}

@JsonEnum(valueField: 'value')
enum LeaveType {
  casualLeave(0),
  sickLeave(1),
  annualLeave(2),
  paternityLeave(3),
  maternityLeave(4),
  marriageLeave(5),
  bereavementLeave(6);

  final int value;

  const LeaveType(this.value);
}

@JsonEnum(valueField: 'value')
enum LeaveStatus {
  pending(1),
  approved(2),
  rejected(3),
  cancelled(4);

  final int value;

  const LeaveStatus(this.value);
}

@JsonEnum(valueField: 'value')
enum LeaveDayDuration {
  noLeave(0),
  firstHalfLeave(1),
  secondHalfLeave(2),
  fullLeave(3);

  final int value;

  const LeaveDayDuration(this.value);
}
