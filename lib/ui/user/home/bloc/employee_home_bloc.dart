import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/event_bus/events.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/provider/user_data.dart';
import '../../../../model/employee/employee.dart';
import '../../../../model/leave/leave.dart';
import '../../../../model/leave_application.dart';
import '../../../../model/leave_count.dart';
import '../../../../pref/user_preference.dart';
import '../../../../services/admin/employee_service.dart';
import '../../../../services/admin/paid_leave_service.dart';
import '../../../../services/admin/leave_service.dart';
import '../../../../services/user/user_leave_service.dart';
import '../../../../services/auth/auth_service.dart';
import 'employee_home_event.dart';
import 'employee_home_state.dart';

@Injectable()
class EmployeeHomeBloc extends Bloc<EmployeeHomeEvent, EmployeeHomeState> {
  final UserLeaveService _userLeaveService;
  final UserManager _userManager;
  final PaidLeaveService _paidLeaveService;
  final EmployeeService _employeeService;
  final AdminLeaveService _leaveService;
  final UserPreference _userPreference;
  final AuthService _authService;
 StreamSubscription? _streamSubscription;
  EmployeeHomeBloc(this._userManager,
      this._userLeaveService,
      this._paidLeaveService,
      this._employeeService,
      this._leaveService, this._userPreference, this._authService)
      : super(const EmployeeHomeState()) {
    on<EmployeeHomeFetchEvent>(_load);
    on<UserDisabled>(_removeUser);
    _streamSubscription= eventBus.on<DeleteEmployeeByAdmin>().listen((event) {add(UserDisabled(event.userId)); });
  }

  String get userID => _userManager.employeeId;

  FutureOr<void> _load(
      EmployeeHomeEvent event, Emitter<EmployeeHomeState> emit) async {
    emit(state.copyWith(status: EmployeeHomeStatus.loading));
    await _fetchSummary(emit);
    await _getAbsenceEmployees(emit);
  }
  Future<void> _removeUser(UserDisabled event, Emitter<EmployeeHomeState> emit)async {
    if (event.employeeId == _userManager.employeeId) {
      try {
        await _authService.signOutWithGoogle();
        await _userPreference.removeCurrentUser();
        _userManager.hasLoggedIn();
      } on Exception {
        throw Exception(somethingWentWrongError);
      }
    }
  }

  Future<void> _fetchSummary(Emitter<EmployeeHomeState> emit) async {
    try {
      double usedLeaveCount = await _userLeaveService
          .getUserUsedLeaveCount(_userManager.employeeId);
      int paidLeaves = await _paidLeaveService.getPaidLeaves();
      double availableLeaveCount =
          paidLeaves < usedLeaveCount ? 0 : paidLeaves - usedLeaveCount;

      final leaveCounts = LeaveCounts(
          remainingLeaveCount: availableLeaveCount,
          usedLeaveCount: usedLeaveCount,
          paidLeaveCount: paidLeaves);

      emit(state.copyWith(leaveCounts: leaveCounts));
    } on Exception catch (_) {
      emit(state.failure(error: firestoreFetchDataError));
    }
  }

 Future<void> _getAbsenceEmployees(Emitter<EmployeeHomeState> emit) async {
    try {
      List<Employee> employees = await _employeeService.getEmployees();
      List<Leave> absenceLeaves = await _leaveService.getAllAbsence();

      List<LeaveApplication> absenceEmployee = absenceLeaves
          .map((leave) {
            final employee =
                employees.firstWhereOrNull((emp) => emp.id == leave.uid);
            return (employee == null)
                ? null
                : LeaveApplication(employee: employee, leave: leave);
          })
          .whereNotNull()
          .toList();

      emit(state.copyWith(
          status: EmployeeHomeStatus.success, absence: absenceEmployee));
    } on Exception catch (_) {
      emit(state.failure(error: firestoreFetchDataError));
    }
  }

  @override
  Future<void> close() async{
    await _streamSubscription?.cancel();
    return super.close();
  }


}
