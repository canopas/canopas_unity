import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/repo/employee_repo.dart';
import 'package:projectunity/ui/shared/events/bloc/celebrations_bloc.dart';
import 'package:projectunity/ui/shared/events/bloc/celebrations_event.dart';
import 'package:projectunity/ui/shared/events/bloc/celebrations_state.dart';
import 'package:projectunity/ui/shared/events/model/event.dart';

import '../../admin/home/home_screen/admin_home_bloc_test.mocks.dart';

@GenerateMocks([EmployeeRepo])
void main() {
  late EmployeeRepo employeeRepo;
  late CelebrationsBloc celebrationsBloc;
  const CelebrationsState celebrationsState = CelebrationsState();
  Employee employee1 = Employee(
      uid: "123",
      role: Role.employee,
      name: "dummy tester",
      employeeId: "CA-1000",
      email: "dummy.t@canopas.com",
      designation: "Application Tester",
      dateOfJoining: DateTime.now().dateOnly,
      level: "SW-L2",
      gender: Gender.male,
      dateOfBirth: DateTime.now().dateOnly,
      address: "california",
      phone: "+1 000000-0000");
  Employee employee2 = Employee(
    uid: "123",
    role: Role.employee,
    name: "dummy tester",
    employeeId: "CA-1000",
    email: "dummy.t@canopas.com",
    designation: "Application Tester",
    dateOfJoining: DateTime.now().add(const Duration(days: 7)).dateOnly,
    level: "SW-L2",
    gender: Gender.male,
    dateOfBirth: DateTime.now().add(const Duration(days: 7)).dateOnly,
  );

  Event event = Event(
      name: employee1.name,
      dateTime: employee1.dateOfBirth!,
      upcomingDate: employee1.dateOfBirth!.convertToUpcomingDay(),
      imageUrl: employee1.imageUrl);
  Event event2 = Event(
      name: employee2.name,
      dateTime: employee2.dateOfBirth!,
      upcomingDate: employee2.dateOfBirth!.convertToUpcomingDay(),
      imageUrl: employee2.imageUrl);

  setUp(() {
    employeeRepo = MockEmployeeRepo();
    celebrationsBloc = CelebrationsBloc(employeeRepo);
  });

  group("All tests of events", () {
    test("Initial status test", () {
      expect(celebrationsBloc.state, celebrationsState);
    });

    test("Test FetchCelebrations- emit loading state and then success state",
        () {
      when(employeeRepo.allEmployees).thenReturn([employee1, employee2]);
      celebrationsBloc.add(FetchCelebrations());
      expectLater(
        celebrationsBloc.stream,
        emitsInOrder([
          const CelebrationsState(status: Status.loading),
          CelebrationsState(
              status: Status.success,
              birthdays: [event],
              anniversaries: [event]),
        ]),
      );
    });

    test("Test ShowBirthdaysEvent- emit success state with all the birthdays",
        () {
      when(employeeRepo.allEmployees).thenReturn([employee1, employee2]);
      celebrationsBloc.add(FetchCelebrations());
      celebrationsBloc.add(ShowBirthdaysEvent());

      final successState = CelebrationsState(
          status: Status.success, birthdays: [event], anniversaries: [event]);
      final allBdayState = successState.copyWith(
          showAllBdays: !celebrationsState.showAllBdays,
          birthdays: [event, event2],
          anniversaries: [event]);
      expectLater(
        celebrationsBloc.stream,
        emitsInOrder([
          const CelebrationsState(status: Status.loading),
          successState,
          allBdayState
        ]),
      );
    });

    test(
        "Test ShowAnniversariesEvent- emit success state with all the anniversary",
        () {
      when(employeeRepo.allEmployees).thenReturn([employee1, employee2]);
      celebrationsBloc.add(FetchCelebrations());
      celebrationsBloc.add(ShowAnniversariesEvent());

      final successState = CelebrationsState(
          status: Status.success, birthdays: [event], anniversaries: [event]);
      final allAnniversariesState = successState.copyWith(
          showAllAnniversaries: !celebrationsState.showAllAnniversaries,
          birthdays: [event],
          anniversaries: [event, event2]);
      expectLater(
        celebrationsBloc.stream,
        emitsInOrder([
          const CelebrationsState(status: Status.loading),
          successState,
          allAnniversariesState
        ]),
      );
    });
  });
}
