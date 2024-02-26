import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/list.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_event.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_state.dart';
import '../../../../../../data/model/leave/leave.dart';
import '../../../../../../data/repo/leave_repo.dart';
import '../../../../../../data/core/exception/error_const.dart';
import '../../../../../../data/core/utils/bloc_status.dart';
import '../../../../../../data/provider/user_state.dart';

@Injectable()
class UserLeaveBloc extends Bloc<UserLeavesEvents, UserLeaveState> {
  final LeaveRepo _leaveRepo;
  final UserStateNotifier _userManager;
  List<Leave> allLeaves = [];

  DocumentSnapshot<Leave>? _lastDoc;
  bool _isLoadedMax = false;

  UserLeaveBloc(this._userManager, this._leaveRepo)
      : super(const UserLeaveState()) {
    on<LoadInitialUserLeaves>(_fetchInitialLeaves);
    on<FetchMoreUserLeaves>(_fetchMoreLeaves);
    on<UpdateLeave>(_updateLeave);
  }

  Future<void> _fetchInitialLeaves(
      LoadInitialUserLeaves event, Emitter<UserLeaveState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final paginatedData =
          await _leaveRepo.leaves(uid: _userManager.employeeId);
      allLeaves = paginatedData.leaves;
      _lastDoc = paginatedData.lastDoc;

      final List<Leave> casualLeaves = allLeaves
          .where((element) => element.type == LeaveType.casualLeave)
          .toList();
      final List<Leave> urgentLeaves = allLeaves
          .where((element) => element.type == LeaveType.urgentLeave)
          .toList();

      emit(state.copyWith(
          status: Status.success,
          urgentLeaves: urgentLeaves.groupByMonth((leave) => leave.appliedOn),
          casualLeaves: casualLeaves.groupByMonth((leave) => leave.appliedOn)));
    } on Exception {
      _isLoadedMax = true;
      emit(state.copyWith(
        status: Status.error,
        error: firestoreFetchDataError,
      ));
    }
  }

  Future<void> _fetchMoreLeaves(
      FetchMoreUserLeaves event, Emitter<UserLeaveState> emit) async {
    if (state.fetchMoreDataStatus != Status.loading && !_isLoadedMax) {
      emit(state.copyWith(fetchMoreDataStatus: Status.loading));
      try {
        final paginatedData = await _leaveRepo.leaves(
            lastDoc: _lastDoc, uid: _userManager.employeeId);
        if (paginatedData.lastDoc == null) {
          _isLoadedMax = true;
          emit(state.copyWith(fetchMoreDataStatus: Status.success));
        } else {
          _lastDoc = paginatedData.lastDoc;
          // final leaves = state.casualLeaves.values.merge();
          allLeaves.addAll(paginatedData.leaves);
          if (event.leaveType == LeaveType.casualLeave) {
            final List<Leave> casualLeaves = allLeaves
                .where((e) => e.type == LeaveType.casualLeave)
                .toList();
            emit(state.copyWith(
                fetchMoreDataStatus: Status.success,
                casualLeaves:
                    casualLeaves.groupByMonth((leave) => leave.appliedOn)));
          } else {
            final List<Leave> urgentLeaves = allLeaves
                .where((e) => e.type == LeaveType.urgentLeave)
                .toList();

            emit(state.copyWith(
                fetchMoreDataStatus: Status.success,
                urgentLeaves:
                    urgentLeaves.groupByMonth((leave) => leave.appliedOn)));
          }
        }
      } on Exception {
        emit(state.copyWith(
            error: firestoreFetchDataError, fetchMoreDataStatus: Status.error));
      }
    }
  }

  Future<void> _updateLeave(
      UpdateLeave event, Emitter<UserLeaveState> emit) async {
    final leave = await _leaveRepo.fetchLeave(leaveId: event.leaveId);
    final leaves = state.casualLeaves.values.merge();
    leaves.removeWhereAndAdd(
        leave, (element) => element.leaveId == leave?.leaveId);
    List<Leave> casualLeaves = leaves
        .where((element) => element.type == LeaveType.casualLeave)
        .toList();
    List<Leave> urgentLeaves = leaves
        .where((element) => element.type == LeaveType.urgentLeave)
        .toList();
    emit(state.copyWith(
        casualLeaves: casualLeaves.groupByMonth((leave) => leave.appliedOn),
        urgentLeaves: urgentLeaves.groupByMonth((leave) => leave.appliedOn)));
  }

  @override
  Future<void> close() {
    _lastDoc = null;
    return super.close();
  }
}
