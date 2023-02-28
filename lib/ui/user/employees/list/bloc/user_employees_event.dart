import 'package:equatable/equatable.dart';

abstract class UserEmployeesEvent extends Equatable {}

class FetchEmployeesEvent extends UserEmployeesEvent {
  @override
  List<Object?> get props => [];
}
