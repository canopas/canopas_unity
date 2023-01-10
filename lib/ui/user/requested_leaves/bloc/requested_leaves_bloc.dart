import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/extensions/list.dart';
import '../../../../services/user/user_leave_service.dart';
import '../../../../ui/user/requested_leaves/bloc/requested_leave_event.dart';
import '../../../../ui/user/requested_leaves/bloc/requested_leave_state.dart';
import '../../../../event_bus/events.dart';
import '../../../../exception/error_const.dart';
import '../../../../model/leave/leave.dart';
import '../../../../model/leave_application.dart';
import '../../../../model/leave_count.dart';
import '../../../../provider/user_data.dart';
import '../../../../services/admin/paid_leave_service.dart';

@Injectable()
class RequestedLeavesViewBloc extends Bloc<RequestedLeavesViewEvents,RequestedLeavesViewStates>{
  final PaidLeaveService _userPaidLeaveService;
  final UserLeaveService _userLeaveService;
  final UserManager _userManager;
  late StreamSubscription _streamSubscription;
  RequestedLeavesViewBloc( this._userPaidLeaveService, this._userLeaveService, this._userManager)
      : super(RequestedLeaveViewInitialState()){
      on<RequestedLeavesViewInitialLoadEvent>(_initialLoad);
      on<RemoveLeaveApplicationOnRequestedLeavesEvent>(_removeLeaveApplication);

    _streamSubscription = eventBus.on<LeaveUpdateEventListener>().listen((la) {
      add(RemoveLeaveApplicationOnRequestedLeavesEvent(la.leaveApplication));
    });
  }

  Future<void> _initialLoad(RequestedLeavesViewInitialLoadEvent event, Emitter<RequestedLeavesViewStates> emit) async {
    emit(RequestedLeaveViewLoadingState());
    List<Leave> leaves = [];
    try {
      leaves = await _userLeaveService.getRequestedLeave(_userManager.employeeId);
      LeaveCounts leaveCounts = await _currentUserLeaveCount();
      List<LeaveApplication> leaveApplications = leaves.map((leave) => LeaveApplication(employee: _userManager.employee, leave: leave, leaveCounts: leaveCounts)).toList();
      leaveApplications.sortedByDate();
      emit(RequestedLeaveViewSuccessState(leaveApplications: leaveApplications));
    }catch (_) {
      emit(RequestedLeaveViewFailureState(error: firestoreFetchDataError));
    }
  }

  void _removeLeaveApplication(RemoveLeaveApplicationOnRequestedLeavesEvent event, Emitter<RequestedLeavesViewStates> emit){
    if(state is RequestedLeaveViewSuccessState) {
      RequestedLeaveViewSuccessState successState = state as RequestedLeaveViewSuccessState;
      List<LeaveApplication> leaveApplication = successState.leaveApplications.toList();
      leaveApplication.remove(event.leaveApplication);
      emit(RequestedLeaveViewSuccessState(leaveApplications: leaveApplication));
    }
  }


  Future<LeaveCounts> _currentUserLeaveCount() async {
    double usedLeaveCount = await _userLeaveService.getUserUsedLeaveCount(_userManager.employeeId);
    int paidLeaveCount = await _userPaidLeaveService.getPaidLeaves();
    double remainingLeaveCount = paidLeaveCount - usedLeaveCount;
    return LeaveCounts(remainingLeaveCount: remainingLeaveCount<0?0:remainingLeaveCount,paidLeaveCount: paidLeaveCount,usedLeaveCount: usedLeaveCount);
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

}

