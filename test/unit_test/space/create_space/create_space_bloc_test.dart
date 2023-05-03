import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/space/space.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/space_service.dart';
import 'package:projectunity/data/services/storage_service.dart';
import 'package:projectunity/ui/space/create_space/bloc/create_workspace_bloc.dart';
import 'package:projectunity/ui/space/create_space/bloc/create_workspace_event.dart';
import 'package:projectunity/ui/space/create_space/bloc/create_workspace_state.dart';

import 'create_space_bloc_test.mocks.dart';

@GenerateMocks([
  SpaceService,
  UserManager,
  EmployeeService,
  StorageService,
  ImagePicker,
])
void main() {
  late SpaceService spaceService;
  late StorageService storageService;
  late ImagePicker imagePicker;
  late UserManager userManager;
  late EmployeeService employeeService;
  late CreateSpaceBLoc bloc;
  late CreateSpaceState createSpaceState;
  setUp(() {
    spaceService = MockSpaceService();
    userManager = MockUserManager();
    employeeService = MockEmployeeService();
    storageService = MockStorageService();
    imagePicker = MockImagePicker();
    when(userManager.userFirebaseAuthName).thenReturn('user name');
    bloc = CreateSpaceBLoc(spaceService, userManager, employeeService,
        imagePicker, storageService);
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
    test('test image picked successfully', () {
      XFile xFile = XFile('path');
      bloc.add(PickImageEvent(imageSource: ImageSource.gallery));
      when(imagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((realInvocation) async => xFile);
      when(imagePicker.pickImage(source: ImageSource.camera))
          .thenAnswer((realInvocation) async => xFile);
      expect(
          bloc.stream,
          emits(CreateSpaceState(
              logo: xFile.path,
              isLogoPickedDone: true,
              ownerName: 'user name')));
    });

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

  group('Create space button tap test', () {
    test('create space not valid data error test', () {
      when(userManager.currentSpaceId).thenReturn('space-id');
      when(userManager.userUID).thenReturn('uid');
      when(userManager.userEmail).thenReturn('dummy@canopas.com');

      bloc.add(CreateSpaceButtonTapEvent());

      expect(
          bloc.stream,
          emitsInOrder([
            const CreateSpaceState(
                createSpaceStatus: Status.error,
                error: provideRequiredInformation,
                ownerName: 'user name'),
          ]));
    });

    // test('create space success with all details test', () async {
    //
    //   final XFile file = XFile('path');
    //
    //   final state = CreateSpaceState(
    //     ownerName: 'user name',
    //     page: 2,
    //     buttonState: ButtonState.enable,
    //     domain: 'www.canopas.com',
    //     paidTimeOff: '12',
    //     logo: file.path,
    //     companyName: 'canopas',
    //   );
    //
    //   when(userManager.currentSpaceId).thenReturn('space-id');
    //   when(storageService.uploadProfilePic('images/space-id/space-logo', File(file.path))).thenAnswer((realInvocation) async => 'image-url');
    //
    //
    //   bloc.emit(state);
    //
    //   bloc.add(CreateSpaceButtonTapEvent());
    //
    //
    //
    //   final space = Space(
    //       id: 'space-id',
    //       name: 'canopas',
    //       logo: 'image-url',
    //       domain: 'www.canopas.com',
    //       createdAt: DateTime(2000),
    //       paidTimeOff: 12,
    //       ownerIds: ['uid']);
    //
    //   when(spaceService.createSpace(
    //           name: 'canopas',
    //           logo: 'image-url',
    //           domain: 'www.canopas.com',
    //           timeOff: 12,
    //           ownerId: 'uid'))
    //       .thenAnswer((realInvocation) async => space);
    //
    //   await expectLater(
    //       bloc.stream,
    //       emitsInOrder([
    //         state.copyWith(createSpaceStatus: Status.loading),
    //         state.copyWith(createSpaceStatus: Status.success),
    //       ]));
    // });

    test('create space success with only required details test', () {
      bloc.emit(const CreateSpaceState(
        ownerName: 'user name',
        buttonState: ButtonState.enable,
        paidTimeOff: '12',
        companyName: 'canopas',
      ));

      when(userManager.currentSpaceId).thenReturn('space-id');
      when(userManager.userUID).thenReturn('uid');
      when(userManager.userEmail).thenReturn('dummy@canopas.com');

      bloc.add(CreateSpaceButtonTapEvent());

      final space = Space(
          id: 'space-id',
          name: 'canopas',
          createdAt: DateTime(2000),
          paidTimeOff: 12,
          ownerIds: ['uid']);

      when(spaceService.createSpace(
              name: 'canopas', timeOff: 12, ownerId: 'uid'))
          .thenAnswer((realInvocation) async => space);

      expectLater(
          bloc.stream,
          emitsInOrder([
            const CreateSpaceState(
                ownerName: 'user name',
                buttonState: ButtonState.enable,
                paidTimeOff: '12',
                companyName: 'canopas',
                createSpaceStatus: Status.loading),
            const CreateSpaceState(
                ownerName: 'user name',
                buttonState: ButtonState.enable,
                paidTimeOff: '12',
                companyName: 'canopas',
                createSpaceStatus: Status.success),
          ]));
    });
  });
}
