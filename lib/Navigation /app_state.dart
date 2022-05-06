import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
abstract class AppState with _$AppState {
  const factory AppState.home() = Home;

  const factory AppState.employeeDetail({required int id}) = EmployeeDetail;

  const factory AppState.leave() = Leave;

  const factory AppState.userAllLeave() = UserAllLeave;

  const factory AppState.userUpcomingLeave() = UserUpcomingLeave;

  const factory AppState.leaveRequest() = LeaveRequest;

  const factory AppState.settings() = Settings;
}
