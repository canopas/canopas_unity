import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave.g.dart';

@JsonSerializable()
class Leave {
  int id;
  @JsonKey(name: 'employee_id')
  int employeeId;
  @JsonKey(name: 'start_date')
  int startDate;
  @JsonKey(name: 'end_date')
  int endDate;
  @JsonKey(name: 'total_leaves')
  double totalLeaves;
  String reason;
  @JsonKey(name: 'emergency_contact_person')
  int emergencyContactPerson;
  int status;

  Leave(
      {required this.id,
      required this.employeeId,
      required this.startDate,
      required this.endDate,
      required this.totalLeaves,
      required this.reason,
      required this.emergencyContactPerson,
      required this.status});

  factory Leave.fromJson(Map<String, dynamic> map) => _$LeaveFromJson(map);
}
