import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/widget/error_snack_bar.dart';

import '../../../configs/colors.dart';
import '../../../configs/space_constant.dart';
import '../../../configs/text_style.dart';
import '../../../configs/theme.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../di/service_locator.dart';
import '../../../model/leave_application.dart';
import '../../../widget/circular_progress_indicator.dart';
import 'bloc/who_is_out_card_bloc.dart';
import 'bloc/who_is_out_card_event.dart';
import 'bloc/who_is_out_card_state.dart';

class WhoIsOutCard extends StatelessWidget {
  final void Function()? onSeeAllButtonTap;
  const WhoIsOutCard({Key? key, this.onSeeAllButtonTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<WhoIsOutCardBloc>()..add(WhoIsOutInitialLoadEvent()),
      child: BlocListener<WhoIsOutCardBloc, WhoIsOutCardState>(
        listenWhen: (previous, current) =>
            current.status == WhoOIsOutCardStatus.failure,
        listener: (context, state) {
          if (state.status == WhoOIsOutCardStatus.failure) {
            showSnackBar(context: context, error: state.error);
          }
        },
        child: Container(
          padding: const EdgeInsets.only(bottom: primaryVerticalSpacing),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: AppTheme.commonBorderRadius,
            color: AppColors.whiteColor,
            boxShadow: AppTheme.commonBoxShadow,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(primaryHorizontalSpacing),
                child: Text(
                  AppLocalizations.of(context).who_is_out_card_title,
                  style: AppFontStyle.titleDark,
                ),
              ),
              const Divider(),
              _WhoIsOutCardControlButtons(onSeeAllButtonTap: onSeeAllButtonTap),
              const Divider(),
              const SizedBox(
                height: primaryVerticalSpacing,
              ),
              BlocBuilder<WhoIsOutCardBloc, WhoIsOutCardState>(
                builder: (context, state) =>
                    state.status == WhoOIsOutCardStatus.loading
                        ? const Padding(
                            padding: EdgeInsets.all(primaryHorizontalSpacing),
                            child: AppCircularProgressIndicator(),
                          )
                        : _AbsenceEmployeesListWhoIsOutCardView(
                            absence: state.absence,
                            dateOfEmployeeAbsence: state.dateOfAbsenceEmployee,
                          ),
              ),
            ],
          ),
        ),
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

class _AbsenceEmployeesListWhoIsOutCardView extends StatelessWidget {
  final DateTime dateOfEmployeeAbsence;
  final List<LeaveApplication> absence;

  const _AbsenceEmployeesListWhoIsOutCardView(
      {Key? key, required this.dateOfEmployeeAbsence, required this.absence})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
              crossAxisAlignment: absence.isEmpty
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.all(
                          absence.isEmpty ? 0 : primaryVerticalSpacing)
                      .copyWith(bottom: 0),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: absence
                        .map((e) => Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: primaryVerticalSpacing),
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                image: (e.employee.imageUrl != null)
                                    ? DecorationImage(
                                        image:
                                            NetworkImage(e.employee.imageUrl!),
                                        fit: BoxFit.cover)
                                    : null,
                                color: AppColors.primaryGray,
                                borderRadius: AppTheme.commonBorderRadius,
                              ),
                              child: (e.employee.imageUrl != null)
                                  ? null
                                  : const Icon(Icons.person,
                                      size: 30, color: Colors.black54),
                            ))
                        .toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: primaryHorizontalSpacing,
                      vertical: primaryVerticalSpacing),
                  child: Text(
                    AppLocalizations.of(context).who_is_out_card_message(
                        DateFormatter(AppLocalizations.of(context))
                            .getDateRepresentation(dateOfEmployeeAbsence),
                        absence.length,
                        absence.length - 1,
                        (absence.isEmpty) ? "" : absence.first.employee.name),
                    style: AppFontStyle.bodyMedium,
                  ),
                ),
              ]),
        ),
      ],
    );
  }
}
