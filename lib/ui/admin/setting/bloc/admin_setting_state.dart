import 'package:equatable/equatable.dart';

import '../../../../model/employee/employee.dart';

class AdminSettingState extends Equatable {
  final Employee employee;
  const AdminSettingState({required this.employee});
  @override
  List<Object?> get props => throw [employee];
}