import 'package:equatable/equatable.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import 'org_form_field_update_data_model.dart';

class CreateFormState extends Equatable {
  final List<OrgFormFieldCreateFormState> fields;
  final String formId;
  final Status status;
  final String? error;
  final String title;
  final String description;
  final bool limitToOneResponse;
  final String? formHeaderImage;

  const CreateFormState({
    required this.formId,
    this.error,
    this.status = Status.initial,
    this.fields = const [],
    this.title = '',
    this.description = '',
    this.limitToOneResponse = false,
    this.formHeaderImage,
  });

  CreateFormState copyWith({
    List<OrgFormFieldCreateFormState>? fields,
    Status? status,
    String? error,
    String? title,
    String? description,
    bool? limitToOneResponse,
    String? formHeaderImage,
    bool? setPickedImageNull,
  }) =>
      CreateFormState(
        formId: formId,
        error: error,
        fields: fields ?? this.fields,
        status: status ?? this.status,
        description: description ?? this.description,
        limitToOneResponse: limitToOneResponse ?? this.limitToOneResponse,
        formHeaderImage: formHeaderImage ??
            (setPickedImageNull == true ? null : this.formHeaderImage),
        title: title ?? this.title,
      );

  @override
  List<Object?> get props => [
        formId,
        error,
        status,
        fields,
        title,
        description,
        limitToOneResponse,
        formHeaderImage,
      ];
}
