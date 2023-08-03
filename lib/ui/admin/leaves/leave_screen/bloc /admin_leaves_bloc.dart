import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/list.dart';
import 'package:projectunity/data/core/extensions/stream_extension.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
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
              .groupByAppliedOnMonth()));
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
    if (!state.showPaginationLoading && !_isLoadedMax) {
      emit(state.copyWith(showPaginationLoading: true));
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
            leavesFetchStatus: Status.success,
            showPaginationLoading: false,
            leaveApplicationMap: leaveApplications.groupByAppliedOnMonth()));
      } on Exception {
        emit(state.copyWith(
            leavesFetchStatus: Status.error,
            error: firestoreFetchDataError,
            showPaginationLoading: false));
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

  @override
  Future<void> close() {
    _members.clear();
    _lastDoc = null;
    return super.close();
  }
}
