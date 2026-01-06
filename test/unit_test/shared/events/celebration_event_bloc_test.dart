import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/ui/shared/events/bloc/celebrations_bloc.dart';
import 'package:projectunity/ui/shared/events/bloc/celebrations_event.dart';
import 'package:projectunity/ui/shared/events/bloc/celebrations_state.dart';
import 'package:projectunity/ui/shared/events/model/event.dart';
import 'celebration_event_bloc_test.mocks.dart';

@GenerateMocks([EmployeeService])
void main() {
  late EmployeeService employeeService;
  late CelebrationsBloc celebrationsBloc;
  const CelebrationsState celebrationsState = CelebrationsState();
  Employee employee1 = Employee(
    uid: "123",
    role: Role.employee,
    name: "dummy tester",
    employeeId: "CA-1000",
    email: "dummy.t@canopas.com",
    designation: "Application Tester",
    dateOfJoining: DateTime.now().dateOnly.add(const Duration(days: 360)),
    level: "SW-L2",
    gender: Gender.male,
    dateOfBirth: DateTime.now().dateOnly,
    address: "california",
    phone: "+1 000000-0000",
  );
  Employee employee2 = Employee(
    uid: "123",
    role: Role.employee,
    name: "dummy tester",
    employeeId: "CA-1000",
    email: "dummy.t@canopas.com",
    designation: "Application Tester",
    dateOfJoining: DateTime.now().dateOnly.add(const Duration(days: 367)),
    level: "SW-L2",
    gender: Gender.male,
    dateOfBirth: DateTime.now().add(const Duration(days: 7)).dateOnly,
  );

  Event birthEvent = Event(
    name: employee1.name,
    dateTime: employee1.dateOfBirth!,
    upcomingDate: employee1.dateOfBirth!.convertToUpcomingDay(),
    imageUrl: employee1.imageUrl,
  );
  Event anniversaryEvent2 = Event(
    name: employee2.name,
    dateTime: employee2.dateOfJoining,
    upcomingDate: employee2.dateOfJoining.convertToUpcomingDay(),
    imageUrl: employee1.imageUrl,
  );
  Event event2 = Event(
    name: employee2.name,
    dateTime: employee2.dateOfBirth!,
    upcomingDate: employee2.dateOfBirth!.convertToUpcomingDay(),
    imageUrl: employee2.imageUrl,
  );

  setUp(() {
    employeeService = MockEmployeeService();
    celebrationsBloc = CelebrationsBloc(employeeService);
  });

  group("All tests of events", () {
    test("Initial status test", () {
      expect(celebrationsBloc.state, celebrationsState);
    });

    test(
      "Test FetchCelebrations- emit loading state and then success state",
      () {
        when(
          employeeService.getEmployees(),
        ).thenAnswer((_) async => [employee1, employee2]);
        celebrationsBloc.add(FetchCelebrations());
        expectLater(
          celebrationsBloc.stream,
          emitsInOrder([
            const CelebrationsState(status: Status.loading),
            CelebrationsState(
              status: Status.success,
              birthdays: [birthEvent],
              anniversaries: [anniversaryEvent2],
            ),
          ]),
        );
      },
    );

    test(
      "Test ShowBirthdaysEvent- emit success state with all the birthdays",
      () {
        when(
          employeeService.getEmployees(),
        ).thenAnswer((_) async => [employee1, employee2]);
        celebrationsBloc.add(FetchCelebrations());
        celebrationsBloc.add(ShowBirthdaysEvent());

        final successState = CelebrationsState(
          status: Status.success,
          birthdays: [birthEvent],
          anniversaries: [anniversaryEvent2],
        );
        final allBdayState = successState.copyWith(
          showAllBdays: !celebrationsState.showAllBdays,
          birthdays: [birthEvent, event2],
          anniversaries: [anniversaryEvent2],
        );
        expectLater(
          celebrationsBloc.stream,
          emitsInOrder([
            const CelebrationsState(status: Status.loading),
            successState,
            allBdayState,
          ]),
        );
      },
    );

    test(
      "Test ShowAnniversariesEvent- emit success state with all the anniversary",
      () {
        when(
          employeeService.getEmployees(),
        ).thenAnswer((_) async => [employee1, employee2]);
        celebrationsBloc.add(FetchCelebrations());
        celebrationsBloc.add(ShowAnniversariesEvent());

        final successState = CelebrationsState(
          status: Status.success,
          birthdays: [birthEvent],
          anniversaries: [anniversaryEvent2],
        );
        final allAnniversariesState = successState.copyWith(
          showAllAnniversaries: !celebrationsState.showAllAnniversaries,
          birthdays: [birthEvent],
          anniversaries: [anniversaryEvent2],
        );
        expectLater(
          celebrationsBloc.stream,
          emitsInOrder([
            const CelebrationsState(status: Status.loading),
            successState,
            allAnniversariesState,
          ]),
        );
      },
    );
  });
}
