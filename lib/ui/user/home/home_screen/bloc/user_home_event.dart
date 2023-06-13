import '../../../../../data/model/leave/leave.dart';

abstract class UserHomeEvent {}

class UpdateLeaveRequest extends UserHomeEvent {
  final List<Leave> requests;

  UpdateLeaveRequest(this.requests);
}

class ShowError extends UserHomeEvent {
  final String error;
  ShowError(this.error);
}

class ShowLoading extends UserHomeEvent {}
