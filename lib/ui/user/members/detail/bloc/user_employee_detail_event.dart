import 'package:equatable/equatable.dart';

abstract class UserEmployeeDetailEvent extends Equatable {}

class UserEmployeeDetailFetchEvent extends UserEmployeeDetailEvent {
  final String employeeId;
  UserEmployeeDetailFetchEvent({required this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}
