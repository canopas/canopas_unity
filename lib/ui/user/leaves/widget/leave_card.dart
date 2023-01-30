import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter/material.dart';

import '../../../../configs/colors.dart';
import '../../../../configs/text_style.dart';
import '../../../../core/utils/date_formatter.dart';

class LeaveCard extends StatelessWidget {
  final double totalDays;
  final int startDate;
  final int endDate;
  final int type;
  final int status;

  const LeaveCard({
    required this.totalDays,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.status,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization= AppLocalizations.of(context);
    final String leaveDuration= DateFormatter(localization).getLeaveDurationPresentation(totalDays);
    final String leaveType= localization.leave_type_placeholder_leave_status(type);
    final String leaveTime= DateFormatter(localization).dateInLine(startTimeStamp: startDate, endTimeStamp: endDate);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 70,
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(leaveDuration,
                          style: const TextStyle(
                              color: AppColors.greyColor,
                              fontWeight: FontWeight.w500)),
                      Text(leaveTime,
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      Text(
                        leaveType,
                        style: TextStyle(
                            color:
                            AppColors.primaryDarkYellow),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.error,
                        color: AppColors.secondaryText,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Rejected',
                        style: AppTextStyle.bodyTextDark,
                      ),
                      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_outlined))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}