import 'package:equatable/equatable.dart';

abstract class EmployeesCalendarLeavesEvent extends Equatable{}


class EmployeeCalenadarLeavesInitialLoadEvent extends EmployeesCalendarLeavesEvent {
  @override
  List<Object?> get props => [];

}

class GetSelectedDateLeavesEvent extends EmployeesCalendarLeavesEvent {
  final DateTime selectedDate;
  GetSelectedDateLeavesEvent(this.selectedDate);
  @override
  List<Object?> get props => [selectedDate];
}
