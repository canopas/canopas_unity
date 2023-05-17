import 'package:equatable/equatable.dart';
import '../../../../../data/model/employee/employee.dart';

abstract class AdminLeavesEvents extends Equatable {}

class AdminLeavesInitialLoadEvent extends AdminLeavesEvents {
  @override
  List<Object?> get props => [];
}

class ChangeEmployeeEvent extends AdminLeavesEvents {
  final Employee? employee;

  ChangeEmployeeEvent({required this.employee});

  @override
  List<Object?> get props => [employee];
}

class ChangeEmployeeLeavesYearEvent extends AdminLeavesEvents {
  final int year;

  ChangeEmployeeLeavesYearEvent({required this.year});

  @override
  List<Object?> get props => [year];
}

class SearchEmployeeEvent extends AdminLeavesEvents {
  final String search;

  SearchEmployeeEvent({required this.search});

  @override
  List<Object?> get props => [search];
}
