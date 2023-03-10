import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/services/employee_service.dart';
import 'package:projectunity/services/leave_service.dart';
import 'package:projectunity/services/paid_leave_service.dart';
import 'package:projectunity/ui/admin/home/home_screen/bloc/admin_home_bloc.dart';
import 'package:projectunity/ui/admin/home/home_screen/bloc/admin_home_event.dart';
import 'package:projectunity/ui/admin/home/home_screen/bloc/admin_home_state.dart';

import 'admin_home_bloc_test.mocks.dart';

@GenerateMocks([EmployeeService, LeaveService, PaidLeaveService])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late EmployeeService employeeService;
  late LeaveService leaveService;

  late AdminHomeBloc adminHomeBloc;

  Employee employee = const Employee(
      id: 'id',
      roleType: 1,
      name: 'Andrew jhone',
      employeeId: '100',
      email: 'andrew.j@canopas.com',
      designation: 'Android developer');

  Leave leave = const Leave(
      leaveId: 'leave-id',
      uid: 'id',
      leaveType: 2,
      startDate: 500,
      endDate: 600,
      totalLeaves: 2,
      reason: 'reason',
      leaveStatus: 2,
      appliedOn: 400,
      perDayDuration: [0, 1]);
  AdminHomeState initialState = const AdminHomeState();

  AdminHomeState loadingState = const AdminHomeState(
    status: AdminHomeStatus.loading,
  );

  AdminHomeState failureState = const AdminHomeState(
      status: AdminHomeStatus.failure, error: firestoreFetchDataError);

  setUp(() {
    employeeService = MockEmployeeService();
    leaveService = MockLeaveService();

    adminHomeBloc = AdminHomeBloc(
      leaveService,
      employeeService,
    );
  });

  group('AdminHomeScreenBloc', () {
    test('emits initial state after AdminHome screen is open', () {
      expect(adminHomeBloc.state, initialState);
    });
    test('Emits failure state due to any exception', () {
      when(leaveService.getAllAbsence()).thenAnswer((_) async {
        return [leave, leave];
      });

      when(employeeService.fetchEmployees())
          .thenThrow(Exception(firestoreFetchDataError));

      adminHomeBloc.add(AdminHomeInitialLoadEvent());

      expectLater(
          adminHomeBloc.stream, emitsInOrder([loadingState, failureState]));
    });

    test(
        'Emits loading state while fetching data from firestore and then emits Success state with  data with correct remaining leavews',
        () async {
      List<Employee> employeeList = [employee];
      List<Leave> leaveList = [leave];

      when(employeeService.employees)
          .thenAnswer((_) => Stream.fromIterable([employeeList]));
      when(leaveService.leaves)
          .thenAnswer((_) => Stream.fromIterable([leaveList]));

      adminHomeBloc.add(AdminHomeInitialLoadEvent());

      LeaveApplication la = LeaveApplication(
        employee: employee,
        leave: leave,
      );
      Map<DateTime, List<LeaveApplication>> map = {
        leave.startDate.toDate.dateOnly: [la]
      };
      AdminHomeState successState = AdminHomeState(
        status: AdminHomeStatus.success,
        leaveAppMap: map,
      );
      expectLater(
          adminHomeBloc.stream, emitsInOrder([loadingState, successState]));
    });

    test(
        'Emits state with status as success and list of leave application is empty when leave user id doesn\'t match with any user id',
        () {
      Employee empl = const Employee(
          id: 'user id',
          roleType: 2,
          name: 'Andrew jhone',
          employeeId: 'Ca 1254',
          email: 'andrew.j@canopas.com',
          designation: 'Android developer');

      List<Employee> employees = [empl];
      List<Leave> leaves = [leave];

      when(leaveService.getAllAbsence())
          .thenAnswer((_) async => [leave, leave]);
      when(employeeService.employees)
          .thenAnswer((_) => Stream.fromIterable([employees]));
      when(leaveService.leaves)
          .thenAnswer((_) => Stream.fromIterable([leaves]));

      adminHomeBloc.add(AdminHomeInitialLoadEvent());

      AdminHomeState successState = const AdminHomeState(
        status: AdminHomeStatus.success,
        leaveAppMap: {},
      );

      expectLater(adminHomeBloc.stream, emitsThrough(successState));
    });
  });

  tearDownAll(() async {
    await adminHomeBloc.close();
  });
}
