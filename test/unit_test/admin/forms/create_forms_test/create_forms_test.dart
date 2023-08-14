import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/repo/form_repo.dart';
import 'package:projectunity/data/services/storage_service.dart';
import 'package:projectunity/ui/admin/forms/create_form/bloc/create_form_bloc.dart';
import 'package:projectunity/ui/admin/forms/create_form/bloc/create_form_state.dart';

import 'create_forms_test.mocks.dart';

@GenerateMocks(
    [FormRepo, ImagePicker, StorageService, UserStateNotifier, CreateFormBloc])
void main() {
  late FormRepo formRepo;
  late ImagePicker imagePicker;
  late StorageService storageService;
  late UserStateNotifier userStateNotifier;
  late CreateFormBloc bloc;

  const formId = 'form-id';

  group('Create form test', () {
    setUp(() {
      formRepo = MockFormRepo();
      imagePicker = MockImagePicker();
      storageService = MockStorageService();
      userStateNotifier = MockUserStateNotifier();
      when(formRepo.generateNewFormId()).thenReturn(formId);
      when(formRepo.generateNewFormFieldId(formId: formId))
          .thenReturn('field 1 id');
      bloc = CreateFormBloc(
          formRepo, imagePicker, storageService, userStateNotifier);
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
              fields: bloc.state.fields,
              limitToOneResponse: false,
              formHeaderImage: null));
      expect(bloc.state.fields.length, 1);
    });
  });
}
