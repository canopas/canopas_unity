import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/text_style.dart';
import '../bloc/create_form_bloc.dart';
import '../bloc/create_form_event.dart';
import '../bloc/create_form_state.dart';
import 'org_form_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class OrgCreateFormInfoView extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const OrgCreateFormInfoView(
      {super.key,
      required this.titleController,
      required this.descriptionController});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateFormBloc>();
    final locale = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderImageView(),
        FormFieldTitle(title: locale.title_tag),
        OrgFormFieldEntry(
          controller: titleController,
          onChanged: (title) => bloc.add(UpdateFormTitleEvent(title)),
          validator: (val) =>
              (val ?? "").isEmpty ? locale.fill_require_details_error : null,
        ),
        FormFieldTitle(title: locale.description_tag),
        OrgFormFieldEntry(
          controller: descriptionController,
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

class HeaderImageView extends StatelessWidget {
  const HeaderImageView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateFormBloc>();
    return BlocBuilder<CreateFormBloc, CreateFormState>(
        buildWhen: (previous, current) =>
            previous.formHeaderImage != current.formHeaderImage,
        builder: (context, state) {
          return Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.dividerColor),
                  image: state.formHeaderImage != null
                      ? DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: kIsWeb
                              ? NetworkImage(state.formHeaderImage!) as ImageProvider
                              : FileImage(File(state.formHeaderImage!)))
                      : null),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 55,
                  ),
                  if (state.formHeaderImage == null)
                    const Icon(Icons.image_outlined, size: 45),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor.withOpacity(0.60),
                          borderRadius: BorderRadius.circular(50)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              style: IconButton.styleFrom(
                                  fixedSize: const Size.fromHeight(45)),
                              onPressed: () =>
                                  bloc.add(UpdateHeaderImageEvent()),
                              icon: const Icon(Icons.edit)),
                          if (state.formHeaderImage != null)
                            IconButton(
                                style: IconButton.styleFrom(
                                    fixedSize: const Size.fromHeight(45)),
                                onPressed: () =>
                                    bloc.add(RemoveHeaderImageEvent()),
                                icon: const Icon(Icons.delete_outline_rounded))
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}
