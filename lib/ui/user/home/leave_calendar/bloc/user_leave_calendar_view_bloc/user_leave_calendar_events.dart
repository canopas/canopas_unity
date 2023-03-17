import 'package:equatable/equatable.dart';
import '../../../../../../data/model/leave_application.dart';

abstract class UserLeaveCalendarEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserLeaveCalendarInitialLoadEvent extends UserLeaveCalendarEvent {
  final String userid;

  UserLeaveCalendarInitialLoadEvent(this.userid);
}

class DateRangeSelectedEvent extends UserLeaveCalendarEvent {
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? selectedDate;

  DateRangeSelectedEvent(this.startDate, this.endDate, this.selectedDate);
}

class RemoveOrCancelLeaveApplication extends UserLeaveCalendarEvent {
  final LeaveApplication leaveApplication;

  RemoveOrCancelLeaveApplication(this.leaveApplication);
}
