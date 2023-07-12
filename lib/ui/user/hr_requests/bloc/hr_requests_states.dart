import 'package:equatable/equatable.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/model/hr_request/hr_request.dart';

class HrRequestsState extends Equatable {
  final String? error;
  final List<HrRequest> hrServiceDeskRequests;
  final Status status;

  const HrRequestsState(
      {this.error,
      this.hrServiceDeskRequests = const [],
      this.status = Status.initial});

  HrRequestsState copyWith({
    String? error,
    Status? status,
    List<HrRequest>? hrServiceDeskRequests,
  }) =>
      HrRequestsState(
          status: status ?? this.status,
          error: error,
          hrServiceDeskRequests:
              hrServiceDeskRequests ?? this.hrServiceDeskRequests);

  @override
  List<Object?> get props => [hrServiceDeskRequests, status, error];
}
