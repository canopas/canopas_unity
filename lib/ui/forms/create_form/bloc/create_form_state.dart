import 'package:equatable/equatable.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/model/org_forms/org_form_field/org_form_field.dart';

class CreateFormState extends Equatable {
  final List<OrgFormField> fields;
  final Status status;
  final String? error;
  final String title;
  final String description;
  final bool limitToOneResponse;
  final String? formHeaderImage;

  const CreateFormState({
    this.error,
    this.status = Status.initial,
    this.fields = const [],
    this.title = '',
    this.description = '',
    this.limitToOneResponse = false,
    this.formHeaderImage,
  });

  CreateFormState copyWith({
    List<OrgFormField>? fields,
    Status? status,
    String? error,
    String? title,
    String? description,
    bool? limitToOneResponse,
    String? formHeaderImage,
    bool? setPickedImageNull,
  }) =>
      CreateFormState(
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
        error,
        status,
        fields,
        title,
        description,
        limitToOneResponse,
        formHeaderImage,
      ];
}
