import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/list.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import '../../../../../data/repo/leave_repo.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/model/leave/leave.dart';
import 'admin_employee_details_leave_state.dart';
import 'admin_employee_details_leave_events.dart';

@Injectable()
class AdminEmployeeDetailsLeavesBLoc
    extends
        Bloc<
          AdminEmployeeDetailsLeavesEvents,
          AdminEmployeeDetailsLeavesState
        > {
  final LeaveRepo _leaveRepo;
  DocumentSnapshot<Leave>? _lastDoc;
  bool _isLoadedMax = false;
  late String _employeeId;

  AdminEmployeeDetailsLeavesBLoc(this._leaveRepo)
    : super(const AdminEmployeeDetailsLeavesState()) {
    on<LoadInitialLeaves>(_fetchInitialLeaves);
    on<FetchMoreUserLeaves>(_fetchMoreLeaves);
    on<UpdateLeave>(_updateLeave);
  }

  Future<void> _fetchInitialLeaves(
    LoadInitialLeaves event,
    Emitter<AdminEmployeeDetailsLeavesState> emit,
  ) async {
    _employeeId = event.employeeId;
    emit(state.copyWith(status: Status.loading));
    try {
      final paginatedData = await _leaveRepo.leaves(uid: event.employeeId);
      _lastDoc = paginatedData.lastDoc;
      emit(
        state.copyWith(
          status: Status.success,
          leavesMap: paginatedData.leaves.groupByMonth(
            (leave) => leave.appliedOn,
          ),
        ),
      );
    } on Exception {
      _isLoadedMax = true;
      emit(
        state.copyWith(status: Status.error, error: firestoreFetchDataError),
      );
    }
  }

  Future<void> _fetchMoreLeaves(
    FetchMoreUserLeaves event,
    Emitter<AdminEmployeeDetailsLeavesState> emit,
  ) async {
    if (state.fetchMoreDataStatus != Status.loading && !_isLoadedMax) {
      emit(state.copyWith(fetchMoreDataStatus: Status.loading));
      try {
        final paginatedData = await _leaveRepo.leaves(
          lastDoc: _lastDoc,
          uid: _employeeId,
        );
        if (paginatedData.lastDoc == null) {
          _isLoadedMax = true;
          emit(state.copyWith(fetchMoreDataStatus: Status.success));
        } else {
          _lastDoc = paginatedData.lastDoc;
          final leaves = state.leavesMap.values.merge();
          leaves.addAll(paginatedData.leaves);
          emit(
            state.copyWith(
              fetchMoreDataStatus: Status.success,
              leavesMap: leaves.groupByMonth((leave) => leave.appliedOn),
            ),
          );
        }
      } on Exception {
        emit(
          state.copyWith(
            error: firestoreFetchDataError,
            fetchMoreDataStatus: Status.error,
          ),
        );
      }
    }
  }

  Future<void> _updateLeave(
    UpdateLeave event,
    Emitter<AdminEmployeeDetailsLeavesState> emit,
  ) async {
    final leave = await _leaveRepo.fetchLeave(leaveId: event.leaveId);
    final leaves = state.leavesMap.values.merge();
    leaves.removeWhereAndAdd(
      leave,
      (element) => element.leaveId == leave?.leaveId,
    );
    emit(
      state.copyWith(
        leavesMap: leaves.groupByMonth((leave) => leave.appliedOn),
      ),
    );
  }

  @override
  Future<void> close() {
    _lastDoc = null;
    return super.close();
  }
}
