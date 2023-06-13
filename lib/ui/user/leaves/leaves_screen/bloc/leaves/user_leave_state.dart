import 'package:equatable/equatable.dart';
import '../../../../../../data/core/utils/bloc_status.dart';
import '../../../../../../data/model/leave/leave.dart';

class UserLeaveState extends Equatable {
  final List<Leave> leaves;
  final String? error;
  final Status status;
  final int selectedYear;

  UserLeaveState(
      {int? selectedYear,
      this.leaves = const [],
      this.status = Status.loading,
      this.error})
      : selectedYear = selectedYear ?? DateTime.now().year;

  UserLeaveState copyWith({
    int? selectedYear,
    List<Leave>? leaves,
    String? error,
    Status? status,
  }) =>
      UserLeaveState(
        selectedYear: selectedYear ?? this.selectedYear,
        status: status ?? this.status,
        leaves: leaves ?? this.leaves,
        error: error,
      );

  @override
  List<Object?> get props => [leaves, error, status, selectedYear];
}
