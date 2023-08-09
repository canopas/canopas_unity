import 'package:equatable/equatable.dart';
import 'package:projectunity/data/model/forms/form_info/form.dart';
import 'form_field/form_field.dart';

class Form extends Equatable {
  final FormInfo formInfo;
  final List<FormField> fields;

  const Form({required this.formInfo, required this.fields});

  @override
  List<Object?> get props => [formInfo, fields];
}
