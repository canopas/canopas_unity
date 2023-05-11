import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave.g.dart';

const int pendingLeaveStatus = 1;
const int approveLeaveStatus = 2;
const int rejectLeaveStatus = 3;

@JsonSerializable(includeIfNull: false)
class Leave extends Equatable {
  @JsonKey(name: 'leave_id')
  final String leaveId;
  final String uid;
  @JsonKey(name: 'type')
  final int type;
  @JsonKey(name: 'start_date')
  final int startDate;
  @JsonKey(name: 'end_date')
  final int endDate;
  final double total;
  final String reason;
  final int status;
  final String? response;
  @JsonKey(name: 'applied_on')
  final int appliedOn;
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

enum LeaveDayDuration {
  @JsonValue(0)
  noLeave(0),
  @JsonValue(1)
  firstHalfLeave(1),
  @JsonValue(2)
  secondHalfLeave(2),
  @JsonValue(3)
  fullLeave(3);

  final int value;

  const LeaveDayDuration(this.value);
}