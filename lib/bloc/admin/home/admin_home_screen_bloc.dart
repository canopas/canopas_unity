import 'dart:async';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/extensions/list.dart';
import 'package:projectunity/services/admin/requests/admin_leave_service.dart';
import 'package:projectunity/services/leave/user_leave_service.dart';
import 'package:rxdart/rxdart.dart';
import '../../../exception/error_const.dart';
import '../../../model/employee/employee.dart';
import '../../../model/leave/leave.dart';
import '../../../model/leave_application.dart';
import '../../../model/leave_count.dart';
import '../../../rest/api_response.dart';
import '../../../services/admin/employee/employee_service.dart';
import '../../../services/admin/paid_leave/paid_leave_service.dart';

@Injectable()
class AdminHomeScreenBloc extends BaseBLoc {

  //dependency
  final EmployeeService _employeeService;
  final AdminLeaveService _adminLeaveService;
  final PaidLeaveService _userPaidLeaveService;
  final UserLeaveService _userLeaveService;

  AdminHomeScreenBloc(this._employeeService, this._adminLeaveService,
      this._userPaidLeaveService, this._userLeaveService);

  //private variables
  final _leaveApplication = BehaviorSubject<ApiResponse<Map<DateTime, List<LeaveApplication>>>>();
  final BehaviorSubject<List<Employee>> _employees = BehaviorSubject<List<Employee>>();
  final _totalEmployees = BehaviorSubject<int>.seeded(0);
  final _totalRequest = BehaviorSubject<int>.seeded(0);
  final _absenceCount = BehaviorSubject<int>.seeded(0);


  //getters
  get totalEmployees => _totalEmployees;
  get totalRequest => _totalRequest;
  get absenceCount => _absenceCount;
  get leaveApplication => _leaveApplication;


  void _getAbsentEmployees() async {
    List<Leave> absentEmployees = await _adminLeaveService.getAllAbsence();
    _absenceCount.sink.add(absentEmployees.length);
  }

  void _getEmployees() {
    _employeeService.getEmployeesStream().listen((employees) {
      _employees.add(employees);
      _totalEmployees.add(employees.length);
    });
  }

  //functionality
  late StreamSubscription _leaveApplicationStream;
  void _listenStream() async {
    _leaveApplication.add(const ApiResponse.loading());

    try {
      _leaveApplicationStream = _combineStream.listen((event) async {
        List<LeaveApplication?> d = await event;
        _totalRequest.add(d.whereNotNull().length);
        Map<DateTime, List<LeaveApplication>> map = d.whereNotNull().groupBy(
                (leaveApplication) => leaveApplication.leave.appliedOn.dateOnly);
        _leaveApplication.add(ApiResponse.completed(data: map));
      });
    } on Exception {
      leaveApplication
          .add(const ApiResponse.error(error: firestoreFetchDataError));
    }
  }

  Stream<Future<List<LeaveApplication?>>> get _combineStream => Rx.combineLatest3(
      _adminLeaveService.getAllRequests(), _employees, _userPaidLeaveService.getPadLeavesAsStream(),
          (List<Leave> leaveList, List<Employee> employeeList, int paidLeaveCount) async {
        return await Future.wait(leaveList.map((leave) async {
          _totalEmployees.add(employeeList.length);

              final employee = employeeList
                  .firstWhereOrNull((element) => element.id == leave.uid);
              if (employee == null) {
                return null;
              }
              LeaveCounts leaveCounts = await _addLeaveCount(employee.id, paidLeaveCount);
          return LeaveApplication(
              leave: leave, employee: employee, leaveCounts: leaveCounts);
        })
            .whereNotNull()
            .toList());
      });

  Future<LeaveCounts> _addLeaveCount(String id,int paidLeaveCount) async {
    double usedLeave = await _userLeaveService.getUserUsedLeaveCount(id);
    double remainingLeaves = paidLeaveCount - usedLeave;
    return LeaveCounts(
        remainingLeaveCount: remainingLeaves < 0 ? 0 : remainingLeaves,
        usedLeaveCount: usedLeave,
        paidLeaveCount: paidLeaveCount);
  }

  @override
  void attach() async {
    _getAbsentEmployees();
    _getEmployees();
    _listenStream();
  }

  @override
  void detach() async {
    await _absenceCount.drain();
    _employees.close();
    _absenceCount.close();
    _totalRequest.close();
    _totalEmployees.close();
    _leaveApplication.close();
    _leaveApplicationStream.cancel();
  }
}
