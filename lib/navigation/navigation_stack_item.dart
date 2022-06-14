import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigation_stack_item.freezed.dart';

@freezed
class NavigationStackItem with _$NavigationStackItem {
  const factory NavigationStackItem.homeState() = HomeState;

  const factory NavigationStackItem.adminHomeState() = AdminHomeState;

  const factory NavigationStackItem.employeeDetailState({required String id}) =
      EmployeeDetailState;

  const factory NavigationStackItem.leaveState() = LeaveState;

  const factory NavigationStackItem.userAllLeaveState() = UserAllLeaveState;

  const factory NavigationStackItem.userUpcomingLeaveState() =
      UserUpcomingLeaveState;

  const factory NavigationStackItem.leaveRequestState() = LeaveRequestState;

  const factory NavigationStackItem.settingsState() = SettingsState;

  const factory NavigationStackItem.teamLeavesState() = TeamLeavesState;

  const factory NavigationStackItem.addMemberState() = AddMemberState;
}
