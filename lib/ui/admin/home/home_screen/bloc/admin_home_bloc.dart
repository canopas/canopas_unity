import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/extensions/list.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/model/leave/leave.dart';
import '../../../../../data/model/leave_application.dart';
import '../../../../../data/services/employee_service.dart';
import '../../../../../data/services/leave_service.dart';
import 'admin_home_event.dart';
import 'admin_home_state.dart';

@Injectable()
class AdminHomeBloc extends Bloc<AdminHomeEvent, AdminHomeState> {
  final LeaveService _leaveService;
  final EmployeeService _employeeService;

  late StreamSubscription _dBSubscription;

  AdminHomeBloc(this._leaveService, this._employeeService)
      : super(const AdminHomeState()) {
    on<UpdateLeaveRequestApplicationEvent>(_updateLeaveRequest);
    on<ShowErrorEvent>(_showError);
    _dBSubscription =
        Rx.combineLatest2<List<Employee>, List<Leave>, List<LeaveApplication>>(
      _employeeService.memberDBSnapshot(),
      _leaveService.leaveDBSnapshot(),
      leaveListAndEmployeeListToLeaveApplicationList,
    ).listen((leaveApplications) {
      add(UpdateLeaveRequestApplicationEvent(
          convertListToMap(leaveApplications)));
    }, onError: (error, _) {
      add(const ShowErrorEvent(firestoreFetchDataError));
    });
  }

  void _updateLeaveRequest(
      UpdateLeaveRequestApplicationEvent event, Emitter<AdminHomeState> emit) {
    emit(state.copyWith(
        status: Status.success, leaveAppMap: event.leaveRequestMap));
  }

  void _showError(ShowErrorEvent event, Emitter<AdminHomeState> emit) {
    emit(state.copyWith(status: Status.error, error: event.error));
  }

  List<LeaveApplication> leaveListAndEmployeeListToLeaveApplicationList(
      List<Employee> members, List<Leave> leaves) {
    return leaves
        .map((leave) {
          final employee =
              members.firstWhereOrNull((member) => member.uid == leave.uid);
          if (employee != null) {
            return LeaveApplication(employee: employee, leave: leave);
          }
          return null;
        })
        .whereNotNull()
        .toList();
  }

  Map<DateTime, List<LeaveApplication>> convertListToMap(
      List<LeaveApplication> leaveApplications) {
    leaveApplications.sortedByDate();
    return leaveApplications.groupBy(
        (leaveApplication) => leaveApplication.leave.appliedOn.dateOnly);
  }

  @override
  Future<void> close() {
    _dBSubscription.cancel();
    return super.close();
  }
}
