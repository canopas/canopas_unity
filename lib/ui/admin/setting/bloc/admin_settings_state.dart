import 'package:equatable/equatable.dart';
import '../../../../data/model/employee/employee.dart';

enum AdminSettingsStatus { initial, loading, success, failure }

class AdminSettingsState extends Equatable {
  final String? error;
  final AdminSettingsStatus status;
  final Employee currentEmployee;

  const AdminSettingsState({
    this.error,
    this.status = AdminSettingsStatus.initial,
    required this.currentEmployee,
  });

  copyWith(
          {String? error,
          AdminSettingsStatus? status,
          Employee? currentEmployee}) =>
      AdminSettingsState(
        error: error,
        status: status ?? this.status,
        currentEmployee: currentEmployee ?? this.currentEmployee,
      );

  @override
  List<Object?> get props => [error, status, currentEmployee];
}
