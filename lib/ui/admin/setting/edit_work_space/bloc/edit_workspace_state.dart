import 'package:equatable/equatable.dart';

enum EditWorkspaceStatus { initial, loading, failure, success }

class EditWorkspaceState extends Equatable {
  final EditWorkspaceStatus status;
  final String? error;
  final bool nameIsValid;
  final bool yearlyPaidTimeOffIsValid;

  const EditWorkspaceState(
      {this.status = EditWorkspaceStatus.initial,
      this.error,
      this.nameIsValid = true,
      this.yearlyPaidTimeOffIsValid = true});

  copyWith(
          {String? error,
          EditWorkspaceStatus? status,
          bool? nameIsValid,
          bool? yearlyPaidTimeOffIsValid}) =>
      EditWorkspaceState(
          error: error,
          status: status ?? this.status,
          nameIsValid: nameIsValid ?? this.nameIsValid,
          yearlyPaidTimeOffIsValid:
              yearlyPaidTimeOffIsValid ?? this.yearlyPaidTimeOffIsValid);

  bool get isValid => nameIsValid && yearlyPaidTimeOffIsValid;

  @override
  List<Object?> get props => [status,error,nameIsValid,yearlyPaidTimeOffIsValid];
}
