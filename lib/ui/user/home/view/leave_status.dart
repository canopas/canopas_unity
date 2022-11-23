import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/core/extensions/double_extension.dart';
import 'package:projectunity/ui/user/home/bloc/employee_home_state.dart';

import '../../../../../configs/colors.dart';
import '../../../../configs/text_style.dart';
import '../../../../model/leave_count.dart';
import '../bloc/employee_home_bloc.dart';

class LeaveStatus extends StatelessWidget {
   const LeaveStatus({Key? key,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
          color: AppColors.primaryDarkYellow,
          elevation: 8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: IntrinsicHeight(
              child:BlocBuilder<EmployeeHomeBloc, EmployeeHomeState>(
                builder: (BuildContext context,EmployeeHomeState state){
                  LeaveCounts leaveCounts= state.leaveCount;
                  return  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LeaveInfo(
                        title: AppLocalizations.of(context).user_home_remaining_tag,
                        counts: leaveCounts.remainingLeaveCount,
                      ),
                      Container(
                        width: 1,
                        color: Colors.grey,
                      ),
                      LeaveInfo(
                          title: AppLocalizations.of(context).user_home_all_tag,
                          counts: leaveCounts.paidLeaveCount.toDouble()),
                      Container(
                        width: 1,
                        color: AppColors.secondaryText,
                      ),
                      LeaveInfo(
                          title: AppLocalizations.of(context).user_home_paid_leave_tag,
                          counts: leaveCounts.usedLeaveCount),
                    ],
                  );
                },
              ),
            ),
          )),
    );
  }
}

class LeaveInfo extends StatelessWidget {
  final String title;
  final double counts;

  const LeaveInfo({Key? key, required this.title, required this.counts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTextStyle.leaveStatusCardTitle,
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          AppLocalizations.of(context).days_placeholder_leave(counts.fixedAt(1)),
          style: AppTextStyle.subTitleTextStyle,
        )
      ],
    );
  }
}
