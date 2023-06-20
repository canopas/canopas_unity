import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/ui/user/members/members_screen/bloc/user_members_bloc.dart';
import 'package:projectunity/ui/user/members/members_screen/bloc/user_members_state.dart';

import 'user_employees_test.mocks.dart';

@GenerateMocks([EmployeeService])
void main() {
  late UserMembersBloc bLoc;
  late EmployeeService memberService;

  final employee = Employee(
    uid: "1",
    role: Role.employee,
    name: "test",
    employeeId: "103",
    email: "abc@gmail.com",
    designation: "android dev",
    dateOfJoining: DateTime(2000),
  );

  setUp(() {
    memberService = MockEmployeeService();
  });

  group('User home bloc state for requests', () {
    test('listen realtime update in init state', () async {
      when(memberService.memberDBSnapshot())
          .thenAnswer((realInvocation) => Stream.value([employee]));
      bLoc = UserMembersBloc(memberService);
      expect(bLoc.state, UserMembersInitialState());
      expectLater(
          bLoc.stream,
          emitsInOrder([
            UserMembersLoadingState(),
            UserMembersSuccessState(employees: const [employee])
          ]));

      await untilCalled(memberService.memberDBSnapshot());
      verify(memberService.memberDBSnapshot()).called(1);
    });

    test('emit failure state with error on error', () async {
      when(memberService.memberDBSnapshot())
          .thenAnswer((realInvocation) => Stream.error("error"));
      bLoc = UserMembersBloc(memberService);
      expect(bLoc.state, UserMembersInitialState());
      expectLater(
          bLoc.stream,
          emitsInOrder([
            UserMembersLoadingState(),
            UserMembersFailureState(error: firestoreFetchDataError)
          ]));

      await untilCalled(memberService.memberDBSnapshot());
      verify(memberService.memberDBSnapshot()).called(1);
    });
  });
}
