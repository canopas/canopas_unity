import 'package:equatable/equatable.dart';
import 'package:projectunity/data/model/employee/employee.dart';

abstract class AdminLeavesEvents extends Equatable {}

class InitialAdminLeavesEvent extends AdminLeavesEvents {
  @override
  List<Object?> get props => [];
}

class FetchLeavesInitialEvent extends AdminLeavesEvents {
  final Employee? member;

  FetchLeavesInitialEvent({this.member});

  @override
  List<Object?> get props => [member];
}

class FetchMoreLeavesEvent extends AdminLeavesEvents {
  @override
  List<Object?> get props => [];
}

class SearchEmployeeEvent extends AdminLeavesEvents {
  final String search;

  SearchEmployeeEvent({required this.search});

  @override
  List<Object?> get props => [search];
}

class UpdateLeaveApplication extends AdminLeavesEvents {
  final String leaveId;

  UpdateLeaveApplication({required this.leaveId});

  @override
  List<Object?> get props => [leaveId];
}