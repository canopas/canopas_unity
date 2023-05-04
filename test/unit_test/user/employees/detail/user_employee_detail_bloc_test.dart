import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:projectunity/ui/user/employees/detail/bloc/user_employee_detail_bloc.dart';
import 'package:projectunity/ui/user/employees/detail/bloc/user_employee_detail_event.dart';
import 'package:projectunity/ui/user/employees/detail/bloc/user_employee_detail_state.dart';

import 'user_employee_detail_bloc_test.mocks.dart';

@GenerateMocks([EmployeeService, LeaveService, UserEmployeeDetailBloc])
void main() {
  late EmployeeService employeeService;
  late LeaveService leaveService;
  late UserEmployeeDetailBloc bloc;

  Employee employee = const Employee(
      uid: 'uid',
      role: Role.admin,
      name: 'Andrew jhone',
      employeeId: 'employeeId',
      email: 'andrew.j@canopas.com',
      designation: 'Android develeoper');

  Leave upcomingApproveLeave = Leave(
      leaveId: 'leaveId',
      uid: 'uid',
      type: 2,
      startDate: DateTime.now().add(const Duration(days: 2)).timeStampToInt,
      endDate: DateTime.now().add(const Duration(days: 1)).timeStampToInt,
      total: 2,
      reason: 'Suffering from viral fever',
      status: approveLeaveStatus,
      appliedOn: 1,
      perDayDuration: const [LeaveDayDuration.firstHalfLeave, LeaveDayDuration.firstHalfLeave]);

  setUp(() {
    employeeService = MockEmployeeService();
    leaveService = MockLeaveService();
    bloc = UserEmployeeDetailBloc(employeeService, leaveService);
  });

  group('bloc state stream', () {
    test('emits UserEmployeeDetail Initial state as state of bloc', () {
      expect(bloc.state, UserEmployeeDetailInitialState());
    });

    test(
        'Emits loading state and success state after data is fetched successfully from firestore',
        () {
      when(employeeService.getEmployee(employee.uid))
          .thenAnswer((_) async => employee);
      when(leaveService.getUpcomingLeavesOfUser(employee.uid))
          .thenAnswer((_) async => [upcomingApproveLeave]);
      expectLater(
          bloc.stream,
          emitsInOrder([
            UserEmployeeDetailLoadingState(),
            UserEmployeeDetailSuccessState(
                employee: employee, upcomingLeaves: [upcomingApproveLeave])
          ]));
      bloc.add(UserEmployeeDetailFetchEvent(employeeId: employee.uid));
    });
    test(
        'Emits loading state and error state if employee is found null from firestore',
        () {
      when(employeeService.getEmployee(employee.uid))
          .thenAnswer((_) async => null);
      when(leaveService.getUpcomingLeavesOfUser(employee.uid))
          .thenAnswer((_) async => [upcomingApproveLeave]);
      expectLater(
          bloc.stream,
          emitsInOrder([
            UserEmployeeDetailLoadingState(),
            UserEmployeeDetailErrorState(error: firestoreFetchDataError)
          ]));
      bloc.add(UserEmployeeDetailFetchEvent(employeeId: employee.uid));
    });
    test(
        'Emits loading state and error state if exception is thrown from firestore',
        () {
      when(employeeService.getEmployee(employee.uid))
          .thenAnswer((_) async => null);
      when(leaveService.getUpcomingLeavesOfUser(employee.uid))
          .thenThrow(Exception(firestoreFetchDataError));
      expectLater(
          bloc.stream,
          emitsInOrder([
            UserEmployeeDetailLoadingState(),
            UserEmployeeDetailErrorState(error: firestoreFetchDataError)
          ]));
      bloc.add(UserEmployeeDetailFetchEvent(employeeId: employee.uid));
    });
  });
}
