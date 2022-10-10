import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:projectunity/model/leave_application.dart';

import '../model/leave/leave.dart';

part 'nav_stack_item.freezed.dart';

@freezed
class NavStackItem with _$NavStackItem {
  /* -- Common screens --*/
  const factory NavStackItem.onBoard() = OnboardNavStackItem;

  const factory NavStackItem.login() = LoginNavStackItem;

  /* -- Admin screens --*/
  const factory NavStackItem.adminHome() = AdminHomeNavStackItem;

  const factory NavStackItem.adminSettingsState() = AdminSettingsState;

  const factory NavStackItem.paidLeaveSettingsState() = PaidLeaveSettingsState;

  // Admin employee screens
  const factory NavStackItem.addMemberState() = AddMemberState;

  const factory NavStackItem.adminEmployeeListState() =
      AdminEmployeeListStackItem;

  const factory NavStackItem.employeeDetailState({required String id}) =
      EmployeeDetailState;

  // Admin leave screens
  const factory NavStackItem.adminLeaveAbsenceState() = AdminLeaveAbsenceState;

  const factory NavStackItem.adminLeaveRequestDetailState(
      LeaveApplication employeeLeave) = AdminLeaveRequestDetailState;

  /* -- Employee screens --*/
  const factory NavStackItem.employeeHome() = EmployeeHomeNavStackItem;

  const factory NavStackItem.employeeSettingsState() = EmployeeSettingsState;

  const factory NavStackItem.userAllLeaveState() = UserAllLeaveState;

  const factory NavStackItem.userUpcomingLeaveState() = UserUpcomingLeaveState;

  const factory NavStackItem.leaveRequestState() = LeaveRequestState;

  const factory NavStackItem.requestedLeaves() = RequestedLeavesState;

  const factory NavStackItem.leaveDetailState(Leave leave) = LeaveDetailState;
}
