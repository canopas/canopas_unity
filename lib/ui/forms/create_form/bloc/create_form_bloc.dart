import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/list.dart';
import 'package:projectunity/data/model/org_forms/org_form_field/org_form_field.dart';
import 'package:projectunity/ui/forms/create_form/bloc/create_form_event.dart';
import 'package:projectunity/ui/forms/create_form/bloc/create_form_state.dart';
import '../../../../data/repo/form_repo.dart';

@Injectable()
class CreateFormBloc extends Bloc<CreateFormEvents, CreateFormState> {
  final FormRepo _formRepo;
  final ImagePicker _imagePicker;
  late final String _formId;
  int index = 0;

  CreateFormBloc(this._formRepo, this._imagePicker)
      : _formId = _formRepo.generateNewFormId(),
        super(const CreateFormState()) {
    on<UpdateFormTitleEvent>(_updateFormTitle);
    on<UpdateFormDescriptionEvent>(_updateFormDescription);
    on<UpdateHeaderImageEvent>(_updateHeaderImage);
    on<RemoveHeaderImageEvent>(_removeHeaderImage);
    on<UpdateLimitToOneResponse>(_updateLimitToOneResponse);
    on<UpdateFormFieldQuestionEvent>(_updateFormFieldQuestion);
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
      UpdateFormTitleEvent event, Emitter<CreateFormState> emit) {
    emit(state.copyWith(title: event.title));
  }

  void _updateFormDescription(
      UpdateFormDescriptionEvent event, Emitter<CreateFormState> emit) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _updateHeaderImage(
      UpdateHeaderImageEvent event, Emitter<CreateFormState> emit) async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(state.copyWith(formHeaderImage: image.path));
    }
  }

  Future<void> _removeHeaderImage(
      RemoveHeaderImageEvent event, Emitter<CreateFormState> emit) async {
    emit(state.copyWith(formHeaderImage: null, setPickedImageNull: true));
  }

  void _updateLimitToOneResponse(
      UpdateLimitToOneResponse event, Emitter<CreateFormState> emit) {
    emit(state.copyWith(limitToOneResponse: event.value));
  }

  List<OrgFormField> _updateFormFieldItem(
      {required List<OrgFormField> orgFormFields,
      required String fieldId,
      required OrgFormField? Function(OrgFormField? field) updater}) {
    final fields = orgFormFields.toList();
    final field = fields.firstWhereOrNull((element) => element.id == fieldId);
    fields.removeWhereAndAdd(
        updater(field), (fieldItem) => fieldItem.id == fieldId);
    fields.sort((a, b) => a.index.compareTo(b.index));
    return fields;
  }

  void _updateFormFieldQuestion(
      UpdateFormFieldQuestionEvent event, Emitter<CreateFormState> emit) {
    final fields = _updateFormFieldItem(
        orgFormFields: state.fields,
        fieldId: event.fieldId,
        updater: (field) => field?.copyWith(question: event.question));
    emit(state.copyWith(fields: fields));
  }

  void _updateFormFieldIsRequired(
      UpdateFormFieldIsRequiredEvent event, Emitter<CreateFormState> emit) {
    final fields = _updateFormFieldItem(
        orgFormFields: state.fields,
        fieldId: event.fieldId,
        updater: (field) => field?.copyWith(isRequired: event.isRequired));
    emit(state.copyWith(fields: fields));
  }

  void _updateFormFieldInputType(
      UpdateFormFieldInputTypeEvent event, Emitter<CreateFormState> emit) {
    final fields = _updateFormFieldItem(
        orgFormFields: state.fields,
        fieldId: event.fieldId,
        updater: (field) => field?.copyWith(inputType: event.type));
    emit(state.copyWith(fields: fields));
  }

  void _addOrgFormFieldOption(
      AddOrgFormFieldOption event, Emitter<CreateFormState> emit) {
    final fields = _updateFormFieldItem(
        orgFormFields: state.fields,
        fieldId: event.fieldId,
        updater: (field) {
          List<String> options = field?.options?.toList() ?? [];
          options.add('Option ${options.length}');
          return field?.copyWith(options: options);
        });
    emit(state.copyWith(fields: fields));
  }

  void _removeOrgFormFieldOption(
      RemoveOrgFormFieldOption event, Emitter<CreateFormState> emit) {
    final fields = _updateFormFieldItem(
        orgFormFields: state.fields,
        fieldId: event.fieldId,
        updater: (field) {
          List<String>? options = field?.options?.toList();
          if (options != null) {
            options.removeAt(event.optionIndex);
          }
          return field?.copyWith(options: options);
        });
    emit(state.copyWith(fields: fields));
  }

  void _addField(AddFieldEvent event, Emitter<CreateFormState> emit) {
    final OrgFormField orgFormField = OrgFormField(
        index: index++,
        id: _formRepo.generateNewFormFieldId(formId: _formId),
        question: '');
    final fields = state.fields.toList();
    fields.sort((a, b) => a.index.compareTo(b.index));
    fields.add(orgFormField);
    emit(state.copyWith(fields: fields));
  }

  Future<void> _addFieldImage(
      AddFieldImageEvent event, Emitter<CreateFormState> emit) async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final OrgFormField orgFormField = OrgFormField(
          inputType: FieldInputType.none,
          type: FieldType.image,
          index: index++,
          id: _formRepo.generateNewFormFieldId(formId: _formId),
          question: image.path);
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
}
