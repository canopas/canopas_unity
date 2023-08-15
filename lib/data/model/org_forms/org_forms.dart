import 'package:equatable/equatable.dart';
import 'org_form_field/org_form_field.dart';
import 'org_form_info/org_form_info.dart';

class OrgForm extends Equatable {
  final OrgFormInfo formInfo;
  final List<OrgFormField> fields;

  const OrgForm({required this.formInfo, required this.fields});

  @override
  List<Object?> get props => [formInfo, fields];
}
