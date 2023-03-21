import 'package:equatable/equatable.dart';
import '../../../../data/model/employee/employee.dart';

class CreateSpaceEvent extends Equatable {
  final String organizationName;
  final Employee employee;

  const CreateSpaceEvent(
      {required this.organizationName, required this.employee});

  @override
  List<Object?> get props => [organizationName, employee];
}
