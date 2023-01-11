import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/extensions/list.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/ui/admin/home/bloc/admin_home_event.dart';
import 'package:projectunity/ui/admin/home/bloc/admin_home_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../model/employee/employee.dart';
import '../../../../model/leave/leave.dart';
import '../../../../model/leave_count.dart';
import '../../../../services/admin/employee_service.dart';
import '../../../../services/admin/paid_leave_service.dart';
import '../../../../services/admin/leave_service.dart';
import '../../../../services/user/user_leave_service.dart';

@Injectable()
class AdminHomeBloc extends Bloc<AdminHomeEvent, AdminHomeState> {
  final AdminLeaveService _adminLeaveService;
  final EmployeeService _employeeService;
  final UserLeaveService _userLeaveService;
  final PaidLeaveService _paidLeaveService;
  StreamSubscription? _subscription;
  List<Employee> employees=[];
  final StreamController<List<LeaveApplication>> applications =
  BehaviorSubject();

  AdminHomeBloc(this._adminLeaveService,this._employeeService,this._userLeaveService,this._paidLeaveService)
      : super(const AdminHomeState()) {
    on<AdminHomeInitialLoadEvent>(_onPageLoad);
  }

  void _onPageLoad(
      AdminHomeInitialLoadEvent event, Emitter<AdminHomeState> emit) async {
    emit(state.copyWith(status: AdminHomeStatus.loading));

   await   _addTotalOfAbsence(emit);
   await  _loadLeaveApplications(event, emit);
  }

  Future<void> _addTotalOfAbsence(Emitter<AdminHomeState> emit) async {
    List<Leave> absence = await _adminLeaveService.getAllAbsence();
    emit(state.copyWith(totalAbsence: absence.length));
  }

  Future<void> _loadLeaveApplications(
      AdminHomeInitialLoadEvent event, Emitter<AdminHomeState> emit) async {
    await _subscription?.cancel();
    try {
      await emit
          .forEach<List<LeaveApplication>>(_changeLeaveApplicationFormat(),
              onData: (List<LeaveApplication> leaveApplications) {
        return state.copyWith(
          status: AdminHomeStatus.success,
          leaveAppMap: convertListToMap(leaveApplications),
          totalOfEmployees: employees.length,
          totalOfRequests: leaveApplications.length,
        );
      });
    } catch (_) {
      emit( state.failureState(failureMessage: firestoreFetchDataError));
    }
  }

  Stream<List<LeaveApplication>> _changeLeaveApplicationFormat() {

    _subscription = combineStream.listen((event) async {
      List<LeaveApplication> list = [];
      event.isEmpty
          ? applications.sink.add(list)
          : Future.wait(event.map((leaveApplication) async {
              LeaveApplication application =
                  await _addLeavesTo(leaveApplication);
              list.add(application);
              applications.sink.add(list);
            }));
    });
    return applications.stream;
  }

  Stream<List<LeaveApplication>> get combineStream => Rx.combineLatest2(
          _adminLeaveService.leaves,
          _employeeService.employees, (
        List<Leave> leaveList,
        List<Employee> employeeList,
      ) {
        employees = employeeList;
        return  leaveList
            .map((leave) {
              final employee = employeeList
                  .firstWhereOrNull((element) => element.id == leave.uid);
              if (employee == null) {
                return null;
              }
              return LeaveApplication(leave: leave, employee: employee);
            })
            .whereNotNull()
            .toList();
      });

  Future<LeaveApplication> _addLeavesTo(LeaveApplication application) async {
    int paidLeaves = await _paidLeaveService.getPaidLeaves();
    double usedLeave =
        await _userLeaveService.getUserUsedLeaveCount(application.employee.id);
    double remainingLeaves = paidLeaves - usedLeave;
    LeaveCounts leaveCounts = LeaveCounts(
        remainingLeaveCount: remainingLeaves < 0 ? 0 : remainingLeaves,
        usedLeaveCount: usedLeave,
        paidLeaveCount: paidLeaves);
    return LeaveApplication(
        employee: application.employee,
        leave: application.leave,
        leaveCounts: leaveCounts);
  }


  Map<DateTime, List<LeaveApplication>> convertListToMap(
      List<LeaveApplication> leaveApplications) {
    return leaveApplications.groupBy(
        (leaveApplication) => leaveApplication.leave.appliedOn.dateOnly);
  }

  @override
  Future<void> close() async {
   await _subscription?.cancel();
    await applications.close();
    super.close();
  }
}
