
import 'package:equatable/equatable.dart';
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart';

import '../../../../../model/employee/employee.dart';

abstract class EmployeeListEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class EmployeeListInitialLoadEvent extends EmployeeListEvent{}

class EmployeeListUpdateEvent extends EmployeeListEvent{}

class EmployeeListNavigationToEmployeeDetailEvent extends EmployeeListEvent{
  final String id;
  EmployeeListNavigationToEmployeeDetailEvent(this.id);
}



