import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configs/colors.dart';
import '../../../../configs/text_style.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../model/leave/leave.dart';
import '../../../../widget/circular_progress_indicator.dart';
import '../../../../widget/error_snack_bar.dart';
import '../bloc/leaves/user_leave_bloc.dart';
import '../bloc/leaves/user_leave_event.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class PastLeaveCard extends StatelessWidget {
  const PastLeaveCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: BlocConsumer<UserLeaveBloc,UserLeaveState>(
          listener: (context,state){
            if(state is UserLeaveErrorState){
              showSnackBar(context: context, error: state.error);
            }
          },
          builder: (context,state) {
            if(state is UserLeaveLoadingState){
              return const AppCircularProgressIndicator();
            }else
              if(state is UserLeaveSuccessState){
              List<Leave> pastLeaves= state.pastLeaves;
             return ExpandablePanel(
               theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Past Leaves",
                      style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.greyColor,fontSize: 18),
                    )),
                collapsed: pastLeaves.isEmpty?Container():
                    LeaveCard(totalDays:pastLeaves[0].totalLeaves,
                        type: pastLeaves[0].leaveType,
                        startDate: pastLeaves[0].startDate,
                        endDate: pastLeaves[0].endDate,
                        status: pastLeaves[0].leaveStatus),

                expanded: pastLeaves.isEmpty?Container():Container(
                  height: 300,
                  child: ListView.builder(
                    itemCount: pastLeaves.length,
                      itemBuilder: (context,index){
                    Leave leave= pastLeaves[index];
                    return   LeaveCard(totalDays: leave.totalLeaves,type: leave.leaveType,startDate: leave.startDate,endDate: leave.endDate,status: leave.leaveStatus,);
                  }),
                ),
               builder: (context,expanded,collapsed){
                  return Expandable(collapsed: collapsed, expanded: expanded);
               },
              );
            }
            return Container();
          }
      ),
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
    final String leaveDuration= DateFormatter(localization).getLeaveDurationPresentation(totalDays);
    final String leaveStatus= localization.leave_type_placeholder_leave_status(type);
    final String leavePeriod= DateFormatter(localization).dateInLine(startTimeStamp: startDate, endTimeStamp: endDate);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 80,
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
                      style: TextStyle(
                          color: AppColors.greyColor,
                          fontWeight: FontWeight.w500)),
                  Text(leavePeriod,
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
              Column(
               crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                       leaveStatus,
                        style: AppTextStyle.bodyTextDark,
                      )
                    ],
                  ),
                  IconButton(
                      onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_outlined))

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
