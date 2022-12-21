import 'dart:async';
import 'all_leaves_state.dart';
import 'all_leaves_event.dart';
import 'package:injectable/injectable.dart';
import '../../../../../model/leave_count.dart';
import '../../../../../model/leave/leave.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../provider/user_data.dart';
import '../../../../../exception/error_const.dart';
import '../../../../../event_bus/events.dart';
import '../../../../../model/leave_application.dart';
import '../../../../../core/extensions/list.dart';
import '../../../../../core/extensions/date_time.dart';
import '../../../../../services/leave/user_leave_service.dart';
import '../../../../../navigation/navigation_stack_manager.dart';
import '../../../../../navigation/nav_stack/nav_stack_item.dart';
import '../../../../../services/admin/paid_leave/paid_leave_service.dart';

@Injectable()
class AllLeavesViewBloc extends Bloc<AllLeavesViewEvent, AllLeavesViewState> {

  final NavigationStackManager _navigationStackManager;
  final PaidLeaveService _userPaidLeaveService;
  final UserLeaveService _userLeaveService;
  final UserManager _userManager;
  late StreamSubscription _streamSubscription;
  late StreamSubscription _refreshStreamSubscription;
  List<LeaveApplication> _allLeaveApplications = [];

  AllLeavesViewBloc(this._navigationStackManager, this._userManager, this._userLeaveService, this._userPaidLeaveService,)
      : super(AllLeavesViewInitialState()) {
    on<AllLeavesInitialLoadEvent>(_onAllLeavesInit);
    on<AllLeavesToLeaveDetailsNavigationEvent>(_onNavigateToLeaveDetailsEvent);
    on<AllLeavesToLeaveRequestNavigationEvent>(_onNavigateToLeaveRequestEvent);
    on<ApplyFilterAllLeavesViewEvent>(_onApplyFilter);
    on<RemoveFilterAllLeavesViewEvent>(_onRemoveFilter);
    on<RemoveLeaveApplicationOnAllLeaveViewEvent>(_onRemoveLeaveApplication);
    on<RefreshAllLeaveViewEvent>(_onAllLeavesInit);
    _streamSubscription = eventBus.on<LeaveUpdateEventListener>().listen((la) {
      add(RemoveLeaveApplicationOnAllLeaveViewEvent(la.leaveApplication));
    });
    _refreshStreamSubscription = eventBus.on<AllLeaveUpdateEventListener>().listen((e) {
      add(RefreshAllLeaveViewEvent());
    });
  }

  void _onAllLeavesInit(event,Emitter<AllLeavesViewState> emit) async {
    try {
      emit(AllLeavesViewLoadingState());
      List<Leave> leaves = [];
      leaves = await _userLeaveService.getAllLeavesOfUser(_userManager.employeeId);
      LeaveCounts leaveCounts = await currentUserLeaveCount();
      List<LeaveApplication> leaveApplications = leaves.map((leave) => LeaveApplication(employee: _userManager.employee, leave: leave, leaveCounts: leaveCounts)).toList();
      leaveApplications.sortedByDate();
      _allLeaveApplications = leaveApplications.toList();
      emit(AllLeavesViewSuccessState(leaveApplications: leaveApplications));
    }catch (_) {
      emit(AllLeavesViewFailureState(error: firestoreFetchDataError));
    }
  }

  Future<LeaveCounts> currentUserLeaveCount() async {
    double usedLeaveCount = await _userLeaveService.getUserUsedLeaveCount(_userManager.employeeId);
    int paidLeaveCount = await _userPaidLeaveService.getPaidLeaves();
    double remainingLeaveCount = paidLeaveCount - usedLeaveCount;
    return LeaveCounts(remainingLeaveCount: remainingLeaveCount<0?0:remainingLeaveCount,paidLeaveCount: paidLeaveCount,usedLeaveCount: usedLeaveCount);
  }

  void _onApplyFilter(ApplyFilterAllLeavesViewEvent event,Emitter<AllLeavesViewState> emit){
      emit(AllLeavesViewSuccessState(
        leaveApplications: _allLeaveApplications.toList().where((leaveApplication) => _applyFilterValidation(startDate: event.startDate,endDate: event.endDate,leaveApplication: leaveApplication,leaveStatus: event.leaveStatus,leaveType: event.leaveType)).toList(),
         ));
  }

  void _onRemoveFilter(RemoveFilterAllLeavesViewEvent event,Emitter<AllLeavesViewState> emit){
    emit(AllLeavesViewSuccessState(leaveApplications: _allLeaveApplications.toList()));
  }

  void _onNavigateToLeaveDetailsEvent(AllLeavesToLeaveDetailsNavigationEvent event,Emitter<AllLeavesViewState> emit) {
    _navigationStackManager.push(NavStackItem.employeeLeaveDetailState(event.leaveApplication));
  }

  void _onNavigateToLeaveRequestEvent(AllLeavesToLeaveRequestNavigationEvent event,Emitter<AllLeavesViewState> emit) {
    _navigationStackManager.push(const NavStackItem.leaveRequestState());
  }

  void _onRemoveLeaveApplication(RemoveLeaveApplicationOnAllLeaveViewEvent event,Emitter<AllLeavesViewState> emit) {
    AllLeavesViewSuccessState successState = state as AllLeavesViewSuccessState;
    List<LeaveApplication> leaveApp = successState.leaveApplications.toList()..remove(event.leaveApplication);
    _allLeaveApplications.remove(event.leaveApplication);
    emit(AllLeavesViewSuccessState(leaveApplications: leaveApp));
  }

  //validations
  bool _applyFilterValidation({required DateTime? startDate, required DateTime? endDate, required List<int> leaveStatus, required List<int> leaveType, required LeaveApplication leaveApplication}){

    //Filter leave time validation
    bool timeValidation = true;
    if(startDate != null && endDate != null){
      timeValidation = leaveApplication.leave.startDate >= startDate.timeStampToInt && leaveApplication.leave.endDate <= endDate.timeStampToInt;
    } else if (startDate == null && endDate != null){
      timeValidation = leaveApplication.leave.endDate <= endDate.timeStampToInt;
    } else if (startDate != null && endDate == null) {
      timeValidation = leaveApplication.leave.startDate >= startDate.timeStampToInt;
    }

    //Leave type validation
    bool leaveTypeValidation = true;
    if(leaveType.isNotEmpty){
      leaveTypeValidation = leaveType.contains(leaveApplication.leave.leaveType);
    }

    //Leave status validation
    bool leaveStatusValidation = true;
    if(leaveStatus.isNotEmpty){
      leaveStatusValidation = leaveStatus.contains(leaveApplication.leave.leaveStatus);
    }

    //return true on all validation is valid
    return leaveTypeValidation && timeValidation && leaveStatusValidation;
  }

  @override
  Future<void> close() async {
    _refreshStreamSubscription.cancel();
    _streamSubscription.cancel();
    _allLeaveApplications.clear();
    super.close();
  }
}