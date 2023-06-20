import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/leave_application.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/model/leave/leave.dart';
import '../../../../../data/services/employee_service.dart';
import '../../../../../data/services/leave_service.dart';
import 'admin_leave_event.dart';
import 'admin_leaves_state.dart';

@Injectable()
class AdminLeavesBloc extends Bloc<AdminLeavesEvents, AdminLeavesState> {
  final LeaveService _leaveService;
  final EmployeeService _employeeService;
  late StreamSubscription _dBSubscription;

  List<LeaveApplication> _allLeaves = [];
  List<Employee> _allMembers = [];

  AdminLeavesBloc(this._leaveService, this._employeeService)
      : super(AdminLeavesState()) {
    on<ChangeEmployeeEvent>(_changeEmployee);
    on<ChangeEmployeeLeavesYearEvent>(_changeLeaveYear);
    on<SearchEmployeeEvent>(_searchEmployee);
    on<UpdateDataEvent>(_updateData);
    on<ShowErrorEvent>(_showError);
    on<ShowLoadingEvent>(_showLoading);

    _dBSubscription =
        Rx.combineLatest2<List<Employee>, List<Leave>, List<LeaveApplication>>(
      _employeeService.memberDBSnapshot(),
      _leaveService.leaveDBSnapshot(),
      leaveListAndEmployeeListToLeaveApplicationList,
    ).listen((leaveApplication) {
      _allLeaves = leaveApplication;
      add(UpdateDataEvent());
    }, onError: (error, _) {
      add(const ShowErrorEvent(firestoreFetchDataError));
    });
  }

  void _showError(ShowErrorEvent event, Emitter<AdminLeavesState> emit) {
    emit(state.copyWith(status: Status.error, error: event.error));
  }

  void _showLoading(ShowLoadingEvent event, Emitter<AdminLeavesState> emit) {
    emit(state.copyWith(status: Status.loading));
  }

  void _updateData(UpdateDataEvent event, Emitter<AdminLeavesState> emit) {
    emit(state.copyWith(
        status: Status.success,
        employees: _allMembers,
        leaveApplication:
            _getLeavesByEmployeeAndYear(year: state.selectedYear)));
  }

  List<LeaveApplication> leaveListAndEmployeeListToLeaveApplicationList(
      List<Employee> members, List<Leave> leaves) {
    _allMembers = members;
    return leaves
        .map((leave) {
          final employee =
              members.firstWhereOrNull((member) => member.uid == leave.uid);
          if (employee != null) {
            return LeaveApplication(employee: employee, leave: leave);
          }
          return null;
        })
        .whereNotNull()
        .toList();
  }

  List<LeaveApplication> _getLeavesByEmployeeAndYear(
      {Employee? selectedEmployee, required int year}) {
    final leaveApplication = _allLeaves
        .where((la) =>
            (la.leave.startDate.year == year ||
                la.leave.endDate.year == year) &&
            (selectedEmployee == null || la.leave.uid == selectedEmployee.uid))
        .toList();
    leaveApplication
        .sort((a, b) => b.leave.appliedOn.compareTo(a.leave.appliedOn));
    return leaveApplication;
  }

  void _changeEmployee(
      ChangeEmployeeEvent event, Emitter<AdminLeavesState> emit) {
    emit(state.copyWith(
        selectedEmployee: event.employee,
        assignSelectedEmployeeNull: true,
        selectedYear: DateTime.now().year,
        leaveApplication: _getLeavesByEmployeeAndYear(
            selectedEmployee: event.employee, year: DateTime.now().year)));
  }

  void _changeLeaveYear(
      ChangeEmployeeLeavesYearEvent event, Emitter<AdminLeavesState> emit) {
    emit(state.copyWith(
        selectedYear: event.year,
        leaveApplication: _getLeavesByEmployeeAndYear(
            selectedEmployee: state.selectedEmployee, year: event.year)));
  }

  void _searchEmployee(
      SearchEmployeeEvent event, Emitter<AdminLeavesState> emit) {
    emit(state.copyWith(searchEmployeeInput: event.search));
  }

  @override
  Future<void> close() async {
    _allLeaves.clear();
    _allMembers.clear();
    await _dBSubscription.cancel();
    super.close();
  }
}
