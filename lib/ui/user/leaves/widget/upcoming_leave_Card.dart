import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/ui/user/leaves/bloc/leaves/user_leave_bloc.dart';
import 'package:projectunity/ui/user/leaves/bloc/leaves/user_leave_event.dart';
import 'package:projectunity/widget/error_snack_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../configs/colors.dart';
import '../../../../model/leave/leave.dart';
import 'package:projectunity/ui/user/leaves/widget/leave_card.dart';


class UpcomingLeaveCard extends StatelessWidget {
  const UpcomingLeaveCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization= AppLocalizations.of(context);
    bool isExpanded= false;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: BlocConsumer<UserLeaveBloc,UserLeaveState>(
        listener: (context,state){
          if(state is UserLeaveErrorState){
            showSnackBar(context: context, error: state.error);
          }
        },
        builder: (context,state) {
          if(state is UserLeaveSuccessState){
            List<Leave> pastLeaves= state.upcomingLeaves;
            return ExpandablePanel(
              theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToCollapse: true,
              ),
              header: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Upcoming Leaves",
                    style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.greyColor,fontSize: 18),
                  )),
              collapsed: pastLeaves.isEmpty?Container():
              LeaveCard(totalDays:pastLeaves[0].totalLeaves,
                  type: pastLeaves[0].leaveType,
                  startDate: pastLeaves[0].startDate,
                  endDate: pastLeaves[0].endDate,
                  status: pastLeaves[0].leaveStatus),

              expanded: pastLeaves.isEmpty?Container():ListView.builder(
                  itemCount: pastLeaves.length,
                  itemBuilder: (context,index){
                    Leave leave= pastLeaves[index];
                    return   LeaveCard(totalDays: leave.totalLeaves,type: leave.leaveType,startDate: leave.startDate,endDate: leave.endDate,status: leave.leaveStatus,);
                  }),
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


