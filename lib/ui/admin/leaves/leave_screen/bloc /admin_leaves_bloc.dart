import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/model/leave/leave.dart';
import '../../../../../data/services/employee_service.dart';
import '../../../../../data/services/leave_service.dart';
import 'admin_leave_event.dart';
import 'admin_leaves_state.dart';

@Injectable()
class AdminLeavesBloc extends Bloc<AdminLeavesEvents, AdminLeavesState> {
  final LeaveService _leaveService;
  final EmployeeService _employeeService;
  List<Leave> _allLeaves = [];

  AdminLeavesBloc(this._leaveService, this._employeeService)
      : super(AdminLeavesState()) {
    on<AdminLeavesInitialLoadEvent>(_initialLoad);
    on<ChangeEmployeeEvent>(_changeEmployee);
    on<ChangeEmployeeLeavesYearEvent>(_changeLeaveYear);
    on<SearchEmployeeEvent>(_searchEmployee);
  }

  Future<void> _initialLoad(
      AdminLeavesInitialLoadEvent event, Emitter<AdminLeavesState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final employees = await _employeeService.getEmployees();
      _allLeaves = await _leaveService.getAllLeaves();
      final leaves = _getLeavesByEmployeeAndYear(year: state.selectedYear);

      emit(state.copyWith(
          status: Status.success, employees: employees, leaves: leaves));
    } on Exception {
      emit(
          state.copyWith(status: Status.error, error: firestoreFetchDataError));
    }
  }

  List<Leave> _getLeavesByEmployeeAndYear({String? uid, required int year}) {
    return _allLeaves
        .where((leave) =>
            (leave.uid == uid || uid == null) &&
            (leave.startDate.toDate.year == year ||
                leave.endDate.toDate.year == year))
        .toList();
  }

  void _changeEmployee(
      ChangeEmployeeEvent event, Emitter<AdminLeavesState> emit) {
    emit(state.copyWith(
        selectedEmployee: event.employee,
        assignSelectedEmployeeNull: true,
        selectedYear: DateTime.now().year,
        leaves: _getLeavesByEmployeeAndYear(
            uid: event.employee?.uid, year: DateTime.now().year)));
  }

  void _changeLeaveYear(ChangeEmployeeLeavesYearEvent event,
      Emitter<AdminLeavesState> emit)  {
    emit(state.copyWith(
        selectedYear: event.year,
        leaves: _getLeavesByEmployeeAndYear(
            uid: state.selectedEmployee?.uid, year: event.year)));
  }

  void _searchEmployee(
      SearchEmployeeEvent event, Emitter<AdminLeavesState> emit) {
    emit(state.copyWith(searchEmployeeInput: event.search));
  }

  @override
  Future<void> close() {
    _allLeaves.clear();
    return super.close();
  }
}
