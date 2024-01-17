import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/repo/employee_repo.dart';
import 'package:projectunity/data/repo/leave_repo.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/extensions/list.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/core/extensions/stream_extension.dart';
import '../../../../../data/model/leave_application.dart';
import 'admin_home_event.dart';
import 'admin_home_state.dart';

@Injectable()
class AdminHomeBloc extends Bloc<AdminHomeEvent, AdminHomeState> {
  final LeaveRepo leaveRepo;
  final EmployeeRepo employeeRepo;

  AdminHomeBloc(this.leaveRepo, this.employeeRepo)
      : super(const AdminHomeState()) {
    on<AdminHomeInitialLoadEvent>(_loadLeaveApplication);
  }

  Future<void> _loadLeaveApplication(
      AdminHomeInitialLoadEvent event, Emitter<AdminHomeState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      return emit.forEach(
        getLeaveApplicationStream(
            leaveStream: leaveRepo.pendingLeaves,
            membersStream: employeeRepo.employees),
        onData: (List<LeaveApplication> applications) => state.copyWith(
            status: Status.success,
            leaveAppMap: convertListToMap(applications)),
        onError: (error, stackTrace) =>
            state.failureState(failureMessage: firestoreFetchDataError),
      );
    } on Exception {
      emit(state.failureState(failureMessage: firestoreFetchDataError));
    }
  }

  Map<DateTime, List<LeaveApplication>> convertListToMap(
      List<LeaveApplication> leaveApplications) {
    leaveApplications
        .sort((a, b) => b.leave.appliedOn.compareTo(a.leave.appliedOn));
    return leaveApplications.groupBy(
        (leaveApplication) => leaveApplication.leave.appliedOn.dateOnly);
  }
}
