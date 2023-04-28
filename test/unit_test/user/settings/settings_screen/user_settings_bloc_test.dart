import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/data/services/auth_service.dart';
import 'package:projectunity/ui/user/settings/settings_screen/bloc/user_settings_bloc.dart';
import 'package:projectunity/ui/user/settings/settings_screen/bloc/user_settings_event.dart';
import 'package:projectunity/ui/user/settings/settings_screen/bloc/user_settings_state.dart';

import 'user_settings_bloc_test.mocks.dart';

@GenerateMocks([AuthService, UserManager])
void main() {
  late AuthService authService;
  late UserSettingsBloc userSettingsBloc;
  late UserManager userManager;

  Employee employee = const Employee(
      uid: 'id',
      role: Role.admin,
      name: 'Andrew jhone',
      employeeId: '100',
      email: 'dummy123@testing.com',
      designation: 'Android developer');

  group("User settings test", () {
    setUp(() {
      authService = MockAuthService();
      userManager = MockUserManager();
      when(userManager.employee).thenReturn(employee);
      userSettingsBloc = UserSettingsBloc(userManager, authService);
    });

    test('get user data on screen is created test', () {
      expect(userSettingsBloc.state.currentEmployee, employee);
    });

    test("log out successful test with navigation test", () async {
      when(authService.signOutWithGoogle())
          .thenAnswer((_) => Future(() => true));
      userSettingsBloc.add(UserSettingsLogOutEvent());
      expect(
          userSettingsBloc.stream,
          emitsInOrder([
            UserSettingsState(
                currentEmployee: employee, status: Status.loading),
            UserSettingsState(
                currentEmployee: employee, status: Status.success),
          ]));
      await untilCalled(userManager.removeAll());
      verify(userManager.removeAll()).called(1);
    });

    test("log out failure test", () {
      when(authService.signOutWithGoogle())
          .thenAnswer((_) => Future(() => false));
      userSettingsBloc.add(UserSettingsLogOutEvent());
      expect(
          userSettingsBloc.stream,
          emitsInOrder([
            UserSettingsState(
                currentEmployee: employee, status: Status.loading),
            UserSettingsState(
                currentEmployee: employee,
                status: Status.error,
                error: signOutError),
          ]));
    });
  });
}
