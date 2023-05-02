import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
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
  XFile
])
void main() {
  late SpaceService spaceService;
  late StorageService storageService;
  late ImagePicker imagePicker;
  late XFile xFile;
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
    xFile = MockXFile();
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
      bloc.add(PickImageEvent(imageSource: ImageSource.gallery));
      when(xFile.path).thenReturn('image-path');
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

  group('create space test', () {

  });
}
