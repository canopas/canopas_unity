import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/ui/shared/who_is_out_card/widget/absence_employee_view.dart';
import '../../../data/configs/colors.dart';
import '../../../data/configs/space_constant.dart';
import '../../../data/configs/text_style.dart';
import '../../../data/configs/theme.dart';
import '../../../data/core/utils/bloc_status.dart';
import '../../../data/core/utils/date_formatter.dart';
import '../../widget/error_snack_bar.dart';
import 'bloc/who_is_out_card_bloc.dart';
import 'bloc/who_is_out_card_event.dart';
import 'bloc/who_is_out_card_state.dart';

class WhoIsOutCard extends StatelessWidget {
  final void Function()? onSeeAllButtonTap;

  const WhoIsOutCard({Key? key, this.onSeeAllButtonTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<WhoIsOutCardBloc, WhoIsOutCardState>(
      listenWhen: (previous, current) => current.status == Status.error,
      listener: (context, state) {
        if (state.status == Status.error) {
          showSnackBar(context: context, error: state.error);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 16),
            child: Text(
              AppLocalizations.of(context).who_is_out_card_title,
              style: AppFontStyle.headerDark,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: AppTheme.commonBorderRadius,
              color: AppColors.whiteColor,
              boxShadow: AppTheme.commonBoxShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _WhoIsOutCardControlButtons(
                    onSeeAllButtonTap: onSeeAllButtonTap),
                const Divider(
                    indent: primaryHorizontalSpacing,
                    endIndent: primaryHorizontalSpacing,
                    height: 0),
                BlocBuilder<WhoIsOutCardBloc, WhoIsOutCardState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status ||
                      previous.dateOfAbsenceEmployee !=
                          current.dateOfAbsenceEmployee,
                  builder: (context, state) =>
                      AbsenceEmployeesListWhoIsOutCardView(
                    status: state.status,
                    absence: state.absence,
                    dateOfEmployeeAbsence: state.dateOfAbsenceEmployee,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WhoIsOutCardControlButtons extends StatelessWidget {
  final void Function()? onSeeAllButtonTap;

  const _WhoIsOutCardControlButtons({Key? key, this.onSeeAllButtonTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: primaryHorizontalSpacing,
          vertical: primaryVerticalSpacing),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                context.read<WhoIsOutCardBloc>().add(ChangeToBeforeDateEvent());
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18)),
          BlocBuilder<WhoIsOutCardBloc, WhoIsOutCardState>(
              buildWhen: (previous, current) =>
                  previous.dateOfAbsenceEmployee !=
                  current.dateOfAbsenceEmployee,
              builder: (context, state) => SizedBox(
                    width: 110,
                    child: Center(
                      child: Text(
                        DateFormatter(AppLocalizations.of(context))
                            .getDateRepresentation(state.dateOfAbsenceEmployee),
                        style: AppFontStyle.bodyMedium,
                      ),
                    ),
                  )),
          IconButton(
              onPressed: () {
                context.read<WhoIsOutCardBloc>().add(ChangeToAfterDateEvent());
              },
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
              )),
          const Spacer(),
          MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              height: 30,
              highlightElevation: 0,
              elevation: 0,
              color: AppColors.lightPrimaryBlue,
              onPressed: onSeeAllButtonTap,
              child: Text(
                AppLocalizations.of(context).who_is_out_card_see_all_button_tag,
                style: Theme.of(context).textTheme.bodyMedium,
              )),
        ],
      ),
    );
  }
}

