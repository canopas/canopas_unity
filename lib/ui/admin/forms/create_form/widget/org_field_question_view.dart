import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import '../../../../../data/configs/theme.dart';
import '../../../../../data/l10n/app_localization.dart';
import '../../../../../data/model/org_forms/org_form_field/org_form_field.dart';
import '../bloc/org_form_field_update_data_model.dart';
import '../bloc/create_form_bloc.dart';
import '../bloc/create_form_event.dart';
import '../bloc/create_form_state.dart';
import 'org_form_dropdown.dart';
import 'org_form_text_field.dart';

class FormFieldView extends StatelessWidget {
  final OrgFormFieldCreateFormState orgFormField;

  const FormFieldView({super.key, required this.orgFormField});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateFormBloc>();
    final locale = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: AppTheme.commonBorderRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormFieldTitle(title: locale.question_tag),
          const SizedBox(height: 8),
          OrgFormFieldEntry(
            controller: orgFormField.question,
            hintText: locale.question_text_field_hint_text,
            validator: (val) =>
                (val ?? "").isEmpty ? locale.fill_require_details_error : null,
          ),
          OrgFormFieldOptionsView(
              fieldId: orgFormField.id,
              options: orgFormField.options,
              inputType: orgFormField.inputType),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(locale.type_tag,
                  style: AppTextStyle.style16
                      .copyWith(color: context.colorScheme.textPrimary)),
              OrgFormDropDownButton<FormFieldAnswerType>(
                value: orgFormField.inputType,
                items: FormFieldAnswerType.values
                    .map((fieldInputType) =>
                        DropdownMenuItem<FormFieldAnswerType>(
                            alignment: Alignment.center,
                            value: fieldInputType,
                            child: Text(locale.org_form_answer_type(
                                fieldInputType.value.toString()))))
                    .toList(),
                onChanged: (type) {
                  if (type != null) {
                    bloc.add(UpdateFormFieldInputTypeEvent(
                        fieldId: orgFormField.id, type: type));
                  }
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(locale.required_tag,
                    style: AppTextStyle.style16
                        .copyWith(color: context.colorScheme.textPrimary)),
                const SizedBox(width: 16),
                BlocBuilder<CreateFormBloc, CreateFormState>(
                    buildWhen: (previous, current) =>
                        previous.fields != current.fields,
                    builder: (context, state) => Switch(
                        activeColor: context.colorScheme.primary,
                        value: state.fields[state.fields.indexOf(orgFormField)]
                            .isRequired,
                        onChanged: (isRequired) => bloc.add(
                            UpdateFormFieldIsRequiredEvent(
                                isRequired: isRequired,
                                fieldId: orgFormField.id)))),
                const Spacer(),
                TextButton(
                    onPressed: () =>
                        bloc.add(RemoveFieldEvent(orgFormField.id)),
                    child: Text(locale.remove_tag)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrgFormFieldOptionsView extends StatelessWidget {
  final String fieldId;
  final List<TextEditingController>? options;
  final FormFieldAnswerType inputType;

  const OrgFormFieldOptionsView(
      {super.key,
      required this.options,
      required this.fieldId,
      required this.inputType});

  @override
  Widget build(BuildContext context) {
    return inputType != FormFieldAnswerType.dropDown &&
            inputType != FormFieldAnswerType.checkBox
        ? const SizedBox(height: 16)
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const FormFieldTitle(title: "Options"),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: options?.length ?? 0,
                itemBuilder: (context, index) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: OrgFormFieldEntry(
                      validator: (val) => (val ?? "").isEmpty
                          ? AppLocalizations.of(context)
                              .fill_require_details_error
                          : null,
                      controller: options?[index],
                    )),
                    IconButton(
                        onPressed: () => context.read<CreateFormBloc>().add(
                            RemoveOrgFormFieldOption(
                                fieldId: fieldId, optionIndex: index)),
                        icon: const Icon(Icons.delete_outline_rounded))
                  ],
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
              ),
              IconButton(
                  onPressed: () => context
                      .read<CreateFormBloc>()
                      .add(AddOrgFormFieldOption(fieldId)),
                  icon: const Icon(Icons.add))
            ],
          );
  }
}
