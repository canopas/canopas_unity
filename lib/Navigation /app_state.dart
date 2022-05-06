import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
abstract class AppState with _$AppState {
  const factory AppState.Home() = home;

  const factory AppState.EmployeeDetail({required int id}) = employeeDetail;

  const factory AppState.Leave() = leave;

  const factory AppState.UserAllLeave() = userAllLeave;

  const factory AppState.UserUpcomingLeave() = userUpcomingLeave;

  const factory AppState.LeaveRequest() = leaveRequest;

  const factory AppState.Settings() = settings;
}
