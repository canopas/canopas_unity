import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/configs/colors.dart';
import '../../../../data/configs/text_style.dart';
import '../bloc/create_form_bloc.dart';
import '../bloc/create_form_event.dart';
import '../bloc/create_form_state.dart';
import 'org_form_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class OrgCreateFormInfoView extends StatelessWidget {
  const OrgCreateFormInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateFormBloc>();
    final locale = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilledButton.tonal(
            onPressed: () => bloc.add(UpdateHeaderImageEvent()),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(
                    color: AppColors.dividerColor,
                  )),
              backgroundColor: AppColors.whiteColor,
            ),
            child: Row(
              children: const [
                Icon(
                  Icons.image_outlined,
                ),
                SizedBox(width: 8),
                Text('Upload Header Image'),
              ],
            )),
        const FormFieldTitle(
          title: 'Title',
        ),
        OrgFormFieldEntry(
          onChanged: (title) => bloc.add(UpdateFormTitleEvent(title)),
          validator: (val) =>
              (val ?? "").isEmpty ? locale.fill_require_details_error : null,
        ),
        FormFieldTitle(title: locale.description_tag),
        OrgFormFieldEntry(
          onChanged: (description) =>
              bloc.add(UpdateFormDescriptionEvent(description)),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(locale.create_from_limit_to_1_response_text,
                style: AppFontStyle.bodyLarge),
            BlocBuilder<CreateFormBloc, CreateFormState>(
                buildWhen: (previous, current) =>
                    previous.limitToOneResponse != current.limitToOneResponse,
                builder: (context, state) => Switch(
                    activeColor: AppColors.primaryBlue,
                    value: state.limitToOneResponse,
                    onChanged: (value) =>
                        bloc.add(UpdateLimitToOneResponse(value))))
          ],
        ),
      ],
    );
  }
}
