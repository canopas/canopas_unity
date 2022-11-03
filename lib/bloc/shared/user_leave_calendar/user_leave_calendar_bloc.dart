import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:rxdart/rxdart.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../exception/error_const.dart';
import '../../../model/date_range_model.dart';
import '../../../model/employee/employee.dart';
import '../../../model/leave/leave.dart';
import '../../../model/leave_application.dart';
import '../../../navigation/nav_stack/nav_stack_item.dart';
import '../../../navigation/navigation_stack_manager.dart';
import '../../../rest/api_response.dart';
import '../../../services/admin/employee/employee_service.dart';
import '../../../services/leave/user_leave_service.dart';
import 'package:collection/collection.dart';

@Injectable()
class UserLeaveCalendarBloc extends BaseBLoc {

  final UserLeaveService _userLeaveService;
  final NavigationStackManager _stackManager;
  final EmployeeService _employeeService;

  UserLeaveCalendarBloc(this._stackManager, this._userLeaveService, this._employeeService);

  final BehaviorSubject<CalendarFormat> _calendarFormat = BehaviorSubject<CalendarFormat>.seeded(CalendarFormat.month);
  Stream<CalendarFormat> get calendarFormat => _calendarFormat.stream;

  final BehaviorSubject<ApiResponse<List<LeaveApplication>>> _allLeaves = BehaviorSubject<ApiResponse<List<LeaveApplication>>>();
  Stream<ApiResponse<List<LeaveApplication>>> get allLeave => _allLeaves.stream;

  final BehaviorSubject<SelectedDateRange> _selectedDateRange = BehaviorSubject<SelectedDateRange>();
  BehaviorSubject<SelectedDateRange> get selectedDateRange => _selectedDateRange;

  List<LeaveApplication> _userLeaves = [];
  Employee? currentEmployee;

  getUserAllLeave({required String userID}) async {
    selectedDateRange.add(SelectedDateRange(selectedDate: DateTime.now()));
    _allLeaves.add(const ApiResponse.loading());
    currentEmployee = await _employeeService.getEmployee(userID);
    try {
       List<Leave>  leaves = await _userLeaveService.getAllLeavesOfUser(userID);
       _userLeaves = leaves.map((leave) => (currentEmployee == null)?null:LeaveApplication(employee: currentEmployee!, leave: leave)).whereNotNull().toList();
      _allLeaves.add(ApiResponse.completed(data: _userLeaves));
    }on Exception{
      _allLeaves.add(const ApiResponse.error(error: firestoreFetchDataError));
    }
  }

  getDateRangeLeaves(DateTime? startDate, DateTime? endDate, DateTime selectedDate){
    _allLeaves.add(const ApiResponse.loading());
    _selectedDateRange.add(SelectedDateRange(selectedDate: selectedDate, startDate: startDate, endDate: endDate));
    List<LeaveApplication> leaves = [];
    if(endDate != null && startDate != null ){
      List rangeDates = List.generate(endDate.difference(startDate).inDays, (index) => startDate.add(Duration(days: index)))..add(endDate);
      Set<LeaveApplication> leaveSet = {};
      for (DateTime date in rangeDates) {
        leaveSet.addAll(_userLeaves.where((la) =>
        (la.leave.startDate.dateOnly.isBefore(date.dateOnly) || la.leave.startDate.dateOnly.areSame(date.dateOnly))
            && (la.leave.endDate.dateOnly.isAfter(date.dateOnly) || la.leave.endDate.dateOnly.areSame(date.dateOnly))));
      }
      _allLeaves.add(ApiResponse.completed(data: leaveSet.toList()));
    } else {
      leaves = _userLeaves.where((la) =>
     (la.leave.startDate.dateOnly.isBefore(selectedDate.dateOnly) || la.leave.startDate.dateOnly.areSame(selectedDate.dateOnly))
         && (la.leave.endDate.dateOnly.isAfter(selectedDate.dateOnly) || la.leave.endDate.dateOnly.areSame(selectedDate.dateOnly))).toList();
     _allLeaves.add(ApiResponse.completed(data: leaves));
    }
  }

  changeCalendarFormat(CalendarFormat calendarFormat){
    _calendarFormat.add(calendarFormat);
  }

  void changeCalendarFormatBySwipe(int direction) {
    if(direction == 2){
      if(CalendarFormat.values.length-1>CalendarFormat.values.indexOf(_calendarFormat.value)){
        _calendarFormat.add(CalendarFormat.values.elementAt(CalendarFormat.values.indexOf(_calendarFormat.value)+1));
      }
    }else {
      if(CalendarFormat.values.indexOf(_calendarFormat.value)>0){
        _calendarFormat.add(CalendarFormat.values.elementAt(CalendarFormat.values.indexOf(_calendarFormat.value)-1));
      }
    }
  }

  void onLeaveCardTap(LeaveApplication leaveApplication){
    _stackManager.push(NavStackItem.leaveDetailState(leaveApplication));
  }

  List<LeaveApplication> getEventsOfDay(DateTime day){
    return _userLeaves.where((la) => (la.leave.startDate.dateOnly.isBefore(day.dateOnly) || la.leave.startDate.dateOnly.areSame(day.dateOnly))
        && (la.leave.endDate.dateOnly.isAfter(day.dateOnly) || la.leave.endDate.dateOnly.areSame(day.dateOnly)) ).toList();
  }

  @override
  void attach() {
  }

  @override
  void detach() {
    _userLeaves.clear();
    _calendarFormat.close();
    _allLeaves.close();
    _selectedDateRange.close();
  }




}