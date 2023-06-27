import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/Repo/employee_repo.dart';
import 'package:projectunity/data/Repo/leave_repo.dart';
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

  final LeaveRepo leaveRepo;
  final EmployeeRepo employeeRepo;


  AdminHomeBloc(this.leaveRepo,this.employeeRepo) : super(const AdminHomeState()) {
    on<AdminHomeInitialLoadEvent>(_loadLeaveApplication);
  }

  Future<void> _loadLeaveApplication(
      AdminHomeInitialLoadEvent event, Emitter<AdminHomeState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
     return  emit.forEach(leaveApplications,
          onData: (List<LeaveApplication> applications)=>
         state.copyWith(
            status: Status.success,
            leaveAppMap: convertListToMap(applications))
      );
    } on Exception {
      emit(state.failureState(failureMessage: firestoreFetchDataError));
    }
  }

  Stream<List<LeaveApplication>> get leaveApplications => Rx.combineLatest2(
          leaveRepo.pendingLeaves, employeeRepo.employees,
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
      });


  Map<DateTime, List<LeaveApplication>> convertListToMap(
      List<LeaveApplication> leaveApplications) {
    leaveApplications.sortedByDate();
    return leaveApplications.groupBy(
        (leaveApplication) => leaveApplication.leave.appliedOn.dateOnly);
  }

}
