import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/configs/theme.dart';
import 'package:projectunity/ui/widget/user_profile_image.dart';
import '../../data/configs/colors.dart';
import '../../data/configs/space_constant.dart';
import '../../data/configs/text_style.dart';
import '../../data/core/utils/const/leave_map.dart';
import '../../data/core/utils/date_formatter.dart';
import '../../data/model/employee/employee.dart';
import '../../data/model/leave_application.dart';

class LeaveApplicationCard extends StatelessWidget {
  final void Function()? onTap;
  final LeaveApplication leaveApplication;

  const LeaveApplicationCard(
      {Key? key, required this.leaveApplication, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: primaryHorizontalSpacing, vertical: primaryHalfSpacing),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: AppTheme.commonBorderRadius,
            color: AppColors.whiteColor,
            boxShadow: AppTheme.commonBoxShadow),
        child: Material(
          borderRadius: AppTheme.commonBorderRadius,
          color: AppColors.whiteColor,
          child: InkWell(
            borderRadius: AppTheme.commonBorderRadius,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(primaryHorizontalSpacing),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _LeaveTypeContent(
                                leaveType: leaveApplication.leave.leaveType),
                            const SizedBox(
                              height: 10,
                            ),
                            _LeaveDateContent(
                              totalDays: leaveApplication.leave.totalLeaves,
                              startTimeStamp: leaveApplication.leave.startDate,
                              endTimeStamp: leaveApplication.leave.endDate,
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: AppColors.greyColor,
                      )
                    ],
                  ),
                  const Divider(
                      thickness: 1, height: 30, color: AppColors.dividerColor),
                  _EmployeeContent(
                    employee: leaveApplication.employee,
                  ),

                  // const ButtonContent()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LeaveTypeContent extends StatelessWidget {
  final int leaveType;

  const _LeaveTypeContent({Key? key, required this.leaveType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: leaveRequestCardColor[leaveType],
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Text(
        AppLocalizations.of(context)
            .leave_type_placeholder_text(leaveType.toString()),
        style: AppFontStyle.labelRegular.copyWith(color: AppColors.whiteColor),
      ),
    );
  }
}

class _LeaveDateContent extends StatelessWidget {
  final double totalDays;
  final int startTimeStamp;
  final int endTimeStamp;

  const _LeaveDateContent(
      {Key? key,
      required this.totalDays,
      required this.startTimeStamp,
      required this.endTimeStamp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String duration = DateFormatter(AppLocalizations.of(context))
        .dateInLine(startTimeStamp: startTimeStamp, endTimeStamp: endTimeStamp);
    String days = DateFormatter(AppLocalizations.of(context))
        .getLeaveDurationPresentation(totalDays);

    return Text(
      '$days, $duration ',
      style: AppFontStyle.subTitleGrey,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _EmployeeContent extends StatelessWidget {
  final Employee employee;

  const _EmployeeContent({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageProfile(
          borderColor: AppColors.blackColor,
          borderSize: 1,
          radius: 25,
          imageUrl: employee.imageUrl,
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              employee.name,
              style: AppFontStyle.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              employee.employeeId,
              style: AppFontStyle.subTitleGrey,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}
