import 'package:freezed_annotation/freezed_annotation.dart';

import 'leave.dart';

part 'leave_detail.g.dart';

@JsonSerializable()
class LeaveDetail {
  List<Leave> all;
  List<Leave> upcoming;

  LeaveDetail({required this.all, required this.upcoming});

  factory LeaveDetail.fromJson(Map<String, dynamic> map) =>
      _$LeaveDetailFromJson(map);
}
