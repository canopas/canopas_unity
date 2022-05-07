import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
abstract class AppState with _$AppState {
  const factory AppState.homeState() = HomeState;

  const factory AppState.employeeDetailState({required int id}) =
      EmployeeDetailState;

  const factory AppState.leaveState() = LeaveState;

  const factory AppState.userAllLeaveState() = UserAllLeaveState;

  const factory AppState.userUpcomingLeaveState() = UserUpcomingLeaveState;

  const factory AppState.leaveRequestState() = LeaveRequestState;

  const factory AppState.settingsState() = SettingsState;

  const factory AppState.teamLeavesState() = TeamLeavesState;
}
