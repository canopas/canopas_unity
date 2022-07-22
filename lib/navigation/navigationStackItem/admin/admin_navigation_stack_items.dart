import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:projectunity/navigation/navigationStackItem/navigationStack/navigation_stack_item.dart';

import '../../../model/employee_leave.dart';

part 'admin_navigation_stack_items.freezed.dart';

@freezed
class AdminNavigationStackItem
    with _$AdminNavigationStackItem
    implements NavigationStackItem {
  const factory AdminNavigationStackItem.adminHomeState() = AdminHomeState;

  const factory AdminNavigationStackItem.employeeDetailState(
      {required String id}) = EmployeeDetailState;

  const factory AdminNavigationStackItem.settingsState() = SettingsState;

  const factory AdminNavigationStackItem.staffState() = StaffState;

  const factory AdminNavigationStackItem.addMemberState() = AddMemberState;

  const factory AdminNavigationStackItem.adminLeaveRequestState() =
      AdminLeaveRequestState;

  const factory AdminNavigationStackItem.adminLeaveRequestDetailState(
      EmployeeLeave employeeLeave) = AdminLeaveRequestDetailState;
}
