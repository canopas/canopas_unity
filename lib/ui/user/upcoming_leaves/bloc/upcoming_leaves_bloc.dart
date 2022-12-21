import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/extensions/list.dart';
import '../../../../ui/user/upcoming_leaves/bloc/upcoming_leaves_event.dart';
import '../../../../ui/user/upcoming_leaves/bloc/upcoming_leaves_state.dart';
import '../../../../event_bus/events.dart';
import '../../../../exception/error_const.dart';
import '../../../../model/leave/leave.dart';
import '../../../../model/leave_application.dart';
import '../../../../model/leave_count.dart';
import '../../../../navigation/nav_stack/nav_stack_item.dart';
import '../../../../navigation/navigation_stack_manager.dart';
import '../../../../provider/user_data.dart';
import '../../../../services/admin/paid_leave/paid_leave_service.dart';
import '../../../../services/leave/user_leave_service.dart';

@Injectable()
class UpcomingLeavesViewBloc extends Bloc<UpcomingLeavesViewEvents,UpcomingLeavesViewStates>{
  final NavigationStackManager _navigationStackManager;
  final PaidLeaveService _userPaidLeaveService;
  final UserLeaveService _userLeaveService;
  final UserManager _userManager;
  late StreamSubscription _streamSubscription;
  UpcomingLeavesViewBloc(this._navigationStackManager, this._userPaidLeaveService, this._userLeaveService, this._userManager) : super(UpcomingLeaveViewInitialState()){
    on<UpcomingLeavesViewInitialLoadEvent>(_initialLoad);
    on<RemoveLeaveApplicationOnUpcomingLeavesEvent>(_removeLeaveApplication);
    on<NavigateToLeaveDetailsViewUpcomingLeavesEvent>(_navigateToLeaveDetails);
    on<NavigateToLeaveRequestViewUpcomingLeavesEvent>(_navigateToLeaveRequest);

    _streamSubscription = eventBus.on<LeaveUpdateEventListener>().listen((la) {
      add(RemoveLeaveApplicationOnUpcomingLeavesEvent(la.leaveApplication));
    });
  }
  
  Future<void> _initialLoad(UpcomingLeavesViewInitialLoadEvent event, Emitter<UpcomingLeavesViewStates> emit) async {
    emit(UpcomingLeaveViewLoadingState());
    List<Leave> leaves = [];
    try {
      leaves = await _userLeaveService.getUpcomingLeaves(_userManager.employeeId);
      LeaveCounts leaveCounts = await _currentUserLeaveCount();
      List<LeaveApplication> leaveApplications = leaves.map((leave) => LeaveApplication(employee: _userManager.employee, leave: leave, leaveCounts: leaveCounts)).toList();
      leaveApplications.sortedByDate();
      emit(UpcomingLeaveViewSuccessState(leaveApplications: leaveApplications));
    }catch (_) {
      emit(UpcomingLeaveViewFailureState(error: firestoreFetchDataError));
    }
  }

  void _removeLeaveApplication(RemoveLeaveApplicationOnUpcomingLeavesEvent event, Emitter<UpcomingLeavesViewStates> emit){
    if(state is UpcomingLeaveViewSuccessState) {
      UpcomingLeaveViewSuccessState successState = state as UpcomingLeaveViewSuccessState;
      List<LeaveApplication> leaveApplication = successState.leaveApplications.toList();
      leaveApplication.remove(event.leaveApplication);
      emit(UpcomingLeaveViewSuccessState(leaveApplications: leaveApplication));
    }
  }

  void _navigateToLeaveDetails(NavigateToLeaveDetailsViewUpcomingLeavesEvent event, Emitter<UpcomingLeavesViewStates> emit){
    _navigationStackManager.push(NavStackItem.employeeLeaveDetailState(event.leaveApplication));
  }

  void _navigateToLeaveRequest(NavigateToLeaveRequestViewUpcomingLeavesEvent event, Emitter<UpcomingLeavesViewStates> emit){
    _navigationStackManager.push(const NavStackItem.leaveRequestState());
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