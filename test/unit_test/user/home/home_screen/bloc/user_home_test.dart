import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/pref/user_preference.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/auth/auth_service.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_bloc.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_event.dart';

import 'user_home_test.mocks.dart';

@GenerateMocks([
  UserManager,
  AuthService,
  UserPreference,
])
void main() {
  late UserHomeBloc bLoc;
  late UserManager userManager;
  late AuthService authService;
  late UserPreference userPreference;

  const employee = Employee(
      id: "1",
      roleType: 2,
      name: "test",
      employeeId: "103",
      email: "abc@gmail.com",
      designation: "android dev");

  group('Navigation for user', () {
    setUp(() {
      userManager = MockUserManager();
      authService = MockAuthService();
      userPreference = MockUserPreference();
      bLoc = UserHomeBloc(userPreference, authService, userManager);

      when(authService.signOutWithGoogle())
          .thenAnswer((_) => Future(() => true));
      when(userPreference.removeCurrentUser())
          .thenAnswer((_) => Future(() => true));
      when(userManager.email).thenReturn(employee.email);

      when(userManager.employeeId).thenReturn(employee.id);
    });

    test(
        ' on UserDisable event User should be navigate to login screen if has been deleted successfully by admin',
        () async {
      when(userManager.employeeId).thenReturn(employee.id);
      bLoc.add(UserDisabled(employee.id));
      await untilCalled(authService.signOutWithGoogle());
      await untilCalled(userPreference.removeCurrentUser());
      await untilCalled(userManager.hasLoggedIn());
      verify(authService.signOutWithGoogle()).called(1);

      verify(userPreference.removeCurrentUser()).called(1);
      verify(userManager.hasLoggedIn()).called(1);
    });
  });

  tearDown(() {
    bLoc.close();
  });
}
