import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/configs/theme.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/ui/widget/user_profile_image.dart';
import '../../../../data/configs/colors.dart';
import '../../../../data/configs/text_style.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/di/service_locator.dart';
import '../../../../data/model/leave_application.dart';
import '../../../navigation/app_router.dart';
import '../../../widget/circular_progress_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class AbsenceEmployeesListWhoIsOutCardView extends StatelessWidget {
  final DateTime dateOfEmployeeAbsence;
  final List<LeaveApplication> absence;
  final Status status;

  const AbsenceEmployeesListWhoIsOutCardView(
      {Key? key,
      required this.dateOfEmployeeAbsence,
      required this.absence,
      required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == Status.loading || status == Status.initial) {
      return const Padding(
        padding: EdgeInsets.all(43),
        child: ThreeBounceLoading(size: 15, color: AppColors.primaryBlue),
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

  const AbsenceEmployeeWrapLayout({Key? key, required this.absence})
      : super(key: key);

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
                    color: AppColors.whiteColor,
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
                                  style: AppTextStyle.style14,
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
      {Key? key, required this.dateOfEmployeeAbsence})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            locale.who_is_out_card_no_leave_present_title,
            style: AppFontStyle.titleDark,
          ),
          const SizedBox(height: 5),
          Text(
            locale.who_is_out_card_no_leave_present_message,
            style: AppFontStyle.labelGrey,
          ),
        ],
      ),
    );
  }
}
