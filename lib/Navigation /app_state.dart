import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
abstract class AppState with _$AppState {
  const factory AppState.home() = Home;

  const factory AppState.employeeDetail({required int employeeId}) =
      EmployeeDetail;

  const factory AppState.leave() = Leave;

  const factory AppState.leaveRequestForm() = LeaveRequestForm;

  const factory AppState.setting() = Setting;
}
