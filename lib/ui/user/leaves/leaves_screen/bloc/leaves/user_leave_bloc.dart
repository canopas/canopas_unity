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
  List<Leave> casualLeaves = [];
  List<Leave> urgentLeaves = [];

  DocumentSnapshot<Leave>? _casualLastDoc;
  DocumentSnapshot<Leave>? _urgentLastDoc;

  bool _isLoadedMaxCasual = false;
  bool _isLoadedMaxUrgent = false;


  UserLeaveBloc(this._userManager, this._leaveRepo)
      : super(const UserLeaveState()) {
    on<LoadInitialUserLeaves>(_fetchInitialLeaves);
    on<FetchMoreUserLeaves>(_fetchMoreLeaves);
    on<UpdateLeave>(_updateLeave);
  }

  Future<void> _fetchInitialLeaves(LoadInitialUserLeaves event,
      Emitter<UserLeaveState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final casualPaginated = await _leaveRepo.leaves(
          uid: _userManager.employeeId, leaveType: LeaveType.casualLeave);
      final urgentPaginated = await _leaveRepo.leaves(
          uid: _userManager.employeeId, leaveType: LeaveType.urgentLeave);
      casualLeaves = casualPaginated.leaves;
      _casualLastDoc = casualPaginated.lastDoc;
      urgentLeaves = urgentPaginated.leaves;
      _urgentLastDoc = urgentPaginated.lastDoc;

      emit(state.copyWith(
          status: Status.success,
          urgentLeaves: urgentLeaves.groupByMonth((leave) => leave.appliedOn),
          casualLeaves: casualLeaves.groupByMonth((leave) => leave.appliedOn)));
    } on Exception catch(e){

      _isLoadedMaxCasual = true;
       _isLoadedMaxUrgent = true;
      emit(state.copyWith(
        status: Status.error,
        error: firestoreFetchDataError,
      ));
    }
  }

  Future<void> _fetchMoreLeaves(FetchMoreUserLeaves event,
      Emitter<UserLeaveState> emit) async {
    if (state.fetchMoreDataStatus != Status.loading ) {
      emit(state.copyWith(fetchMoreDataStatus: Status.loading));
      try {
        if(event.leaveType==LeaveType.casualLeave && !_isLoadedMaxCasual){
         await _fetchCasualLeaves(emit);
         emit(state.copyWith(fetchMoreDataStatus: Status.success,
             casualLeaves: casualLeaves.groupByMonth((leave) => leave.appliedOn)));
        }else if(event.leaveType==LeaveType.urgentLeave && !_isLoadedMaxUrgent){
          await _fetchUrgentLeaves(emit);
          emit(state.copyWith(fetchMoreDataStatus: Status.success,
              casualLeaves: casualLeaves.groupByMonth((leave) => leave.appliedOn)));
        }
      } on Exception {
        emit(state.copyWith(
            error: firestoreFetchDataError, fetchMoreDataStatus: Status.error));
      }
    }
  }

  Future<void> _fetchCasualLeaves(Emitter<UserLeaveState> emit) async {
    final paginatedData = await _leaveRepo.leaves(
        lastDoc: _casualLastDoc,
        uid: _userManager.employeeId,
        leaveType: LeaveType.casualLeave);
    if (paginatedData.lastDoc == null) {
      _isLoadedMaxCasual = true;
    } else {
      _casualLastDoc = paginatedData.lastDoc;
      casualLeaves.addAll(paginatedData.leaves);
    }
  }

    Future<void> _fetchUrgentLeaves(Emitter<UserLeaveState> emit) async {
      final paginatedData = await _leaveRepo.leaves(
          lastDoc: _urgentLastDoc,
          uid: _userManager.employeeId,
          leaveType: LeaveType.urgentLeave);
      if (paginatedData.lastDoc == null) {
        _isLoadedMaxUrgent = true;
      } else {
        _urgentLastDoc = paginatedData.lastDoc;
        urgentLeaves.addAll(paginatedData.leaves);
      }
    }

    Future<void> _updateLeave(UpdateLeave event,
        Emitter<UserLeaveState> emit) async {
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
      return super.close();
    }
  }
