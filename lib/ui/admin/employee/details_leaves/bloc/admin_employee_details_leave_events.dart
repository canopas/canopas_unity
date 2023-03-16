import 'package:equatable/equatable.dart';

abstract class AdminEmployeeDetailsLeavesEvents extends Equatable {}

class AdminEmployeeDetailsLeavesInitEvent
    extends AdminEmployeeDetailsLeavesEvents {
  AdminEmployeeDetailsLeavesInitEvent({required this.employeeId});

  final String employeeId;

  @override
  List<Object?> get props => [employeeId];
}
