import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/configs/colors.dart';
import '../../../../data/configs/theme.dart';
import '../../../../data/model/org_forms/org_form_field/org_form_field.dart';
import '../bloc/create_form_bloc.dart';
import '../bloc/create_form_event.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class FormFieldImageView extends StatelessWidget {
  final OrgFormField orgFormField;

  const FormFieldImageView({super.key, required this.orgFormField});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateFormBloc>();
    return Container(
      padding: const EdgeInsets.all(16).copyWith(bottom: 0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.dividerColor),
        borderRadius: AppTheme.commonBorderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.dividerColor),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(File(orgFormField.question)))),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () => bloc.add(RemoveFieldEvent(orgFormField.id)),
                  child: Text(AppLocalizations.of(context).remove_tag)),
            ],
          ),
        ],
      ),
    );
  }
}
