import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/configs/colors.dart';
import 'package:projectunity/data/di/service_locator.dart';
import 'package:projectunity/data/model/org_forms/org_form_field/org_form_field.dart';
import 'package:projectunity/ui/admin/forms/create_form/bloc/create_form_bloc.dart';
import 'package:projectunity/ui/admin/forms/create_form/bloc/create_form_event.dart';
import 'package:projectunity/ui/admin/forms/create_form/bloc/create_form_state.dart';
import 'package:projectunity/ui/admin/forms/create_form/widget/org_create_form_add_field_button.dart';
import 'package:projectunity/ui/admin/forms/create_form/widget/org_create_form_info_view.dart';
import 'package:projectunity/ui/admin/forms/create_form/widget/org_field_image_view.dart';
import 'package:projectunity/ui/admin/forms/create_form/widget/org_field_question_view.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../widget/circular_progress_indicator.dart';

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
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).create_form_screen_title),
        actions: [
          BlocConsumer<CreateFormBloc, CreateFormState>(
            listenWhen: (previous, current) =>
                current.status == Status.error ||
                current.status == Status.success,
            listener: (context, state) {
              if (state.status == Status.error && state.error != null) {
                showSnackBar(context: context, error: state.error);
              } else if (state.status == Status.success) {
                showSnackBar(
                    context: context,
                    msg: AppLocalizations.of(context)
                        .create_form_success_message);
                context.pop();
              }
            },
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) => state.status == Status.loading
                ? const Padding(
                    padding: EdgeInsets.only(right: 30),
                    child: AppCircularProgressIndicator(size: 20),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            context
                                .read<CreateFormBloc>()
                                .add(CreateNewFormEvent());
                          }
                        },
                        child: Text(AppLocalizations.of(context).create_tag)),
                  ),
          )
        ],
      ),
      body: Form(
          key: _formKey,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return constraints.maxWidth < 800
                  ? ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        OrgCreateFormInfoView(
                            titleController: _titleController,
                            descriptionController: _descriptionController),
                        const Divider(
                            color: AppColors.darkGrey, thickness: 0.2),
                        const QuestionsView(),
                        const CreateOrgFormAddFieldButton(),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 600,
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 8, left: 16, bottom: 16, top: 16),
                              child: OrgCreateFormInfoView(
                                  titleController: _titleController,
                                  descriptionController:
                                      _descriptionController),
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 600,
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context)
                                  .copyWith(scrollbars: false),
                              child: ListView(
                                padding: const EdgeInsets.only(
                                    right: 16, left: 8, bottom: 16),
                                children: const [
                                  QuestionsView(),
                                  CreateOrgFormAddFieldButton(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
            },
          )),
    );
  }
}

class QuestionsView extends StatelessWidget {
  const QuestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateFormBloc, CreateFormState>(
        buildWhen: (previous, current) => previous.fields != current.fields,
        builder: (context, state) => ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.fields.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) =>
                  state.fields[index].type == FormFieldType.text
                      ? FormFieldView(orgFormField: state.fields[index])
                      : FormFieldImageView(orgFormField: state.fields[index]),
            ));
  }
}
