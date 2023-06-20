import '../../../../../data/model/employee/employee.dart';

abstract class AdminLeavesEvents {
  const AdminLeavesEvents();
}

class ShowErrorEvent extends AdminLeavesEvents {
  final String error;

  const ShowErrorEvent(this.error);
}

class UpdateDataEvent extends AdminLeavesEvents {}

class ShowLoadingEvent extends AdminLeavesEvents {}

class ChangeEmployeeEvent extends AdminLeavesEvents {
  final Employee? employee;

  const ChangeEmployeeEvent({required this.employee});
}

class ChangeEmployeeLeavesYearEvent extends AdminLeavesEvents {
  final int year;

  const ChangeEmployeeLeavesYearEvent({required this.year});
}

class SearchEmployeeEvent extends AdminLeavesEvents {
  final String search;

  const SearchEmployeeEvent({required this.search});
}
