import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import '../../../../../data/configs/theme.dart';
import '../bloc/org_form_field_update_data_model.dart';
import '../bloc/create_form_bloc.dart';
import '../bloc/create_form_event.dart';
import 'package:projectunity/data/l10n/app_localization.dart';

class FormFieldImageView extends StatelessWidget {
  final OrgFormFieldCreateFormState orgFormField;

  const FormFieldImageView({super.key, required this.orgFormField});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateFormBloc>();
    return Container(
      padding: const EdgeInsets.all(16).copyWith(bottom: 0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: context.colorScheme.outlineColor),
        borderRadius: AppTheme.commonBorderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: context.colorScheme.outlineColor),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: kIsWeb
                    ? NetworkImage(orgFormField.image) as ImageProvider
                    : FileImage(File(orgFormField.image)),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => bloc.add(RemoveFieldEvent(orgFormField.id)),
                child: Text(AppLocalizations.of(context).remove_tag),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
