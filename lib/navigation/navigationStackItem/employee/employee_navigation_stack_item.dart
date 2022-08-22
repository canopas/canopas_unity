import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:projectunity/navigation/navigationStackItem/navigationStack/navigation_stack_item.dart';

import '../../../model/leave/leave.dart';

part 'employee_navigation_stack_item.freezed.dart';

@freezed
class EmployeeNavigationStackItem
    with _$EmployeeNavigationStackItem
    implements NavigationStackItem {
  const factory EmployeeNavigationStackItem.employeeHomeState() =
      EmployeeHomeState;

  const factory EmployeeNavigationStackItem.staffState() = StaffState;

  const factory EmployeeNavigationStackItem.userAllLeaveState() =
      UserAllLeaveState;

  const factory EmployeeNavigationStackItem.userUpcomingLeaveState() =
      UserUpcomingLeaveState;

  const factory EmployeeNavigationStackItem.leaveRequestState() =
      LeaveRequestState;

  const factory EmployeeNavigationStackItem.employeeSettingsState() = EmployeeSettingsState;

  const factory EmployeeNavigationStackItem.requestedLeaves() =
      RequestedLeavesState;

  const factory EmployeeNavigationStackItem.leaveDetailState(Leave leave) =
      LeaveDetailState;
}
