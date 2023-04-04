import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../../../data/configs/colors.dart';
import '../../../widget/employee_details_textfield.dart';
import '../bloc/create_workspace_bloc.dart';
import '../bloc/create_workspace_event.dart';
import '../bloc/create_workspace_state.dart';
import 'org_logo_view.dart';

class WorkSpaceBasicDetails extends StatefulWidget {
  final void Function()? onNextButtonPressed;

  const WorkSpaceBasicDetails({
    Key? key,
    this.onNextButtonPressed,
  }) : super(key: key);

  @override
  State<WorkSpaceBasicDetails> createState() => _WorkSpaceBasicDetailsState();
}

class _WorkSpaceBasicDetailsState extends State<WorkSpaceBasicDetails> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CreateSpaceBLoc>(context);
    final locale = AppLocalizations.of(context);
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrgLogoView(imageURl: null, onButtonTap: () {}),
            const SizedBox(height: 32),
            BlocBuilder<CreateSpaceBLoc, CreateSpaceState>(
                builder: (context, state) {
              return FieldEntry(
                hintText: AppLocalizations.of(context).company_name_tag,
                errorText: state.nameError
                    ? locale.create_space_invalid_name_error
                    : null,
                onChanged: (String? value) {
                  bloc.add(CompanyNameChangeEvent(name: ''));
                },
              );
            }),
            const SizedBox(height: 20),
            BlocBuilder<CreateSpaceBLoc, CreateSpaceState>(
                builder: (context, state) {
              return FieldEntry(
                hintText: AppLocalizations.of(context)
                    .create_workspace_Website_url_label,
                errorText: state.domainError
                    ? locale.create_space_invalid_website_url_error
                    : null,
                onChanged: (String? value) {
                  bloc.add(CompanyDomainChangeEvent(domain: value));
                },
              );
            }),
            const SizedBox(height: 20),
            BlocBuilder<CreateSpaceBLoc, CreateSpaceState>(
              builder: (context, state) {
                return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            state.nextButtonStatus == ButtonStatus.disable
                                ? AppColors.greyColor
                                : AppColors.primaryBlue,
                        fixedSize: Size(MediaQuery.of(context).size.width, 45)),
                    onPressed: widget.onNextButtonPressed,
                    child: Text(AppLocalizations.of(context).next_tag));
              },
            ),
          ],
        ));
  }
}
