import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/core/utils/date_formatter.dart';
import 'package:projectunity/ui/user/leaves/bloc/leaves/user_leave_bloc.dart';
import 'package:projectunity/ui/user/leaves/bloc/leaves/user_leave_event.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/error_snack_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../configs/colors.dart';
import '../../../../configs/text_style.dart';
import '../../../../model/leave/leave.dart';

class UpcomingLeaveCard extends StatelessWidget {
  const UpcomingLeaveCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization= AppLocalizations.of(context);
    bool isExpanded= false;

    return ExpansionPanelList(
      children: [
        ExpansionPanel(headerBuilder: (context, isExpanded){
         return Padding(padding: EdgeInsets.symmetric(vertical: 10),
           child: Column(
             children: [
               Text("Past leaves"),
               LeaveCard(totalDays: 20, type: 1, startDate: 546546, endDate: 54445, status: 1)
             ],
           ),

          );
        }, body: Column(
          children: [
            ListView.builder(
              shrinkWrap:true,
                itemCount: 5,
                itemBuilder: (context,index){
              return const LeaveCard(totalDays: 2, type: 5, startDate: 4565646, endDate: 4564, status: 2);
            })
          ],
        ))
      ],
    );
  }
}

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
    final String totalLeaveDays= DateFormatter(localization).getLeaveDurationPresentation(totalDays);
    final String leaveType= localization.leave_type_placeholder_leave_status(type);
    final String leaveTime= DateFormatter(localization).dateInLine(startTimeStamp: startDate, endTimeStamp: endDate);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
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
                  Text('3 days Application',
                      style: TextStyle(
                          color: AppColors.greyColor,
                          fontWeight: FontWeight.w500)),
                  Text('Wed, 10 Dec',
                      style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  Text(
                    'Casual',
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
