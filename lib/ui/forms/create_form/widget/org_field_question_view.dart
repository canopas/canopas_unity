import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/configs/colors.dart';
import '../../../../data/configs/text_style.dart';
import '../../../../data/configs/theme.dart';
import '../../../../data/model/org_forms/org_form_field/org_form_field.dart';
import '../bloc/create_form_bloc.dart';
import '../bloc/create_form_event.dart';
import '../bloc/create_form_state.dart';
import 'org_form_dropdown.dart';
import 'org_form_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class FormFieldView extends StatelessWidget {
  final OrgFormField orgFormField;

  const FormFieldView({super.key, required this.orgFormField});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateFormBloc>();
    final locale = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: AppTheme.commonBorderRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormFieldTitle(title: locale.question_tag),
          const SizedBox(height: 8),
          OrgFormFieldEntry(
            hintText: locale.question_text_field_hint_text,
            onChanged: (question) => bloc.add(UpdateFormFieldQuestionEvent(
                question: question, fieldId: orgFormField.id)),
            validator: (val) =>
                (val ?? "").isEmpty ? locale.fill_require_details_error : null,
          ),
          OrgFormFieldOptionsView(
              fieldId: orgFormField.id, options: orgFormField.options),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(locale.type_tag, style: AppFontStyle.bodyLarge),
              OrgFormDropDownButton<FieldInputType>(
                value: orgFormField.inputType,
                items: FieldInputType.values
                    .map((fieldInputType) => DropdownMenuItem<FieldInputType>(
                        alignment: Alignment.center,
                        value: fieldInputType,
                        child: Text(fieldInputType.name.toUpperCase())))
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
                Text(locale.required_tag, style: AppFontStyle.bodyLarge),
                const SizedBox(width: 16),
                BlocBuilder<CreateFormBloc, CreateFormState>(
                    buildWhen: (previous, current) =>
                        previous.fields != current.fields,
                    builder: (context, state) => Switch(
                        activeColor: AppColors.primaryBlue,
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

class OrgFormFieldOptionsView extends StatefulWidget {
  final String fieldId;
  final List<String>? options;

  const OrgFormFieldOptionsView(
      {super.key, required this.options, required this.fieldId});

  @override
  State<OrgFormFieldOptionsView> createState() =>
      _OrgFormFieldOptionsViewState();
}

class _OrgFormFieldOptionsViewState extends State<OrgFormFieldOptionsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const FormFieldTitle(title: "Options"),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.options?.length ?? 0,
          itemBuilder: (context, index) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: OrgFormFieldEntry(
                value: widget.options?[index],
              )),
              IconButton(
                  onPressed: () => context.read<CreateFormBloc>().add(
                      RemoveOrgFormFieldOption(
                          fieldId: widget.fieldId, optionIndex: index)),
                  icon: const Icon(Icons.delete_outline_rounded))
            ],
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
        ),
        IconButton(
            onPressed: () => context
                .read<CreateFormBloc>()
                .add(AddOrgFormFieldOption(widget.fieldId)),
            icon: const Icon(Icons.add))
      ],
    );
  }
}
