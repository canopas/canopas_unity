import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/extensions/list.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/provider/user_data.dart';
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
  StreamSubscription? _subscription;
  final UserManager _userManager;
  final StreamController<List<LeaveApplication>> applications =
      BehaviorSubject();

  AdminHomeBloc(this._leaveService, this._employeeService, this._userManager)
      : super(const AdminHomeState()) {
    on<AdminHomeInitialLoadEvent>(_loadLeaveApplications);
  }

  Future<void> _loadLeaveApplications(
      AdminHomeInitialLoadEvent event, Emitter<AdminHomeState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final List<Employee> employees = await _employeeService.getEmployees();
      final List<Leave> leaves = await _leaveService.getLeaveRequestOfUsers();

      final List<LeaveApplication> leaveApplications = leaves
          .map((leave) {
            final employee = employees
                .firstWhereOrNull((employee) => employee.uid == leave.uid);
            return employee == null
                ? null
                : LeaveApplication(employee: employee, leave: leave);
          })
          .whereNotNull()
          .toList();
      emit(state.copyWith(
          status: Status.success,
          leaveAppMap: convertListToMap(leaveApplications)));
    } catch (_) {
      emit(state.failureState(failureMessage: firestoreFetchDataError));
    }
  }

  Map<DateTime, List<LeaveApplication>> convertListToMap(
      List<LeaveApplication> leaveApplications) {
    leaveApplications.sortedByDate();
    return leaveApplications.groupBy(
        (leaveApplication) => leaveApplication.leave.appliedOn.dateOnly);
  }

  String get spaceName => _userManager.currentSpace!.name;
  String? get spaceDomain => _userManager.currentSpace?.domain;
  String? get spaceLogo => _userManager.currentSpace?.logo;

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    await applications.close();
    super.close();
  }
}
