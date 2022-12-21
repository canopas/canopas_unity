import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:projectunity/model/leave_application.dart';
part 'nav_stack_item.freezed.dart';

@freezed
class NavStackItem with _$NavStackItem {
  /* -- Common screens --*/
  const factory NavStackItem.onBoard() = OnboardNavStackItem;

  const factory NavStackItem.whoIsOutCalendarState() = WhoIsOutCalendarState;

  const factory NavStackItem.login() = LoginNavStackItem;

  /* -- Admin screens --*/
  const factory NavStackItem.adminHome() = AdminHomeNavStackItem;

  const factory NavStackItem.adminSettingsState() = AdminSettingsState;

  const factory NavStackItem.paidLeaveSettingsState() = PaidLeaveSettingsState;

  const factory NavStackItem.adminLeaveDetailState(LeaveApplication leaveApplication) = AdminLeaveDetailState;

  // Admin employee screens

  const factory NavStackItem.addMemberState() = AddMemberState;

  const factory NavStackItem.adminEmployeeListState() =
      AdminEmployeeListStackItem;

  const factory NavStackItem.employeeDetailState({required String id}) =
      EmployeeDetailState;

  /* -- Employee screens --*/
  const factory NavStackItem.employeeLeaveDetailState(LeaveApplication leaveApplication) = EmployeeLeaveDetailState;

  const factory NavStackItem.employeeHome() = EmployeeHomeNavStackItem;

  const factory NavStackItem.employeeSettingsState() = EmployeeSettingsState;

  const factory NavStackItem.employeeAllLeavesScreenState() = EmployeeAllLeavesScreenState;

  const factory NavStackItem.employeeRequestedLeavesScreenState() = EmployeeRequestedLeavesScreenState;

  const factory NavStackItem.employeeUpcomingLeavesScreenState() = EmployeeUpcomingLeavesScreenState;

  const factory NavStackItem.leaveRequestState() = LeaveRequestState;

  const factory NavStackItem.userLeaveCalendarState({required String userId}) = UserLeaveCalendarState;
}
