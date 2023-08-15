import 'package:projectunity/data/model/org_forms/org_form_field/org_form_field.dart';

abstract class CreateFormEvents {}

class CreateNewFormEvent extends CreateFormEvents {}

class UpdateFormTitleEvent extends CreateFormEvents {
  final String title;

  UpdateFormTitleEvent(this.title);
}

class UpdateFormDescriptionEvent extends CreateFormEvents {
  final String description;

  UpdateFormDescriptionEvent(this.description);
}

class UpdateHeaderImageEvent extends CreateFormEvents {}

class RemoveHeaderImageEvent extends CreateFormEvents {}

class UpdateLimitToOneResponse extends CreateFormEvents {
  final bool value;

  UpdateLimitToOneResponse(this.value);
}

class UpdateFormFieldIsRequiredEvent extends CreateFormEvents {
  final bool isRequired;
  final String fieldId;

  UpdateFormFieldIsRequiredEvent(
      {required this.fieldId, required this.isRequired});
}

class UpdateFormFieldInputTypeEvent extends CreateFormEvents {
  final FormFieldAnswerType type;
  final String fieldId;

  UpdateFormFieldInputTypeEvent({required this.fieldId, required this.type});
}

class AddFieldEvent extends CreateFormEvents {}

class AddFieldImageEvent extends CreateFormEvents {}

class RemoveFieldEvent extends CreateFormEvents {
  final String fieldId;

  RemoveFieldEvent(this.fieldId);
}

class AddOrgFormFieldOption extends CreateFormEvents {
  final String fieldId;

  AddOrgFormFieldOption(this.fieldId);
}

class RemoveOrgFormFieldOption extends CreateFormEvents {
  final String fieldId;
  final int optionIndex;

  RemoveOrgFormFieldOption({required this.fieldId, required this.optionIndex});
}
