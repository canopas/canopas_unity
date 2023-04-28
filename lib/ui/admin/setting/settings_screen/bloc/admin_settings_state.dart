import 'package:equatable/equatable.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';

import '../../../../../data/model/employee/employee.dart';

class AdminSettingsState extends Equatable {
  final String? error;
  final Status status;
  final Employee currentEmployee;

  const AdminSettingsState({
    this.error,
    this.status = Status.initial,
    required this.currentEmployee,
  });

  copyWith({String? error, Status? status, Employee? currentEmployee}) =>
      AdminSettingsState(
        error: error,
        status: status ?? this.status,
        currentEmployee: currentEmployee ?? this.currentEmployee,
      );

  @override
  List<Object?> get props => [error, status, currentEmployee];
}
