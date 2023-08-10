import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/configs/colors.dart';
import 'package:projectunity/data/di/service_locator.dart';
import 'package:projectunity/data/model/org_forms/org_form_field/org_form_field.dart';
import 'package:projectunity/ui/forms/create_form/bloc/create_form_bloc.dart';
import 'package:projectunity/ui/forms/create_form/bloc/create_form_state.dart';
import 'package:projectunity/ui/forms/create_form/widget/org_create_form_add_field_button.dart';
import 'package:projectunity/ui/forms/create_form/widget/org_create_form_info_view.dart';
import 'package:projectunity/ui/forms/create_form/widget/org_field_image_view.dart';
import 'package:projectunity/ui/forms/create_form/widget/org_field_question_view.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class CreateFromPage extends StatelessWidget {
  const CreateFromPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreateFormBloc>(),
      child: const CreateFormScreen(),
    );
  }
}

class CreateFormScreen extends StatefulWidget {
  const CreateFormScreen({super.key});

  @override
  State<CreateFormScreen> createState() => _CreateFormScreenState();
}

class _CreateFormScreenState extends State<CreateFormScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context).create_form_screen_title),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const OrgCreateFormInfoView(),
            const Divider(color: AppColors.darkGrey, thickness: 0.2),
            BlocBuilder<CreateFormBloc, CreateFormState>(
                builder: (context, state) => ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.fields.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) =>
                          state.fields[index].type == FieldType.text
                              ? FormFieldView(orgFormField: state.fields[index])
                              : FormFieldImageView(
                                  orgFormField: state.fields[index]),
                    )),
            const CreateOrgFormAddFieldButton(),
          ],
        ),
      ),
    );
  }
}
