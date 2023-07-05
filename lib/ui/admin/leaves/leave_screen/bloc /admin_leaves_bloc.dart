import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/stream_extension.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/leave_application.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../data/Repo/employee_repo.dart';
import '../../../../../data/Repo/leave_repo.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/model/leave/leave.dart';
import 'admin_leave_event.dart';
import 'admin_leaves_state.dart';

@Injectable()
class AdminLeavesBloc extends Bloc<AdminLeavesEvents, AdminLeavesState> {
  final LeaveRepo _leaveRepo;
  final EmployeeRepo _employeeRepo;
  List<LeaveApplication> _allLeaves = [];
  List<Employee> _members = [];

  AdminLeavesBloc(this._leaveRepo, this._employeeRepo)
      : super(AdminLeavesState()) {
    on<AdminLeavesInitialLoadEvent>(_listenRealTImeLeaveApplication);
    on<ChangeMemberEvent>(_changeEmployee);
    on<ChangeEmployeeLeavesYearEvent>(_changeLeaveYear);
    on<SearchEmployeeEvent>(_searchEmployee);
  }

  Future<void> _listenRealTImeLeaveApplication(
      AdminLeavesInitialLoadEvent event, Emitter<AdminLeavesState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      return emit.forEach(_leaveApplicationStream(),
          onData: (List<LeaveApplication> leaveApplications) {
            _allLeaves = leaveApplications.toList();
            return state.copyWith(
                status: Status.success,
                members: _members,
                leaveApplication: _getLeavesByEmployeeAndYear(
                    year: state.selectedYear,
                    selectedEmployee: state.selectedEmployee));
          },
          onError: (error, stackTrace) => state.copyWith(
              status: Status.error, error: firestoreFetchDataError));
    } on Exception {
      emit(
          state.copyWith(status: Status.error, error: firestoreFetchDataError));
    }
  }

  Stream<List<LeaveApplication>> _leaveApplicationStream() =>
      Rx.combineLatest2(_leaveRepo.leaves, _employeeRepo.employees,
          (List<Leave> leaves, List<Employee> members) {
        _members =
            members.where((member) => member.role != Role.admin).toList();
        return getLeaveApplicationFromLeaveEmployee(
            leaves: leaves, members: members);
      });

  List<LeaveApplication> _getLeavesByEmployeeAndYear(
      {Employee? selectedEmployee, required int year}) {
    final leaveApplications = _allLeaves
        .where((leaveApplication) =>
            (leaveApplication.leave.startDate.year == year ||
                leaveApplication.leave.endDate.year == year) &&
            (selectedEmployee == null ||
                leaveApplication.leave.uid == selectedEmployee.uid))
        .toList();
    leaveApplications
        .sort((a, b) => b.leave.appliedOn.compareTo(a.leave.appliedOn));
    return leaveApplications;
  }

  void _changeEmployee(
      ChangeMemberEvent event, Emitter<AdminLeavesState> emit) {
    emit(state.copyWith(
        selectedEmployee: event.member,
        assignSelectedEmployeeNull: true,
        selectedYear: DateTime.now().year,
        leaveApplication: _getLeavesByEmployeeAndYear(
            selectedEmployee: event.member, year: DateTime.now().year)));
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
    emit(state.copyWith(
        members: _members
            .where((member) =>
                member.name
                    .toLowerCase()
                    .contains(event.search.toLowerCase()) ||
                event.search.trim().isEmpty)
            .toList()));
  }

  @override
  Future<void> close() {
    _allLeaves.clear();
    _members.clear();
    return super.close();
  }
}
