import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/services/admin/paid_leave/paid_leave_service.dart';
import 'package:projectunity/ui/shared/user_leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_states.dart';
import '../../../../../core/extensions/leave_extension.dart';
import '../../../../../model/leave_count.dart';
import '../../../../../navigation/navigation_stack_manager.dart';
import '../../../../../services/admin/employee/employee_service.dart';
import '../../../../../services/leave/user_leave_service.dart';
import 'user_leave_calendar_events.dart';
import '../../../../../exception/error_const.dart';
import '../../../../../model/employee/employee.dart';
import '../../../../../model/leave/leave.dart';
import '../../../../../model/leave_application.dart';
import '../../../../../navigation/nav_stack/nav_stack_item.dart';
import 'package:collection/collection.dart';

@Injectable()
class UserLeaveCalendarViewBloc extends Bloc<UserLeaveCalendarEvent,UserLeaveCalendarViewState>{

  final UserLeaveService _userLeaveService;
  final NavigationStackManager _stackManager;
  final EmployeeService _employeeService;
  final PaidLeaveService _paidLeaveService;

  UserLeaveCalendarViewBloc( this._userLeaveService, this._stackManager, this._employeeService, this._paidLeaveService) :
        super(UserLeaveCalendarViewInitialState()) {
    on<UserLeaveCalendarInitialLoadEvent>(_loadAllLeaves);
    on<DateRangeSelectedEvent>(_onDateRangeSelected);
    on<LeaveTypeCardTapEvent>(_onLeaveTypeCardTap);
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
      emit(UserLeaveCalendarViewSuccessState(leaveApplication: userLeaves, allLeaves: userLeaves));
    }on Exception{
      emit(UserLeaveCalendarViewFailureState(firestoreFetchDataError));
    }
  }



  void _onDateRangeSelected(DateRangeSelectedEvent event, Emitter<UserLeaveCalendarViewState> emit){
    List<LeaveApplication> allLeave = [];
    if(state is UserLeaveCalendarViewSuccessState){
      UserLeaveCalendarViewSuccessState successState = state as UserLeaveCalendarViewSuccessState;
      allLeave = successState.allLeaves;
    }
    if(event.endDate != null && event.startDate != null ){
      List rangeDates = List.generate(event.endDate!.difference(event.startDate!).inDays, (index) => event.startDate!.add(Duration(days: index)))..add(event.endDate);
      Set<LeaveApplication> leaveSet = {};
      for (DateTime date in rangeDates) {
        leaveSet.addAll(allLeave.where((la) => la.leave.findUserOnLeaveByDate(day: date)));
      }
      emit(UserLeaveCalendarViewSuccessState(leaveApplication: leaveSet.toList(),allLeaves:allLeave));
    } else {
    List<LeaveApplication>  leaves = allLeave.where((la) => la.leave.findUserOnLeaveByDate(day: event.selectedDate ?? DateTime.now())).toList();
      emit(UserLeaveCalendarViewSuccessState(leaveApplication: leaves,allLeaves: allLeave));
    }
  }

  void _onLeaveTypeCardTap(LeaveTypeCardTapEvent event, Emitter<UserLeaveCalendarViewState> emit){
      _stackManager.push(NavStackItem.leaveDetailState(event.leaveApplication));
  }

}
