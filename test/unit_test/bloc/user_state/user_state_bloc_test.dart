import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/Repo/employee_repo.dart';
import 'package:projectunity/data/Repo/leave_repo.dart';
import 'package:projectunity/data/bloc/user_state/user_state_bloc.dart';
import 'package:projectunity/data/bloc/user_state/user_state_event.dart';
import 'package:projectunity/data/provider/space_notifier.dart';
import 'package:projectunity/data/provider/user_status_notifier.dart';
import 'package:projectunity/data/services/space_service.dart';

import 'user_state_bloc_test.mocks.dart';

@GenerateMocks([
  SpaceNotifier,
  UserStatusNotifier,
  SpaceService,
  EmployeeRepo,
  LeaveRepo,
  UserStateBloc
])
void main() {
  late SpaceNotifier _spaceNotifier;
  late UserStatusNotifier _userStatusNotifier;
  late SpaceService _spaceService;
  late EmployeeRepo _employeeRepo;
  late LeaveRepo _leaveRepo;
  late UserStateBloc _userStateBloc;

  setUp(() {
    _spaceNotifier = MockSpaceNotifier();
    _userStatusNotifier = MockUserStatusNotifier();
    _spaceService = MockSpaceService();
    _leaveRepo = MockLeaveRepo();
    _employeeRepo = MockEmployeeRepo();
    when(_userStatusNotifier.state).thenReturn(UserStatus.unauthenticated);

    _userStateBloc = UserStateBloc(_employeeRepo, _leaveRepo,
        _userStatusNotifier, _spaceService, _spaceNotifier);
    when(_spaceNotifier.currentSpaceId).thenReturn('space-id');
  });

  group(
      'Verify the UserStatus by retrieving the user status from the stored data',
      () {
    late UserStateBloc _bloc;

    setUp(() {
      _bloc = MockUserStateBloc();
    });
    test(
        'Should not be add any event to bloc if UserStatus is not UserStatus.spaceJoined while initializing bloc',
        () async {
      when(_userStatusNotifier.state).thenReturn(UserStatus.unauthenticated);
      _bloc = MockUserStateBloc();
      verifyNever(_bloc.add(CheckSpaceEvent()));
    });
  });
}
