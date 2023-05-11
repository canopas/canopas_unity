import 'package:equatable/equatable.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import '../../../../../data/model/leave/leave.dart';

class AdminEmployeeDetailsLeavesState extends Equatable {
  final List<Leave> leaves;
  final Status status;
  final String? error;

  const AdminEmployeeDetailsLeavesState({
    this.error,
    this.leaves = const [],
    this.status = Status.initial,
  });

  copyWith({
    List<Leave>? leaves,
    Status? status,
    String? error,
  }) =>
      AdminEmployeeDetailsLeavesState(
        error: error,
        leaves: leaves ?? this.leaves,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [error, leaves, status];
}
