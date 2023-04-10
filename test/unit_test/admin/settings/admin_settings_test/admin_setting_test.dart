import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/data/services/auth_service.dart';
import 'package:projectunity/ui/admin/setting/bloc/admin_settings_bloc.dart';
import 'package:projectunity/ui/admin/setting/bloc/admin_settings_event.dart';
import 'package:projectunity/ui/admin/setting/bloc/admin_settings_state.dart';

import 'admin_setting_test.mocks.dart';

@GenerateMocks([AuthService, UserManager])
void main() {
  late AuthService authService;
  late AdminSettingsBloc adminSettingsBloc;
  late UserManager userManager;

  Employee employee = const Employee(
      id: 'id',
      roleType: 1,
      name: 'Andrew jhone',
      employeeId: '100',
      email: 'dummy123@testing.com',
      designation: 'Android developer');

  group("User settings test", () {
    setUp(() {
      authService = MockAuthService();
      userManager = MockUserManager();
      when(userManager.employee).thenReturn(employee);
      adminSettingsBloc =
          AdminSettingsBloc(userManager, authService);
    });

    test('get user data on screen is created test', () {
      expect(adminSettingsBloc.state.currentEmployee, employee);
    });

    test("log out successful test with navigation test", () async {
      when(authService.signOutWithGoogle())
          .thenAnswer((_) => Future(() => true));
      adminSettingsBloc.add(AdminSettingsLogOutEvent());
      expect(
          adminSettingsBloc.stream,
          emitsInOrder([
            AdminSettingsState(
                currentEmployee: employee, status: AdminSettingsStatus.loading),
            AdminSettingsState(
                currentEmployee: employee, status: AdminSettingsStatus.success),
          ]));
      await untilCalled(userManager.removeAll());
      verify(userManager.removeAll()).called(1);
    });

    test("log out failure test", () {
      when(authService.signOutWithGoogle())
          .thenAnswer((_) => Future(() => false));
      adminSettingsBloc.add(AdminSettingsLogOutEvent());
      expect(
          adminSettingsBloc.stream,
          emitsInOrder([
            AdminSettingsState(
                currentEmployee: employee, status: AdminSettingsStatus.loading),
            AdminSettingsState(
                currentEmployee: employee,
                status: AdminSettingsStatus.failure,
                error: signOutError),
          ]));
    });
  });
}
