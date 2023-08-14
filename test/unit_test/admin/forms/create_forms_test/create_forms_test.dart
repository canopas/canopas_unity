import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/org_forms/org_form_field/org_form_field.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/repo/form_repo.dart';
import 'package:projectunity/data/services/storage_service.dart';
import 'package:projectunity/ui/admin/forms/create_form/bloc/create_form_bloc.dart';
import 'package:projectunity/ui/admin/forms/create_form/bloc/create_form_event.dart';
import 'package:projectunity/ui/admin/forms/create_form/bloc/create_form_state.dart';
import 'package:projectunity/ui/admin/forms/create_form/bloc/org_form_field_update_data_model.dart';

import 'create_forms_test.mocks.dart';

@GenerateMocks(
    [FormRepo, ImagePicker, StorageService, UserStateNotifier, CreateFormBloc])
void main() {
  late FormRepo formRepo;
  late ImagePicker imagePicker;
  late StorageService storageService;
  late UserStateNotifier userStateNotifier;
  late CreateFormBloc bloc;
  late EquatableTextEditingController fistQuestionController;

  const formId = 'form-id';

  group('Create form test', () {
    group("State change test", () {
      setUp(() {
        formRepo = MockFormRepo();
        imagePicker = MockImagePicker();
        storageService = MockStorageService();
        userStateNotifier = MockUserStateNotifier();
        when(formRepo.generateNewFormId()).thenReturn(formId);
        when(formRepo.generateNewFormFieldId(formId: formId))
            .thenReturn('field-1-id');
        bloc = CreateFormBloc(
            formRepo, imagePicker, storageService, userStateNotifier);
        fistQuestionController = EquatableTextEditingController();
      });

      tearDown(() async {
        fistQuestionController.dispose();
        await bloc.close();
      });

      test('Create form initial state test', () {
        expect(
            bloc.state,
            CreateFormState(
                formId: formId,
                error: null,
                description: '',
                title: '',
                status: Status.initial,
                fields: [
                  OrgFormFieldCreateFormState(
                      id: 'field-1-id',
                      index: 0,
                      question: fistQuestionController)
                ],
                limitToOneResponse: false,
                formHeaderImage: null));
      });

      test('Update form title state test', () {
        bloc.add(UpdateFormTitleEvent('Dummy Title'));

        expect(
            bloc.stream,
            emits(
                CreateFormState(formId: formId, title: 'Dummy Title', fields: [
              OrgFormFieldCreateFormState(
                  id: 'field-1-id', index: 0, question: fistQuestionController)
            ])));
      });

      test('Update form description state test', () {
        bloc.add(UpdateFormDescriptionEvent('Dummy description'));

        expect(
            bloc.stream,
            emits(CreateFormState(
              formId: formId,
              description: "Dummy description",
              fields: [
                OrgFormFieldCreateFormState(
                    id: 'field-1-id',
                    index: 0,
                    question: fistQuestionController)
              ],
            )));
      });

      test('Update form header image state test', () {
        bloc.add(UpdateHeaderImageEvent());
        when(imagePicker.pickImage(source: ImageSource.gallery))
            .thenAnswer((realInvocation) async => XFile('image-path'));

        expect(
            bloc.stream,
            emits(CreateFormState(
              formId: formId,
              formHeaderImage: 'image-path',
              fields: [
                OrgFormFieldCreateFormState(
                    id: 'field-1-id',
                    index: 0,
                    question: fistQuestionController)
              ],
            )));
      });

      test('Update form limit to one response state test', () {
        bloc.add(UpdateLimitToOneResponse(true));

        expect(
            bloc.stream,
            emits(CreateFormState(
              formId: formId,
              limitToOneResponse: true,
              fields: [
                OrgFormFieldCreateFormState(
                    id: 'field-1-id',
                    index: 0,
                    question: fistQuestionController)
              ],
            )));
      });

      test('Update form description state test', () {
        bloc.add(UpdateLimitToOneResponse(true));

        expect(
            bloc.stream,
            emits(CreateFormState(
              formId: formId,
              limitToOneResponse: true,
              fields: [
                OrgFormFieldCreateFormState(
                    id: 'field-1-id',
                    index: 0,
                    question: fistQuestionController)
              ],
            )));
      });

      test('Update form field isRequire state test', () {
        bloc.add(UpdateFormFieldIsRequiredEvent(
            isRequired: true, fieldId: 'field-1-id'));
        expectLater(
            bloc.stream,
            emits(CreateFormState(
              formId: formId,
              fields: [
                OrgFormFieldCreateFormState(
                    id: 'field-1-id',
                    index: 0,
                    question: fistQuestionController,
                    isRequired: true)
              ],
            )));
      });

      test('Update form field answer type state test', () {
        bloc.add(UpdateFormFieldInputTypeEvent(
            type: FormFieldAnswerType.boolean, fieldId: 'field-1-id'));
        expectLater(
            bloc.stream,
            emits(CreateFormState(
              formId: formId,
              fields: [
                OrgFormFieldCreateFormState(
                    id: 'field-1-id',
                    index: 0,
                    question: fistQuestionController,
                    inputType: FormFieldAnswerType.boolean)
              ],
            )));
      });

      test(
          'Update form field answer type show option if type is multi option state test',
          () {
        bloc.add(UpdateFormFieldInputTypeEvent(
            type: FormFieldAnswerType.checkBox, fieldId: 'field-1-id'));
        final EquatableTextEditingController optionController =
            EquatableTextEditingController(text: 'Option 0');
        expect(
            bloc.stream,
            emits(CreateFormState(
              formId: formId,
              fields: [
                OrgFormFieldCreateFormState(
                    id: 'field-1-id',
                    options: [optionController],
                    index: 0,
                    question: fistQuestionController,
                    inputType: FormFieldAnswerType.checkBox)
              ],
            )));
        optionController.dispose();
      });

      test('Add new field test', () {
        when(formRepo.generateNewFormFieldId(formId: formId))
            .thenReturn('field-2-id');
        bloc.add(AddFieldEvent());
        expect(
            bloc.stream,
            emits(CreateFormState(
              formId: formId,
              fields: [
                OrgFormFieldCreateFormState(
                    id: 'field-1-id',
                    index: 0,
                    question: fistQuestionController),
                OrgFormFieldCreateFormState(
                    id: 'field-2-id',
                    index: 1,
                    question: fistQuestionController)
              ],
            )));
      });

      test('Add new field image test', () {
        when(imagePicker.pickImage(source: ImageSource.gallery))
            .thenAnswer((realInvocation) async => XFile('image-path'));
        when(formRepo.generateNewFormFieldId(formId: formId))
            .thenReturn('field-2-id');
        bloc.add(AddFieldImageEvent());
        expect(
            bloc.stream,
            emits(CreateFormState(
              formId: formId,
              fields: [
                OrgFormFieldCreateFormState(
                    id: 'field-1-id',
                    index: 0,
                    question: fistQuestionController),
                OrgFormFieldCreateFormState(
                    inputType: FormFieldAnswerType.none,
                    type: FormFieldType.image,
                    image: 'image-path',
                    id: 'field-2-id',
                    index: 1,
                    question: fistQuestionController)
              ],
            )));
      });

      test('Remove field test', () {
        bloc.add(RemoveFieldEvent('field-1-id'));
        expect(
            bloc.stream,
            emits(const CreateFormState(
              formId: formId,
              fields: [],
            )));
      });
    });

    group('form field option add/remove test', () {
      setUpAll(() {
        formRepo = MockFormRepo();
        imagePicker = MockImagePicker();
        storageService = MockStorageService();
        userStateNotifier = MockUserStateNotifier();
        when(formRepo.generateNewFormId()).thenReturn(formId);
        when(formRepo.generateNewFormFieldId(formId: formId))
            .thenReturn('field-1-id');
        bloc = CreateFormBloc(
            formRepo, imagePicker, storageService, userStateNotifier);
        fistQuestionController = EquatableTextEditingController();
      });

      tearDownAll(() async {
        fistQuestionController.dispose();
        await bloc.close();
      });

      test('Add form field option test', () {
        bloc.add(AddOrgFormFieldOption('field-1-id'));
        final EquatableTextEditingController optionController =
            EquatableTextEditingController(text: 'Option 0');

        expect(
            bloc.stream,
            emits(CreateFormState(
              formId: formId,
              fields: [
                OrgFormFieldCreateFormState(
                    id: 'field-1-id',
                    options: [optionController],
                    index: 0,
                    question: fistQuestionController)
              ],
            )));
        optionController.dispose();
      });

      test('remove form field option test', () {
        bloc.add(
            RemoveOrgFormFieldOption(fieldId: 'field-1-id', optionIndex: 0));

        expect(
            bloc.stream,
            emits(CreateFormState(
              formId: formId,
              fields: [
                OrgFormFieldCreateFormState(
                    id: 'field-1-id',
                    options: null,
                    index: 0,
                    question: fistQuestionController)
              ],
            )));
      });
    });
  });
}
