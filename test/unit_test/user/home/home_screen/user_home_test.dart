import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/auth_service.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_bloc.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_state.dart';

import 'user_home_test.mocks.dart';

@GenerateMocks([UserStateNotifier, LeaveService])
void main() {
  late UserHomeBloc bLoc;
  late UserStateNotifier userStateNotifier;
  late AuthService authService;
  late LeaveService leaveService;

  const employee = Employee(
    uid: "1",
    role: Role.employee,
    name: "test",
    employeeId: "103",
    email: "abc@gmail.com",
    designation: "android dev",
    dateOfJoining: 11,
  );
  final leave = Leave(
      leaveId: 'leaveId',
      uid: employee.uid,
      type: 2,
      startDate: DateTime.now().add(const Duration(days: 2)).timeStampToInt,
      endDate: DateTime.now().add(const Duration(days: 4)).timeStampToInt,
      total: 2,
      reason: 'Suffering from fever',
      status: LeaveStatus.pending,
      appliedOn: 12,
      perDayDuration: const [LeaveDayDuration.firstHalfLeave, LeaveDayDuration.firstHalfLeave]);

  setUp(() {
    userStateNotifier = MockUserStateNotifier();
    leaveService = MockLeaveService();
    bLoc = UserHomeBloc(userStateNotifier, leaveService);

    when(userStateNotifier.employeeId).thenReturn(employee.uid);
  });

  group('User home bloc state for requests', () {
    test('Emits initial state as state of bloc', () {
      expect((bLoc.state), UserHomeInitialState());
    });


  });
}
