import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:rxdart/rxdart.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../exception/error_const.dart';
import '../../../model/leave/leave.dart';
import '../../../model/leave_application.dart';
import '../../../navigation/nav_stack/nav_stack_item.dart';
import '../../../navigation/navigation_stack_manager.dart';
import '../../../rest/api_response.dart';
import '../../../services/admin/employee/employee_service.dart';
import '../../../services/admin/requests/admin_leave_service.dart';


@Injectable()
class WhoIsOutCalendarBloc extends BaseBLoc{

  final EmployeeService _employeeService;
  final AdminLeaveService _adminLeaveService;
  final NavigationStackManager _stackManager;

  WhoIsOutCalendarBloc(this._employeeService, this._adminLeaveService, this._stackManager);

  final BehaviorSubject<DateTime> _focusedDate = BehaviorSubject.seeded(DateTime.now());
  BehaviorSubject<DateTime> get focusedDate => _focusedDate;

  final BehaviorSubject<CalendarFormat> _calendarFormat = BehaviorSubject<CalendarFormat>.seeded(CalendarFormat.month);
  Stream<CalendarFormat> get calendarFormat => _calendarFormat.stream;

  final BehaviorSubject<ApiResponse<List<LeaveApplication>>> _allLeaves = BehaviorSubject<ApiResponse<List<LeaveApplication>>>();
  Stream<ApiResponse<List<LeaveApplication>>> get allLeave => _allLeaves.stream;

  List<LeaveApplication> _allLeaveRef = [];

  _getAllLeaves() async {
    _allLeaves.add(const ApiResponse.loading());
    List<Leave> leaves = await _adminLeaveService.getAllLeaves();
    List<Employee> employees = await _employeeService.getEmployees();
    try {
      _allLeaveRef = leaves.map((leave) {
        final employee = employees.firstWhereOrNull((emp) => emp.id == leave.uid);
        return (employee==null)?null:LeaveApplication(employee: employee, leave: leave);
      }).whereNotNull().toList();
      _allLeaves.add(ApiResponse.completed(data: _getSelectedDatesLeaves(_focusedDate.value)));
    } on Exception catch (_){
      _allLeaves.add(const ApiResponse.error(error: firestoreFetchDataError));
    }
  }

  List<LeaveApplication> getEventsOfDay(DateTime day){
    return _getSelectedDatesLeaves(day);
  }

  List<LeaveApplication> _getSelectedDatesLeaves(DateTime day){
    List<LeaveApplication> selectedLeaves = _allLeaveRef.where((la)=>(la.leave.startDate.toDate.isBefore(day) || la.leave.startDate.dateOnly.isAtSameMomentAs(day.dateOnly)) &&
         (la.leave.endDate.toDate.isAfter(day.dateOnly) || la.leave.endDate.dateOnly.isAtSameMomentAs(day.dateOnly))
       ).toList();
    return selectedLeaves;
  }

  void selectDate(DateTime date, DateTime _){
    _focusedDate.add(date);
    _allLeaves.add(ApiResponse.completed(data: _getSelectedDatesLeaves(date)));
  }

  void changeCalendarFormat(CalendarFormat format){
    _calendarFormat.add(format);
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

  @override
  void attach() {
    _getAllLeaves();
  }


  @override
  void detach() {
    _focusedDate.close();
    _allLeaves.close();
    _allLeaveRef.clear();
    _calendarFormat.close();
  }

}