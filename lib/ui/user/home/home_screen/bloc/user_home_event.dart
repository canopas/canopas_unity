import 'package:equatable/equatable.dart';

abstract class UserHomeEvent extends Equatable {}


class UserHomeFetchLeaveRequest extends UserHomeEvent {
  UserHomeFetchLeaveRequest();

  @override
  List<Object?> get props => [];
}
