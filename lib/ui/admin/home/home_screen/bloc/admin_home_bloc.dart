import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/extensions/list.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../data/Repo/leave_application_repo.dart';
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
  // final LeaveService _leaveService;
  // final EmployeeService _employeeService;
  final LeaveApplicationRepo leaveApplicationRepo;
  late final List<StreamSubscription<dynamic>> subscriptions;
  late  StreamSubscription<List<LeaveApplication>> leaveApplications;
  List<LeaveApplication> list=[];

  AdminHomeBloc(this.leaveApplicationRepo) : super(const AdminHomeState()) {
    subscriptions = <StreamSubscription<dynamic>>[
      leaveApplicationRepo.leaveRC.connect(),
      leaveApplicationRepo.employeeRC.connect()
    ];
    on<AdminHomeInitialLoadEvent>(_loadLeaveApplication);

  }

  Future<void> _loadLeaveApplication(
      AdminHomeInitialLoadEvent event, Emitter<AdminHomeState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      leaveApplications = Rx.combineLatest2(
          leaveApplicationRepo.leave$, leaveApplicationRepo.employee$,
          (List<Leave> leaves, List<Employee> employees) {
        return leaves
            .map((leave) {
              final employee =
                  employees.firstWhereOrNull((emp) => emp.uid == leave.uid);
              if (employee == null) {
                return null;
              } else {
                return LeaveApplication(leave: leave, employee: employee);
              }
            })
            .whereNotNull()
            .toList();
      }).listen((value) {
        emit(state.copyWith(
            status: Status.success, leaveAppMap: convertListToMap(value)));
      });

    } on Exception {
      emit(state.failureState(failureMessage: firestoreFetchDataError));
    }
  }

  //
  // Future<void> _loadLeaveApplications(
  //     AdminHomeInitialLoadEvent event, Emitter<AdminHomeState> emit) async {
  //   emit(state.copyWith(status: Status.loading));
  //   try {
  //     final List<Employee> employees = await _employeeService.getEmployees();
  //     final List<Leave> allRequests =
  //         await _leaveService.getLeaveRequestOfUsers();
  //     final List<LeaveApplication> leaveApplications = allRequests
  //         .map((leave) {
  //           final employee = employees
  //               .firstWhereOrNull((employee) => employee.uid == leave.uid);
  //           return employee == null
  //               ? null
  //               : LeaveApplication(employee: employee, leave: leave);
  //         })
  //         .whereNotNull()
  //         .toList();
  //     emit(state.copyWith(
  //         status: Status.success,
  //         leaveAppMap: convertListToMap(leaveApplications)));
  //   } catch (_) {
  //     emit(state.failureState(failureMessage: firestoreFetchDataError));
  //   }
  // }

  Map<DateTime, List<LeaveApplication>> convertListToMap(
      List<LeaveApplication> leaveApplications) {
    leaveApplications.sortedByDate();
    return leaveApplications.groupBy(
        (leaveApplication) => leaveApplication.leave.appliedOn.dateOnly);
  }

  @override
  Future<void> close() async {
    super.close();
    subscriptions.forEach((element) {
      element.cancel();
    });
    leaveApplications.cancel();
  }
}
