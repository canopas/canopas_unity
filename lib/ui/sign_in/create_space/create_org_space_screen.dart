import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/configs/text_style.dart';
import 'package:projectunity/data/di/service_locator.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/ui/sign_in/create_space/bloc/create_space_event.dart';
import 'package:projectunity/ui/sign_in/create_space/bloc/create_space_state.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import 'package:projectunity/ui/widget/employee_details_textfield.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'bloc/create_space_bloc.dart';

class CreateSpacePage extends StatelessWidget {
  final Employee employee;

  const CreateSpacePage({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CreateSpaceBloc>(),
      child: CreateOrgScreen(employee: employee),
    );
  }
}

class CreateOrgScreen extends StatefulWidget {
  final Employee employee;

  const CreateOrgScreen({Key? key, required this.employee}) : super(key: key);

  @override
  State<CreateOrgScreen> createState() => _CreateOrgScreenState();
}

class _CreateOrgScreenState extends State<CreateOrgScreen> {
  final TextEditingController _orgNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<CreateSpaceBloc, CreateSpaceStates>(
        listener: (context, state) {
          if (state is CreateSpaceFailureState) {
            showSnackBar(context: context, error: state.error);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).create_space_button_text,
                  style: AppFontStyle.titleDark,
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context).create_space_screen_description,
                  style: AppFontStyle.bodyMedium,
                ),
                const SizedBox(height: 20),
                FieldEntry(
                  controller: _orgNameController,
                  hintText: AppLocalizations.of(context).company_name_tag,
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: BlocBuilder<CreateSpaceBloc, CreateSpaceStates>(
                    builder: (context, state) => state is CreateSpaceLoadingState
                        ? const AppCircularProgressIndicator()
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 2,
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.8, 50),
                                padding:
                                    const EdgeInsets.only(left: 20, right: 10)),
                            onPressed: () {
                              context.read<CreateSpaceBloc>().add(
                                  CreateSpaceEvent(
                                      organizationName: _orgNameController.text,
                                      employee: widget.employee));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppLocalizations.of(context)
                                    .create_space_button_text),
                                const Icon(Icons.arrow_forward_rounded),
                              ],
                            )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
