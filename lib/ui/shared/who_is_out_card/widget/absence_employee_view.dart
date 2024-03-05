import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/configs/theme.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/ui/widget/user_profile_image.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/di/service_locator.dart';
import '../../../../data/model/leave_application.dart';
import '../../../../app_router.dart';
import '../../../widget/circular_progress_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class AbsenceEmployeesListWhoIsOutCardView extends StatelessWidget {
  final DateTime dateOfEmployeeAbsence;
  final List<LeaveApplication> absence;
  final Status status;

  const AbsenceEmployeesListWhoIsOutCardView(
      {super.key,
      required this.dateOfEmployeeAbsence,
      required this.absence,
      required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == Status.loading || status == Status.initial) {
      return Padding(
        padding: const EdgeInsets.all(43),
        child: ThreeBounceLoading(size: 15, color: context.colorScheme.primary),
      );
    } else if (status == Status.success) {
      return absence.isEmpty
          ? WhoIsOutAbsenceEmptyView(
              dateOfEmployeeAbsence: dateOfEmployeeAbsence)
          : AbsenceEmployeeWrapLayout(absence: absence);
    }
    return Container();
  }
}

class AbsenceEmployeeWrapLayout extends StatelessWidget {
  final List<LeaveApplication> absence;

  const AbsenceEmployeeWrapLayout({super.key, required this.absence});

  @override
  Widget build(BuildContext context) {
    final userStateNotifier = getIt<UserStateNotifier>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: absence
            .map((absence) => SizedBox(
                  height: 100,
                  width: 100,
                  child: Material(
                    color: context.colorScheme.surface,
                    borderRadius: AppTheme.commonBorderRadius,
                    child: InkWell(
                      borderRadius: AppTheme.commonBorderRadius,
                      onTap: () {
                        userStateNotifier.isAdmin || userStateNotifier.isHR
                            ? context.pushNamed(Routes.adminAbsenceDetails,
                                extra: absence)
                            : context.pushNamed(Routes.userAbsenceDetails,
                                pathParameters: {
                                    RoutesParamsConst.leaveId:
                                        absence.leave.leaveId
                                  });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ImageProfile(
                                radius: 25,
                                imageUrl: absence.employee.imageUrl),
                            const SizedBox(height: 5),
                            Flexible(
                              child: Text(absence.employee.name,
                                  style: AppTextStyle.style14.copyWith(
                                      color: context.colorScheme.textPrimary),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class WhoIsOutAbsenceEmptyView extends StatelessWidget {
  final DateTime dateOfEmployeeAbsence;

  const WhoIsOutAbsenceEmptyView(
      {super.key, required this.dateOfEmployeeAbsence});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(locale.who_is_out_card_no_leave_present_title,
              style: AppTextStyle.style20.copyWith(
                  fontWeight: FontWeight.w700,
                  color: context.colorScheme.textPrimary)),
          const SizedBox(height: 5),
          Text(
            locale.who_is_out_card_no_leave_present_message,
            style: AppTextStyle.style16
                .copyWith(color: context.colorScheme.textPrimary),
          ),
        ],
      ),
    );
  }
}
