import 'package:equatable/equatable.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/model/hr_request/hr_request.dart';

class HrRequestFormState extends Equatable {
  final HrRequestType? type;
  final String description;
  final Status status;
  final String? error;

  const HrRequestFormState({
    this.type,
    this.description = "",
    this.status = Status.initial,
    this.error,
  });

  HrRequestFormState copyWith(
          {HrRequestType? type,
          String? description,
          Status? status,
          String? error}) =>
      HrRequestFormState(
        error: error,
        status: status ?? this.status,
        description: description ?? this.description,
        type: type ?? this.type,
      );

  bool get isProvidedDataValid => type != null && description.trim().isNotEmpty;

  @override
  List<Object?> get props => [type, description, status, error];
}
