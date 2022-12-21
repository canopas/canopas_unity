import 'package:equatable/equatable.dart';

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



