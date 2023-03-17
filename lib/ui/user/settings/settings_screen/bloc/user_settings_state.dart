import 'package:equatable/equatable.dart';
import '../../../../../data/model/employee/employee.dart';

enum UserSettingsStatus { initial, loading, success, failure }

class UserSettingsState extends Equatable {
  final String? error;
  final UserSettingsStatus status;
  final Employee currentEmployee;

  const UserSettingsState({
    this.error,
    this.status = UserSettingsStatus.initial,
    required this.currentEmployee,
  });

  copyWith(
          {String? error,
          UserSettingsStatus? status,
          Employee? currentEmployee}) =>
      UserSettingsState(
        error: error,
        status: status ?? this.status,
        currentEmployee: currentEmployee ?? this.currentEmployee,
      );

  @override
  List<Object?> get props => [error, status, currentEmployee];
}
