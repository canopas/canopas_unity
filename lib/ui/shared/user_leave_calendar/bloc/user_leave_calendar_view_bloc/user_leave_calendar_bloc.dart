import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/services/admin/paid_leave/paid_leave_service.dart';
import 'package:projectunity/ui/shared/user_leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_states.dart';
import '../../../../../core/extensions/leave_extension.dart';
import '../../../../../event_bus/events.dart';
import '../../../../../model/leave_count.dart';
import '../../../../../services/admin/employee/employee_service.dart';
import '../../../../../services/leave/user_leave_service.dart';
import 'user_leave_calendar_events.dart';
import '../../../../../exception/error_const.dart';
import '../../../../../model/employee/employee.dart';
import '../../../../../model/leave/leave.dart';
import '../../../../../model/leave_application.dart';
import 'package:collection/collection.dart';

@Injectable()
class UserLeaveCalendarViewBloc extends Bloc<UserLeaveCalendarEvent,UserLeaveCalendarViewState>{

  final UserLeaveService _userLeaveService;
  final EmployeeService _employeeService;
  final PaidLeaveService _paidLeaveService;
  late StreamSubscription _streamSubscription;

  UserLeaveCalendarViewBloc( this._userLeaveService, this._employeeService, this._paidLeaveService) :
        super(UserLeaveCalendarViewInitialState()) {
    on<UserLeaveCalendarInitialLoadEvent>(_loadAllLeaves);
    on<DateRangeSelectedEvent>(_onDateRangeSelected);
    on<RemoveOrCancelLeaveApplication>(_onRemoveOrCancelLeaveApplication);
    _streamSubscription = eventBus.on<LeaveUpdateEventListener>().listen((la) {
      add(RemoveOrCancelLeaveApplication(la.leaveApplication));
    });
  }

  void _loadAllLeaves(UserLeaveCalendarInitialLoadEvent event, Emitter<UserLeaveCalendarViewState> emit) async {
    emit(UserLeaveCalendarViewLoadingState());
    try {
      Employee? currentEmployee = await _employeeService.getEmployee(event.userid);
      List<Leave>  leaves = await _userLeaveService.getAllLeavesOfUser(event.userid);
      double usedLeaveCount = await _userLeaveService.getUserUsedLeaveCount(event.userid);
      int paidLeaveCount = await _paidLeaveService.getPaidLeaves();
      double remainingLeaveCount = paidLeaveCount - usedLeaveCount;
      LeaveCounts leaveCounts = LeaveCounts(remainingLeaveCount: remainingLeaveCount<0?0:remainingLeaveCount,paidLeaveCount: paidLeaveCount,usedLeaveCount: usedLeaveCount);
      List<LeaveApplication> userLeaves = leaves.map((leave) => (currentEmployee == null)?null:LeaveApplication(employee: currentEmployee, leave: leave, leaveCounts: leaveCounts)).whereNotNull().toList();
      emit(UserLeaveCalendarViewSuccessState(leaveApplications: userLeaves, allLeaveApplications: userLeaves));
    }on Exception{
      emit(UserLeaveCalendarViewFailureState(firestoreFetchDataError));
    }
  }



  void _onDateRangeSelected(DateRangeSelectedEvent event, Emitter<UserLeaveCalendarViewState> emit){
    List<LeaveApplication> allLeave = [];
    if(state is UserLeaveCalendarViewSuccessState){
      UserLeaveCalendarViewSuccessState successState = state as UserLeaveCalendarViewSuccessState;
      allLeave = successState.allLeaveApplications;
    }
    if(event.endDate != null && event.startDate != null ){
      List rangeDates = List.generate(event.endDate!.difference(event.startDate!).inDays, (index) => event.startDate!.add(Duration(days: index)))..add(event.endDate);
      Set<LeaveApplication> leaveSet = {};
      for (DateTime date in rangeDates) {
        leaveSet.addAll(allLeave.where((la) => la.leave.findUserOnLeaveByDate(day: date)));
      }
      emit(UserLeaveCalendarViewSuccessState(leaveApplications: leaveSet.toList(),allLeaveApplications:allLeave));
    } else {
    List<LeaveApplication>  leaves = allLeave.where((la) => la.leave.findUserOnLeaveByDate(day: event.selectedDate ?? DateTime.now())).toList();
      emit(UserLeaveCalendarViewSuccessState(leaveApplications: leaves,allLeaveApplications: allLeave));
    }
  }


  void _onRemoveOrCancelLeaveApplication(RemoveOrCancelLeaveApplication event,Emitter<UserLeaveCalendarViewState> emit){
    UserLeaveCalendarViewSuccessState successState = state as UserLeaveCalendarViewSuccessState;
    List<LeaveApplication> leaveApplications = successState.leaveApplications.toList();
    List<LeaveApplication> allLeaves = successState.allLeaveApplications.toList();
    leaveApplications.remove(event.leaveApplication);
    allLeaves.remove(event.leaveApplication);
    emit(UserLeaveCalendarViewSuccessState(leaveApplications: leaveApplications, allLeaveApplications: allLeaves));
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

}
