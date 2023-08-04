import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/repo/employee_repo.dart';
import 'package:projectunity/data/repo/leave_repo.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/model/leave_application.dart';
import 'package:projectunity/ui/admin/home/home_screen/bloc/admin_home_bloc.dart';
import 'package:projectunity/ui/admin/home/home_screen/bloc/admin_home_event.dart';
import 'package:projectunity/ui/admin/home/home_screen/bloc/admin_home_state.dart';

import 'admin_home_bloc_test.mocks.dart';

@GenerateMocks([EmployeeRepo, LeaveRepo])
void main() {
  late EmployeeRepo employeeRepo;
  late LeaveRepo leaveRepo;
  late AdminHomeBloc bloc;

  final employee = Employee(
    uid: 'uid',
    role: Role.admin,
    name: 'Andrew jhone',
    employeeId: 'CA 1254',
    email: 'andrew.j@canopas.com',
    designation: 'Android developer',
    dateOfJoining: DateTime(2000),
  );

  Leave leave = Leave(
      leaveId: 'leave-id',
      uid: 'uid',
      type: LeaveType.casualLeave,
      startDate: DateTime.now().dateOnly,
      endDate: DateTime.now().add(const Duration(days: 1)).dateOnly,
      total: 2,
      reason: 'reason',
      status: LeaveStatus.pending,
      appliedOn: DateTime.now().dateOnly,
      perDayDuration: const [
        LeaveDayDuration.noLeave,
        LeaveDayDuration.firstHalfLeave
      ]);

  setUp(() {
    employeeRepo = MockEmployeeRepo();
    leaveRepo = MockLeaveRepo();
    bloc = AdminHomeBloc(leaveRepo, employeeRepo);
  });

  group('Admin Home Bloc Test', () {
    test('Emits initial state after admin home initialized', () {
      expect(bloc.state, const AdminHomeState());
    });

    test('Emits success after fetch data', () {
      when(employeeRepo.employees).thenAnswer((_) => Stream.value([employee]));
      when(leaveRepo.pendingLeaves).thenAnswer((_) => Stream.value([leave]));
      bloc.add(AdminHomeInitialLoadEvent());
      expectLater(
          bloc.stream,
          emitsInOrder([
            const AdminHomeState(
              status: Status.loading,
            ),
            AdminHomeState(
              status: Status.success,
              leaveAppMap: bloc.convertListToMap([LeaveApplication(employee: employee, leave: leave)])
            ),
          ]));
    });

    test('Emits failure after fetch data', () {
      when(employeeRepo.employees).thenAnswer((_) => Stream.value([employee]));
      when(leaveRepo.pendingLeaves).thenAnswer((_) => Stream.error(firestoreFetchDataError));
      bloc.add(AdminHomeInitialLoadEvent());
      expectLater(
          bloc.stream,
          emitsInOrder([
            const AdminHomeState(
              status: Status.loading,
            ),
            const AdminHomeState(
                error: firestoreFetchDataError,
                status: Status.error,
            ),
          ]));
    });


  });
}
