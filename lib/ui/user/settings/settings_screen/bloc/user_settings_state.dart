import 'package:equatable/equatable.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/model/employee/employee.dart';

class UserSettingsState extends Equatable {
  final String? error;
  final Status status;
  final Employee currentEmployee;

  const UserSettingsState({
    this.error,
    this.status = Status.initial,
    required this.currentEmployee,
  });

  copyWith({String? error, Status? status, Employee? currentEmployee}) =>
      UserSettingsState(
        error: error,
        status: status ?? this.status,
        currentEmployee: currentEmployee ?? this.currentEmployee,
      );

  @override
  List<Object?> get props => [error, status, currentEmployee];
}
