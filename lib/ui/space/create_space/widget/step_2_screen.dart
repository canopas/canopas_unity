import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';

import '../../../../data/configs/colors.dart';
import '../../../navigation/app_router.dart';
import '../../../widget/employee_details_textfield.dart';
import '../bloc/create_workspace_bloc.dart';
import '../bloc/create_workspace_event.dart';
import '../bloc/create_workspace_state.dart';

class WorkspacePaidLeaves extends StatelessWidget {
  final void Function()? onNextButtonPressed;

  const WorkspacePaidLeaves({Key? key, this.onNextButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CreateSpaceBLoc>(context);
    final locale = AppLocalizations.of(context);
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: BlocListener<CreateSpaceBLoc, CreateSpaceState>(
            listenWhen: (previous, current) =>
                current.createSpaceStatus == CreateSpaceStatus.error ||
                current.createSpaceStatus == CreateSpaceStatus.success,
            listener: (context, state) {
              if (state.createSpaceStatus == CreateSpaceStatus.error) {
                showSnackBar(context: context, error: state.error);
              }
              if (state.createSpaceStatus == CreateSpaceStatus.success) {
                context.goNamed(Routes.adminHome);
              }
            },
            child: Column(
              children: [
                BlocBuilder<CreateSpaceBLoc, CreateSpaceState>(
                    builder: (context, state) {
                  return FieldEntry(
                    hintText:
                        AppLocalizations.of(context).yearly_paid_time_off_tag,
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (String? value) {
                      bloc.add(PaidTimeOffChangeEvent(paidTimeOff: value));
                    },
                    errorText: state.paidTimeOffError
                        ? locale.create_space_invalid_time_off_error
                        : null,
                  );
                }),
                const SizedBox(height: 20),
                BlocBuilder<CreateSpaceBLoc, CreateSpaceState>(
                    builder: (context, state) {
                  if (state.createSpaceStatus == CreateSpaceStatus.loading) {
                    return const AppCircularProgressIndicator();
                  }
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: state.createSpaceButtonStatus ==
                                  ButtonStatus.disable
                              ? AppColors.greyColor
                              : AppColors.primaryBlue,
                          fixedSize:
                              Size(MediaQuery.of(context).size.width, 45)),
                      onPressed: () {
                        bloc.add(CreateSpaceButtonTapEvent());
                      },
                      child: Text(AppLocalizations.of(context)
                          .create_space_create_space_button_text));
                }),
              ],
            )));
  }
}
