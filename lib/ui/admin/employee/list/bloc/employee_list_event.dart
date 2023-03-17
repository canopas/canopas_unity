import 'package:equatable/equatable.dart';

abstract class EmployeeListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmployeeListInitialLoadEvent extends EmployeeListEvent {}
