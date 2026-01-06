import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/list.dart';
import 'package:projectunity/data/model/org_forms/org_form_field/org_form_field.dart';
import 'package:projectunity/data/model/org_forms/org_form_info/org_form_info.dart';
import 'package:projectunity/data/model/org_forms/org_forms.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/storage_service.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/core/utils/const/image_storage_path_const.dart';
import '../../../../../data/repo/form_repo.dart';
import 'org_form_field_update_data_model.dart';
import 'create_form_event.dart';
import 'create_form_state.dart';

@Injectable()
class CreateFormBloc extends Bloc<CreateFormEvents, CreateFormState> {
  final FormRepo _formRepo;
  final ImagePicker _imagePicker;
  final StorageService _storageService;
  final UserStateNotifier _userStateNotifier;
  int _index = 0;

  CreateFormBloc(
    this._formRepo,
    this._imagePicker,
    this._storageService,
    this._userStateNotifier,
  ) : super(CreateFormState(formId: _formRepo.generateNewFormId())) {
    on<UpdateFormTitleEvent>(_updateFormTitle);
    on<CreateNewFormEvent>(_createForm);
    on<UpdateFormDescriptionEvent>(_updateFormDescription);
    on<UpdateHeaderImageEvent>(_updateHeaderImage);
    on<RemoveHeaderImageEvent>(_removeHeaderImage);
    on<UpdateLimitToOneResponse>(_updateLimitToOneResponse);
    on<UpdateFormFieldIsRequiredEvent>(_updateFormFieldIsRequired);
    on<UpdateFormFieldInputTypeEvent>(_updateFormFieldInputType);
    on<AddOrgFormFieldOption>(_addOrgFormFieldOption);
    on<RemoveOrgFormFieldOption>(_removeOrgFormFieldOption);
    on<RemoveFieldEvent>(_removeField);
    on<AddFieldEvent>(_addField);
    on<AddFieldImageEvent>(_addFieldImage);
    add(AddFieldEvent());
  }

  void _updateFormTitle(
    UpdateFormTitleEvent event,
    Emitter<CreateFormState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _updateFormDescription(
    UpdateFormDescriptionEvent event,
    Emitter<CreateFormState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _updateHeaderImage(
    UpdateHeaderImageEvent event,
    Emitter<CreateFormState> emit,
  ) async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      emit(state.copyWith(formHeaderImage: image.path));
    }
  }

  Future<void> _removeHeaderImage(
    RemoveHeaderImageEvent event,
    Emitter<CreateFormState> emit,
  ) async {
    emit(state.copyWith(formHeaderImage: null, setPickedImageNull: true));
  }

  void _updateLimitToOneResponse(
    UpdateLimitToOneResponse event,
    Emitter<CreateFormState> emit,
  ) {
    emit(state.copyWith(limitToOneResponse: event.value));
  }

  List<OrgFormFieldCreateFormState> _updateFormFieldItem({
    required List<OrgFormFieldCreateFormState> orgFormFields,
    required String fieldId,
    required OrgFormFieldCreateFormState? Function(
      OrgFormFieldCreateFormState? field,
    )
    updater,
  }) {
    final fields = orgFormFields.toList();
    final field = fields.firstWhereOrNull((element) => element.id == fieldId);
    fields.removeWhereAndAdd(
      updater(field),
      (fieldItem) => fieldItem.id == fieldId,
    );
    fields.sort((a, b) => a.index.compareTo(b.index));
    return fields;
  }

  void _updateFormFieldIsRequired(
    UpdateFormFieldIsRequiredEvent event,
    Emitter<CreateFormState> emit,
  ) {
    final fields = _updateFormFieldItem(
      orgFormFields: state.fields,
      fieldId: event.fieldId,
      updater: (field) => field?.copyWith(isRequired: event.isRequired),
    );
    emit(state.copyWith(fields: fields));
  }

  void _updateFormFieldInputType(
    UpdateFormFieldInputTypeEvent event,
    Emitter<CreateFormState> emit,
  ) {
    final fields = _updateFormFieldItem(
      orgFormFields: state.fields,
      fieldId: event.fieldId,
      updater: (field) {
        List<EquatableTextEditingController> options = field?.options ?? [];
        if (event.type != FormFieldAnswerType.checkBox &&
            event.type != FormFieldAnswerType.dropDown) {
          for (final option in options) {
            option.dispose();
          }
          options = [];
        } else if (field?.inputType != FormFieldAnswerType.checkBox &&
            field?.inputType != FormFieldAnswerType.dropDown &&
            (event.type == FormFieldAnswerType.checkBox ||
                event.type == FormFieldAnswerType.dropDown)) {
          options.add(
            EquatableTextEditingController(text: 'Option ${options.length}'),
          );
        }
        return field?.copyWith(
          inputType: event.type,
          options: options.isEmpty ? null : options,
          allowOptionNull: true,
        );
      },
    );
    emit(state.copyWith(fields: fields));
  }

  void _addOrgFormFieldOption(
    AddOrgFormFieldOption event,
    Emitter<CreateFormState> emit,
  ) {
    final fields = _updateFormFieldItem(
      orgFormFields: state.fields,
      fieldId: event.fieldId,
      updater: (field) {
        List<EquatableTextEditingController> options =
            field?.options?.toList() ?? [];
        options.add(
          EquatableTextEditingController(text: 'Option ${options.length}'),
        );
        return field?.copyWith(options: options);
      },
    );
    emit(state.copyWith(fields: fields));
  }

  void _removeOrgFormFieldOption(
    RemoveOrgFormFieldOption event,
    Emitter<CreateFormState> emit,
  ) {
    final fields = _updateFormFieldItem(
      orgFormFields: state.fields,
      fieldId: event.fieldId,
      updater: (field) {
        List<EquatableTextEditingController>? options = field?.options
            ?.toList();
        if (options != null) {
          options[event.optionIndex].dispose();
          options.removeAt(event.optionIndex);
          if (options.isEmpty) {
            options = null;
          }
        }
        return field?.copyWith(options: options, allowOptionNull: true);
      },
    );
    emit(state.copyWith(fields: fields));
  }

  void _addField(AddFieldEvent event, Emitter<CreateFormState> emit) {
    final OrgFormFieldCreateFormState orgFormField =
        OrgFormFieldCreateFormState(
          index: _index++,
          id: _formRepo.generateNewFormFieldId(formId: state.formId),
          question: EquatableTextEditingController(),
        );
    final fields = state.fields.toList();
    fields.sort((a, b) => a.index.compareTo(b.index));
    fields.add(orgFormField);
    emit(state.copyWith(fields: fields));
  }

  Future<void> _addFieldImage(
    AddFieldImageEvent event,
    Emitter<CreateFormState> emit,
  ) async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      final OrgFormFieldCreateFormState orgFormField =
          OrgFormFieldCreateFormState(
            question: EquatableTextEditingController(),
            inputType: FormFieldAnswerType.none,
            type: FormFieldType.image,
            index: _index++,
            id: _formRepo.generateNewFormFieldId(formId: state.formId),
            image: image.path,
          );
      final fields = state.fields.toList();
      fields.sort((a, b) => a.index.compareTo(b.index));
      fields.add(orgFormField);
      emit(state.copyWith(fields: fields));
    }
  }

  void _removeField(RemoveFieldEvent event, Emitter<CreateFormState> emit) {
    final fields = state.fields.toList();
    fields.removeWhere((element) => element.id == event.fieldId);
    fields.sort((a, b) => a.index.compareTo(b.index));
    emit(state.copyWith(fields: fields));
  }

  Future<void> _createForm(
    CreateNewFormEvent event,
    Emitter<CreateFormState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      String? headerImageUrl;

      if (state.formHeaderImage != null) {
        final String storagePath = ImageStoragePath.formHeaderImage(
          spaceId: _userStateNotifier.currentSpaceId!,
          formId: state.formId,
        );
        headerImageUrl = await _storageService.uploadProfilePic(
          path: storagePath,
          imagePath: state.formHeaderImage!,
        );
      }

      List<OrgFormField> fields = await Future.wait(
        state.fields.map((stateFormField) async {
          String imageUrl = '';

          if (stateFormField.type == FormFieldType.image) {
            final String storagePath = ImageStoragePath.formFieldImage(
              spaceId: _userStateNotifier.currentSpaceId!,
              formId: state.formId,
              fieldId: stateFormField.id,
            );
            imageUrl = await _storageService.uploadProfilePic(
              path: storagePath,
              imagePath: stateFormField.image,
            );
          }

          return OrgFormField(
            id: stateFormField.id,
            index: stateFormField.index,
            type: stateFormField.type,
            answerType: stateFormField.inputType,
            isRequired: stateFormField.isRequired,
            question: stateFormField.type == FormFieldType.image
                ? imageUrl
                : stateFormField.question.text,
            options: stateFormField.options?.map((e) => e.text).toList(),
          );
        }).toList(),
      );

      await _formRepo.createForm(
        orgForm: OrgForm(
          formInfo: OrgFormInfo(
            id: state.formId,
            title: state.title,
            createdAt: DateTime.now(),
            description: state.description.isEmpty ? null : state.description,
            oneTimeResponse: state.limitToOneResponse,
            headerImage: headerImageUrl,
          ),
          fields: fields,
        ),
      );
      emit(state.copyWith(status: Status.success));
    } on Exception {
      emit(
        state.copyWith(status: Status.error, error: firestoreFetchDataError),
      );
    }
  }

  @override
  Future<void> close() {
    for (final field in state.fields) {
      field.question.dispose();
      for (final option in field.options ?? []) {
        option.dispose();
      }
    }
    return super.close();
  }
}
