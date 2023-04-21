import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/space/space.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/space_service.dart';
import 'package:projectunity/ui/space/create_space/bloc/create_workspace_bloc.dart';
import 'package:projectunity/ui/space/create_space/bloc/create_workspace_event.dart';
import 'package:projectunity/ui/space/create_space/bloc/create_workspace_state.dart';

import 'create_space_bloc_test.mocks.dart';

@GenerateMocks([SpaceService, UserManager, EmployeeService])
void main() {
  late SpaceService spaceService;
  late UserManager userManager;
  late EmployeeService employeeService;
  late CreateSpaceBLoc bloc;
  late CreateSpaceState createSpaceState;
  setUp(() {
    spaceService = MockSpaceService();
    userManager = MockUserManager();
    employeeService = MockEmployeeService();
    when(userManager.userFirebaseAuthName).thenReturn('user name');
    bloc = CreateSpaceBLoc(spaceService, userManager, employeeService);
    createSpaceState = const CreateSpaceState(ownerName: 'user name');
  });

  group('Page Change Event', () {
    test(
        'Button state is disable as index is equal to tab 1 when create space is open',
            () {
          expect(bloc.state.buttonState, ButtonState.disable);
        });
    test('Button state is disable of tab 2 when change tab from tab controller',
            () {
          bloc.add(PageChangeEvent(page: 1));
          expect(createSpaceState.buttonState, ButtonState.disable);
        });
    test('Button state is disable of tab 3 when change tab from tab controller',
            () {
          bloc.add(PageChangeEvent(page: 1));
          expect(createSpaceState.buttonState, ButtonState.disable);
        });
  });

  group('Tab 1 Test', () {

    test(
        'Error Shown when company name input is less than 4 character or empty',
            () {
          bloc.add(CompanyNameChangeEvent(companyName: 'can'));
          CreateSpaceState stateWithCompanyNameError = const CreateSpaceState(
              companyName: 'can',
              ownerName: 'user name',
              buttonState: ButtonState.disable,
              companyNameError: true);
          expectLater(bloc.stream, emitsInOrder([stateWithCompanyNameError]));
        });
    test(
        ' Error is not shown when Company name input is more than or equal to  4 characters ',
            () {
          bloc.add(CompanyNameChangeEvent(companyName: 'cano'));
          CreateSpaceState stateWithValidCompanyName = const CreateSpaceState(
              companyName: 'cano',
              ownerName: 'user name',
              buttonState: ButtonState.enable,
              companyNameError: false);
          expectLater(bloc.stream, emitsInOrder([stateWithValidCompanyName]));
        });
    test(
        ' Error shown when domain name input is less than  4 characters and does not contains "." ',
            () {
          bloc.add(CompanyDomainChangeEvent(domain: 'www'));
          CreateSpaceState stateWithINValidDomain = const CreateSpaceState(
              domain: 'www',
              ownerName: 'user name',
              buttonState: ButtonState.disable,
              domainError: true);
          expectLater(bloc.stream, emitsInOrder([stateWithINValidDomain]));
        });
    test(
        ' Error is not shown when domain name input is more than or equal to  4 characters and contains "." ',
            () {
          bloc.add(CompanyDomainChangeEvent(domain: 'www.'));
          CreateSpaceState stateWithValidDomain = const CreateSpaceState(
              domain: 'www.',
              ownerName: 'user name',
              buttonState: ButtonState.disable,
              domainError: false);
          expectLater(bloc.stream, emitsInOrder([stateWithValidDomain]));
        });

    test(
        ' Button State is enable if name input is valid and domain is empty as domain is optional;',
            () {
          bloc.add(CompanyNameChangeEvent(companyName: 'canopas'));
          bloc.add(CompanyDomainChangeEvent(domain: ''));
          CreateSpaceState stateWithEmptyDomain = const CreateSpaceState(
              companyName: 'canopas',
              companyNameError: false,
              domain: '',
              ownerName: 'user name',
              buttonState: ButtonState.enable,
              domainError: false);
          expectLater(bloc.stream, emitsInOrder([stateWithEmptyDomain]));
        });
  });

  group('Tab 2 Test', () {
    test('Next button state is enable if user input for paid time off is valid',
            () {
          bloc.add(PaidTimeOffChangeEvent(paidTimeOff: '12'));
          CreateSpaceState stateWithValidTimeOff = const CreateSpaceState(
              ownerName: 'user name',
              paidTimeOff: '12',
              paidTimeOffError: false,
              buttonState: ButtonState.enable);
          expectLater(bloc.stream, emitsInOrder([stateWithValidTimeOff]));
        });
    test(
        'Next button state is disable and shows error when user enter input and the erase it',
            () {
          bloc.add(PaidTimeOffChangeEvent(paidTimeOff: '12'));
          bloc.add(PaidTimeOffChangeEvent(paidTimeOff: ''));
          CreateSpaceState stateWithValidTimeOff = const CreateSpaceState(
              ownerName: 'user name',
              paidTimeOff: '12',
              paidTimeOffError: false,
              buttonState: ButtonState.enable);
          CreateSpaceState stateWithINValidTimeOff = const CreateSpaceState(
              ownerName: 'user name',
              paidTimeOff: '',
              paidTimeOffError: true,
              buttonState: ButtonState.disable);
          expectLater(bloc.stream,
              emitsInOrder([stateWithValidTimeOff, stateWithINValidTimeOff]));
        });
  });

  group('Tab 3 Test', () {
    test('Emits state with username from userManager', () {
      expect(bloc.state.ownerName, 'user name');
    });

    test(
        'Emits state without error if name input contains more than or equal to 4 characters',
            () {
          bloc.add(UserNameChangeEvent(name: 'Andrew'));
          CreateSpaceState stateWithValidNameInput = const CreateSpaceState(
              ownerName: 'Andrew',
              buttonState: ButtonState.enable,
              ownerNameError: false);
          expect(bloc.stream, emitsInOrder([stateWithValidNameInput]));
        });
    test('Emits state with error if name input contains less than 4 characters',
            () {
          bloc.add(UserNameChangeEvent(name: 'And'));
          CreateSpaceState stateWithINValidNameInput = const CreateSpaceState(
              ownerName: 'And',
              buttonState: ButtonState.disable,
              ownerNameError: true);
          expect(bloc.stream, emitsInOrder([stateWithINValidNameInput]));
        });
  });

  group('Validate space data from 3 tab Input', ()
  {
    test(
        'Emits state with loading and then success state if User input is valid with all required data',
            () async {
          bloc.add(CompanyNameChangeEvent(companyName: 'canopas'));
          bloc.add(PaidTimeOffChangeEvent(paidTimeOff: '12'));
          bloc.add(CreateSpaceButtonTapEvent());
          when(userManager.userUID).thenReturn('uid');
          when(userManager.userEmail).thenReturn('andrew.j@canopas.com');
          CreateSpaceState stateWithValidCompanyName = const CreateSpaceState(
              companyName: 'canopas',
              ownerName: 'user name',
              buttonState: ButtonState.enable,
              companyNameError: false);
          CreateSpaceState stateWithValidTimeOff = const CreateSpaceState(
              companyName: 'canopas',
              ownerName: 'user name',
              paidTimeOff: '12',
              paidTimeOffError: false,
              buttonState: ButtonState.enable);
          CreateSpaceState stateWithValidNameInput = const CreateSpaceState(
              companyName: 'canopas',
              paidTimeOff: '12',
              ownerName: 'user name',
              buttonState: ButtonState.enable,
              ownerNameError: false);
          CreateSpaceState loadingState = const CreateSpaceState(
              companyName: 'canopas',
              paidTimeOff: '12',
              ownerName: 'user name',
              buttonState: ButtonState.enable,
              createSpaceStatus: CreateSpaceStatus.loading
          );
          CreateSpaceState successState = const CreateSpaceState(
              companyName: 'canopas',
              paidTimeOff: '12',
              ownerName: 'user name',
              buttonState: ButtonState.enable,
              createSpaceStatus: CreateSpaceStatus.success
          );

          Space space=  Space(id: 'space-id',
              name: stateWithValidNameInput.companyName,
              createdAt: DateTime.now(),
              paidTimeOff: 12,
              ownerIds: ['uid']);
          Employee employee = const Employee(uid: 'uid', name: 'user name', email: 'andrew.j@canopas.com');


          when(employeeService.addEmployeeBySpaceId(employee: employee, spaceId: 'space-id')).thenAnswer((_)async{} );
          when(userManager.setSpace(space: space, spaceUser: employee)).thenAnswer((_) async=> {});

          when(spaceService.createSpace(
            name: stateWithValidNameInput.companyName,
            domain: '',
            timeOff: int.parse(stateWithValidTimeOff.paidTimeOff),
            ownerId: 'uid',
          )).thenAnswer((_) async =>space);

          expectLater(
              bloc.stream,
              emitsInOrder([
                stateWithValidCompanyName,
                stateWithValidTimeOff,
                loadingState,
                successState
              ]));


          await untilCalled(spaceService.createSpace( name: stateWithValidNameInput.companyName,
            domain: '',
            timeOff: int.parse(stateWithValidTimeOff.paidTimeOff),
            ownerId: 'uid',
          ));
          verify(spaceService.createSpace( name: stateWithValidNameInput.companyName,
            domain: '',
            timeOff: int.parse(stateWithValidTimeOff.paidTimeOff),
            ownerId: 'uid',)).called(1);

        });
    test('Emits error state while exception is thrown by firestore', ()async {

      bloc.add(CompanyNameChangeEvent(companyName: 'canopas'));
      bloc.add(PaidTimeOffChangeEvent(paidTimeOff: '12'));
      bloc.add(CreateSpaceButtonTapEvent());
      when(userManager.userUID).thenReturn('uid');
      when(userManager.userEmail).thenReturn('andrew.j@canopas.com');
      CreateSpaceState stateWithValidCompanyName = const CreateSpaceState(
          companyName: 'canopas',
          ownerName: 'user name',
          buttonState: ButtonState.enable,
          companyNameError: false);
      CreateSpaceState stateWithValidTimeOff = const CreateSpaceState(
          companyName: 'canopas',
          ownerName: 'user name',
          paidTimeOff: '12',
          paidTimeOffError: false,
          buttonState: ButtonState.enable);
      CreateSpaceState stateWithValidNameInput = const CreateSpaceState(
          companyName: 'canopas',
          paidTimeOff: '12',
          ownerName: 'user name',
          buttonState: ButtonState.enable,
          ownerNameError: false);
      CreateSpaceState loadingState = const CreateSpaceState(
          companyName: 'canopas',
          paidTimeOff: '12',
          ownerName: 'user name',
          buttonState: ButtonState.enable,
          createSpaceStatus: CreateSpaceStatus.loading
      );
      CreateSpaceState errorState = const CreateSpaceState(
          companyName: 'canopas',
          paidTimeOff: '12',
          ownerName: 'user name',
          buttonState: ButtonState.enable,
          createSpaceStatus: CreateSpaceStatus.error,
          error: firestoreFetchDataError
      );

      Space space=  Space(id: 'space-id',
          name: stateWithValidNameInput.companyName,
          createdAt: DateTime.now(),
          paidTimeOff: 12,
          ownerIds: ['uid']);
      Employee employee = const Employee(uid: 'uid', name: 'user name', email: 'andrew.j@canopas.com');


      when(employeeService.addEmployeeBySpaceId(employee: employee, spaceId: 'space-id')).thenAnswer((_)async{} );
      when(userManager.setSpace(space: space, spaceUser: employee)).thenThrow(Exception(firestoreFetchDataError));

      when(spaceService.createSpace(
        name: stateWithValidNameInput.companyName,
        domain: '',
        timeOff: int.parse(stateWithValidTimeOff.paidTimeOff),
        ownerId: 'uid',
      )).thenThrow(Exception(firestoreFetchDataError));

      expectLater(
          bloc.stream,
          emitsInOrder([
            stateWithValidCompanyName,
            stateWithValidTimeOff,
            loadingState,
            errorState
          ]));

      await untilCalled(spaceService.createSpace( name: stateWithValidNameInput.companyName,
        domain: '',
        timeOff: int.parse(stateWithValidTimeOff.paidTimeOff),
        ownerId: 'uid',
      ));
      verify(spaceService.createSpace( name: stateWithValidNameInput.companyName,
        domain: '',
        timeOff: int.parse(stateWithValidTimeOff.paidTimeOff),
        ownerId: 'uid',)).called(1);
    });

  });
}

