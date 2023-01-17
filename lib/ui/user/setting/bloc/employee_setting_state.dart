import 'package:equatable/equatable.dart';
import '../../../../model/employee/employee.dart';

class EmployeeSettingState extends Equatable {
  final Employee employee;
  const EmployeeSettingState({required this.employee});
  @override
  List<Object?> get props => [employee];
}