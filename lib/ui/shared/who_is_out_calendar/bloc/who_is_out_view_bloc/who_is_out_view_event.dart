import 'package:equatable/equatable.dart';
import '../../../../../model/leave_application.dart';

abstract class WhoIsOutViewEvent extends Equatable{}


class WhoIsOutViewInitialLoadEvent extends WhoIsOutViewEvent {
  @override
  List<Object?> get props => [];

}

class GetSelectedDateLeavesEvent extends WhoIsOutViewEvent {
  final DateTime selectedDate;
  GetSelectedDateLeavesEvent(this.selectedDate);
  @override
  List<Object?> get props => [selectedDate];
}

class WhoIsOutLeaveCardTapEvent extends WhoIsOutViewEvent {
  final LeaveApplication leaveApplication;
  WhoIsOutLeaveCardTapEvent(this.leaveApplication);
  @override
  List<Object?> get props => [leaveApplication];
}