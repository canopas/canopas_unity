import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/model/space/space.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/data/services/space_service.dart';
import 'package:projectunity/ui/space/create_space/bloc/create_workspace_bloc.dart';
import 'package:projectunity/ui/space/create_space/bloc/create_workspace_event.dart';
import 'package:projectunity/ui/space/create_space/bloc/create_workspace_state.dart';

import 'create_space_bloc_test.mocks.dart';

@GenerateMocks([SpaceService, UserManager])
void main() {
  late SpaceService spaceService;
  late UserManager userManager;
  late CreateSpaceBLoc createSpaceBLoc;
  setUp(() {
    spaceService = MockSpaceService();
    userManager = MockUserManager();
    createSpaceBLoc = CreateSpaceBLoc(spaceService, userManager);
  });

  group('Test the step 1 form for correct input for company details', () {
    late CreateSpaceState initialState = const CreateSpaceState(
        page: 0,
        domain: '',
        name: '',
        nameError: false,
        domainError: false,
        paidTimeOff: '',
        paidTimeOffError: false,
        createSpaceStatus: CreateSpaceStatus.initial,
        nextButtonStatus: ButtonStatus.disable,
        createSpaceButtonStatus: ButtonStatus.disable,
        error: '');

    test('emits initial state with empty textfield for company name and domain',
        () {
      expect(createSpaceBLoc.state, initialState);
    });
    test('show error when name input does not contains minimum 4 character ',
        () {
      createSpaceBLoc.add(CompanyNameChangeEvent(name: 'can'));
      CreateSpaceState stateWithNameError = const CreateSpaceState(
          page: 0,
          domain: '',
          name: 'can',
          nameError: true,
          domainError: false,
          paidTimeOff: '',
          paidTimeOffError: false,
          createSpaceStatus: CreateSpaceStatus.initial,
          nextButtonStatus: ButtonStatus.disable,
          createSpaceButtonStatus: ButtonStatus.disable,
          error: '');
      expect(createSpaceBLoc.stream, emitsInOrder([stateWithNameError]));
    });
    test(
        'error gone when name input contains 4 character and next button would be enable',
        () {
      createSpaceBLoc.add(CompanyNameChangeEvent(name: 'cano'));
      CreateSpaceState stateWithName = const CreateSpaceState(
          page: 0,
          domain: '',
          name: 'cano',
          nameError: false,
          domainError: false,
          paidTimeOff: '',
          paidTimeOffError: false,
          createSpaceStatus: CreateSpaceStatus.initial,
          nextButtonStatus: ButtonStatus.enable,
          createSpaceButtonStatus: ButtonStatus.disable,
          error: '');
      expect(createSpaceBLoc.stream, emitsInOrder([stateWithName]));
    });
    test(
        'show error when domain input does not contains minimum 4 character   ',
        () {
      createSpaceBLoc.add(CompanyDomainChangeEvent(domain: 'can'));
      CreateSpaceState stateWithDomainError = const CreateSpaceState(
          page: 0,
          domain: 'can',
          name: '',
          nameError: false,
          domainError: true,
          paidTimeOff: '',
          paidTimeOffError: false,
          createSpaceStatus: CreateSpaceStatus.initial,
          nextButtonStatus: ButtonStatus.disable,
          createSpaceButtonStatus: ButtonStatus.disable,
          error: '');
      expect(createSpaceBLoc.stream, emitsInOrder([stateWithDomainError]));
    });
    test('Shows error  when domain input does not contains . character ', () {
      createSpaceBLoc.add(CompanyDomainChangeEvent(domain: 'cano'));
      CreateSpaceState stateWithDomainError = const CreateSpaceState(
          page: 0,
          domain: 'cano',
          name: '',
          nameError: false,
          domainError: true,
          paidTimeOff: '',
          paidTimeOffError: false,
          createSpaceStatus: CreateSpaceStatus.initial,
          nextButtonStatus: ButtonStatus.disable,
          createSpaceButtonStatus: ButtonStatus.disable,
          error: '');
      expect(createSpaceBLoc.stream, emitsInOrder([stateWithDomainError]));
    });
    test(' error gone when domain input contains . character ', () {
      createSpaceBLoc.add(CompanyDomainChangeEvent(domain: 'cano.'));
      CreateSpaceState stateWithDomainError = const CreateSpaceState(
          page: 0,
          domain: 'cano.',
          name: '',
          nameError: false,
          domainError: false,
          paidTimeOff: '',
          paidTimeOffError: false,
          createSpaceStatus: CreateSpaceStatus.initial,
          nextButtonStatus: ButtonStatus.disable,
          createSpaceButtonStatus: ButtonStatus.disable,
          error: '');
      expect(createSpaceBLoc.stream, emitsInOrder([stateWithDomainError]));
    });
    test('Navigate to second step on tap of Next  button', () {
      createSpaceBLoc.add(PageChangeEvent(page: 1));
      CreateSpaceState state = const CreateSpaceState(
          page: 1,
          name: '',
          domain: '',
          nameError: false,
          domainError: false,
          paidTimeOff: '',
          paidTimeOffError: false,
          nextButtonStatus: ButtonStatus.disable,
          createSpaceButtonStatus: ButtonStatus.disable,
          createSpaceStatus: CreateSpaceStatus.initial,
          error: '');
      expect(createSpaceBLoc.stream, emitsInOrder([state]));
    });
  });
  group('Test the step 2 form for correct input for company details', () {
    test(
        'Shows error when Paid time off input field is empty end button status is disable',
        () {
      createSpaceBLoc.add(PaidTimeOffChangeEvent(paidTimeOff: ''));
      CreateSpaceState stateWithPaidTimeOffError = const CreateSpaceState(
          page: 0,
          nameError: false,
          name: '',
          domain: '',
          domainError: false,
          paidTimeOff: '',
          paidTimeOffError: true,
          nextButtonStatus: ButtonStatus.disable,
          createSpaceStatus: CreateSpaceStatus.initial,
          createSpaceButtonStatus: ButtonStatus.disable);
      expect(createSpaceBLoc.stream, emitsInOrder([stateWithPaidTimeOffError]));
    });
    test(
        'emits state with create space button enable when pai time off input is correct',
        () {
      createSpaceBLoc.add(PaidTimeOffChangeEvent(paidTimeOff: '12'));
      CreateSpaceState stateWithPaidTimeOffError = const CreateSpaceState(
          page: 0,
          nameError: false,
          name: '',
          domain: '',
          domainError: false,
          paidTimeOff: '12',
          paidTimeOffError: false,
          nextButtonStatus: ButtonStatus.disable,
          createSpaceStatus: CreateSpaceStatus.initial,
          createSpaceButtonStatus: ButtonStatus.enable);
      expect(createSpaceBLoc.stream, emitsInOrder([stateWithPaidTimeOffError]));
    });
  });
  group('Test the create space button tap event', () {
    CreateSpaceState initialState = const CreateSpaceState(
        page: 0,
        nameError: false,
        name: '',
        domain: '',
        domainError: false,
        paidTimeOff: '',
        paidTimeOffError: false,
        nextButtonStatus: ButtonStatus.disable,
        createSpaceStatus: CreateSpaceStatus.initial,
        createSpaceButtonStatus: ButtonStatus.disable);
    test('Shows error when one of the required field is invalid', () {
      createSpaceBLoc.add(CompanyNameChangeEvent(name: 'canopas'));
      createSpaceBLoc.add(CompanyDomainChangeEvent(domain: 'canopas'));
      createSpaceBLoc.add(PageChangeEvent(page: 1));
      createSpaceBLoc.add(PaidTimeOffChangeEvent(paidTimeOff: '12'));
      createSpaceBLoc.add(CreateSpaceButtonTapEvent());

      final stateWithNameInput = initialState.copyWith(
          name: 'canopas', nextButtonStatus: ButtonStatus.enable);
      final stateWithDomainInput =
          stateWithNameInput.copyWith(domainError: true, domain: 'canopas');
      final stateWithStep2 = stateWithDomainInput.copyWith(page: 1);
      final stateWithPaidTimeOff = stateWithStep2.copyWith(
          paidTimeOff: '12', createSpaceButtonStatus: ButtonStatus.enable);

      CreateSpaceState errorState =
          stateWithPaidTimeOff.copyWith(error: provideRequiredInformation);

      createSpaceBLoc.add(CreateSpaceButtonTapEvent());
      expect(
          createSpaceBLoc.stream,
          emitsInOrder([
            stateWithNameInput,
            stateWithDomainInput,
            stateWithStep2,
            stateWithPaidTimeOff,
            errorState
          ]));
    });
    test('Emits loading state and then success state if all inputs are valid',
        () {
      createSpaceBLoc.add(CompanyNameChangeEvent(name: 'canopas'));
      createSpaceBLoc.add(CompanyDomainChangeEvent(domain: 'canopas.com'));
      createSpaceBLoc.add(PageChangeEvent(page: 1));
      createSpaceBLoc.add(PaidTimeOffChangeEvent(paidTimeOff: '12'));
      createSpaceBLoc.add(CreateSpaceButtonTapEvent());

      final stateWithNameInput = initialState.copyWith(name: 'canopas', nextButtonStatus: ButtonStatus.enable);
      final stateWithDomainInput = stateWithNameInput.copyWith(domain: 'canopas.com');
      final stateWithStep2 = stateWithDomainInput.copyWith(page: 1);
      final stateWithPaidTimeOff = stateWithStep2.copyWith(paidTimeOff: '12', createSpaceButtonStatus: ButtonStatus.enable);
      final loadingState = stateWithPaidTimeOff.copyWith(
          createSpaceStatus: CreateSpaceStatus.loading);
      final successState = stateWithPaidTimeOff.copyWith(
          createSpaceStatus: CreateSpaceStatus.success);
      when(userManager.userUID).thenReturn('uid');

      when(spaceService.createSpace(
              domain: 'canopas.com',
              timeOff: 12,
              name:  'canopas',
              ownerId: 'uid'))
          .thenAnswer((_) async => Space(id: 'space_id',name: successState.name,domain: "",paidTimeOff: int.parse(successState.paidTimeOff), createdAt: DateTime.now(), ownerIds: ["uid"]));

      expectLater(
          createSpaceBLoc.stream,
          emitsInOrder([
            stateWithNameInput,
            stateWithDomainInput,
            stateWithStep2,
            stateWithPaidTimeOff,
            loadingState,
            successState
          ]));
    });
  });
}
