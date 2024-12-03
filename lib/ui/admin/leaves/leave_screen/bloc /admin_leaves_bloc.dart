import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/list.dart';
import 'package:projectunity/data/core/extensions/stream_extension.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/leave_application.dart';
import '../../../../../data/repo/employee_repo.dart';
import '../../../../../data/repo/leave_repo.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/model/leave/leave.dart';
import 'admin_leave_event.dart';
import 'admin_leaves_state.dart';

@Injectable()
class AdminLeavesBloc extends Bloc<AdminLeavesEvents, AdminLeavesState> {
  final LeaveRepo _leaveRepo;
  final EmployeeRepo _employeeRepo;

  List<Employee> _members = [];
  DocumentSnapshot<Leave>? _lastDoc;
  bool _isLoadedMax = false;

  AdminLeavesBloc(this._leaveRepo, this._employeeRepo)
      : super(const AdminLeavesState()) {
    on<InitialAdminLeavesEvent>(_init);
    on<FetchLeavesInitialEvent>(_fetchInitialLeaves);
    on<FetchMoreLeavesEvent>(_fetchMoreLeaves);
    on<SearchEmployeeEvent>(_searchEmployee);
    on<UpdateLeaveApplication>(_updateLeave);
  }

  Future<void> _init(
      InitialAdminLeavesEvent event, Emitter<AdminLeavesState> emit) async {
    try {
      _members = _employeeRepo.allEmployees.toList();
      emit(state.copyWith(
          members: _members, membersFetchStatus: Status.success));
      add(FetchLeavesInitialEvent());
    } on Exception {
      emit(state.copyWith(
          membersFetchStatus: Status.error, error: firestoreFetchDataError));
    }
  }

  Future<void> _fetchInitialLeaves(
      FetchLeavesInitialEvent event, Emitter<AdminLeavesState> emit) async {
    _isLoadedMax = false;
    emit(state.copyWith(
        assignSelectedEmployeeNull: true,
        selectedMember: event.member,
        leavesFetchStatus: Status.loading));
    try {
      final paginatedData = await _leaveRepo.leaves(uid: event.member?.uid);
      _lastDoc = paginatedData.lastDoc;
      emit(state.copyWith(
          leavesFetchStatus: Status.success,
          leaveApplicationMap: getLeaveApplicationFromLeaveEmployee(
                  leaves: paginatedData.leaves, members: _members)
              .groupByMonth((la) => la.leave.startDate)));
    } on Exception {
      _isLoadedMax = true;
      emit(state.copyWith(
        leavesFetchStatus: Status.error,
        error: firestoreFetchDataError,
      ));
    }
  }

  Future<void> _fetchMoreLeaves(
      FetchMoreLeavesEvent event, Emitter<AdminLeavesState> emit) async {
    if (state.fetchMoreData != Status.loading && !_isLoadedMax) {
      emit(state.copyWith(fetchMoreData: Status.loading));
      try {
        final paginatedData = await _leaveRepo.leaves(
            lastDoc: _lastDoc, uid: state.selectedMember?.uid);
        if (paginatedData.lastDoc == null) {
          _isLoadedMax = true;
        }
        _lastDoc = paginatedData.lastDoc;
        final leaveApplications = state.leaveApplicationMap.values.merge();
        leaveApplications.addAll(getLeaveApplicationFromLeaveEmployee(
            leaves: paginatedData.leaves, members: _members));
        emit(state.copyWith(
            fetchMoreData: Status.success,
            leaveApplicationMap:
                leaveApplications.groupByMonth((la) => la.leave.startDate)));
      } on Exception {
        emit(state.copyWith(
            error: firestoreFetchDataError, fetchMoreData: Status.error));
      }
    }
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

  Future<void> _updateLeave(
      UpdateLeaveApplication event, Emitter<AdminLeavesState> emit) async {
    final leaveApplications = state.leaveApplicationMap.values.merge();

    final leave = await _leaveRepo.fetchLeave(leaveId: event.leaveId);
    final employee =
        _members.firstWhereOrNull((element) => element.uid == leave?.uid);

    if (employee != null && leave != null) {
      final leaveApplication =
          LeaveApplication(employee: employee, leave: leave);
      leaveApplications.removeWhereAndAdd(leaveApplication,
          (element) => element.leave.leaveId == leave.leaveId);
      emit(state.copyWith(
          leaveApplicationMap:
              leaveApplications.groupByMonth((la) => la.leave.startDate)));
    }
  }

  @override
  Future<void> close() {
    _members.clear();
    _lastDoc = null;
    return super.close();
  }
}
