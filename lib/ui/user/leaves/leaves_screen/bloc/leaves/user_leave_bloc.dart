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

  DocumentSnapshot<Leave>? _lastDoc;
  bool _isLoadedMax = false;

  UserLeaveBloc(this._userManager, this._leaveRepo)
      : super(const UserLeaveState()) {
    on<LoadInitialUserLeaves>(_fetchInitialLeaves);
    on<FetchMoreUserLeaves>(_fetchMoreLeaves);
  }

  Future<void> _fetchInitialLeaves(
      LoadInitialUserLeaves event, Emitter<UserLeaveState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final paginatedData =
          await _leaveRepo.leaves(uid: _userManager.employeeId);
      _lastDoc = paginatedData.lastDoc;
      emit(state.copyWith(
          status: Status.success,
          leavesMap:
              paginatedData.leaves.groupByMonth((leave) => leave.appliedOn)));
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
          final leaves = state.leavesMap.values.merge();
          leaves.addAll(paginatedData.leaves);
          emit(state.copyWith(
              fetchMoreDataStatus: Status.success,
              leavesMap: leaves.groupByMonth((leave) => leave.appliedOn)));
        }
      } on Exception {
        emit(state.copyWith(
            error: firestoreFetchDataError, fetchMoreDataStatus: Status.error));
      }
    }
  }

  @override
  Future<void> close() {
    _lastDoc = null;
    return super.close();
  }
}
