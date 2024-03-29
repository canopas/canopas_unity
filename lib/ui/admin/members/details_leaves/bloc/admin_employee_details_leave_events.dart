import 'package:equatable/equatable.dart';

abstract class AdminEmployeeDetailsLeavesEvents extends Equatable {}

class LoadInitialLeaves extends AdminEmployeeDetailsLeavesEvents {
  LoadInitialLeaves({required this.employeeId});

  final String employeeId;

  @override
  List<Object?> get props => [employeeId];
}

class FetchMoreUserLeaves extends AdminEmployeeDetailsLeavesEvents {
  @override
  List<Object?> get props => [];
}

class UpdateLeave extends AdminEmployeeDetailsLeavesEvents {
  final String leaveId;

  UpdateLeave({required this.leaveId});

  @override
  List<Object?> get props => [leaveId];
}
