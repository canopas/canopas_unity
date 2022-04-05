import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_request_data.g.dart';

@JsonSerializable()
class LeaveRequestData{
  @JsonKey(name: 'start_date')
  int startDate;
  @JsonKey(name:'end_date')
  int endDate;
  @JsonKey(name: 'total_leaves')
  int totalLeaves;
  String reason;
  @JsonKey(name: 'emergency_contact_person')
  int emergencyContactPerson;

  LeaveRequestData({
   required this.startDate,
    required this.endDate,
    required this.totalLeaves,
    required this.reason,
    required this.emergencyContactPerson
});

  Map<String,dynamic> leaveRequestDataToJson(LeaveRequestData leaveRequestData)=> _$LeaveRequestDataToJson(this);

}