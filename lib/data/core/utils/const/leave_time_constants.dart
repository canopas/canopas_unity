import 'package:projectunity/data/model/leave/leave.dart';

Map<LeaveDayDuration, String> dayLeaveTime = Map.unmodifiable({
  LeaveDayDuration.fullLeave: "Full",
  LeaveDayDuration.firstHalfLeave: "First-half",
  LeaveDayDuration.secondHalfLeave: "Second-half",
  LeaveDayDuration.noLeave: "No Leave",
});