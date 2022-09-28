import 'package:flutter/material.dart';
import 'package:projectunity/model/leave/leave.dart';
import '../../bloc/admin/leave_details_screen/admin_leave_details_bloc.dart';
import '../../configs/colors.dart';
import '../../configs/text_style.dart';
import '../../core/utils/date_string_utils.dart';
import '../../di/service_locator.dart';
import '../../model/admin_leave_details/admin_remaining_leave_model.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class RemainingLeaveContainer extends StatefulWidget {
  final Leave leave;
  final String employeeId;
  const RemainingLeaveContainer({Key? key, required this.leave, required this.employeeId}) : super(key: key);

  @override
  State<RemainingLeaveContainer> createState() => _RemainingLeaveContainerState();
}

class _RemainingLeaveContainerState extends State<RemainingLeaveContainer> {


  final _adminDetailsScreenBloc = getIt<AdminLeaveDetailsScreenBloc>();
  @override
  void initState() {
    _adminDetailsScreenBloc.fetchUserRemainingLeaveDetails(id: widget.employeeId);
    super.initState();
  }

  @override
  void dispose() {
    _adminDetailsScreenBloc.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _localization = AppLocalizations.of(context);
    String totalDays = daysFinder(widget.leave.totalLeaves);
    String duration = dateInSingleLine(
        startTimeStamp: widget.leave.startDate,
        endTimeStamp: widget.leave.endDate,
        locale: _localization.localeName);

    return Container(
      height: MediaQuery.of(context).size.height*0.2,
      color: AppColors.primaryBlue.withOpacity(0.10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:   [
          Text(totalDays,  style: AppTextStyle.titleBlack600.copyWith(color: AppColors.primaryBlue),),
          SizedBox(height: MediaQuery.of(context).size.height*0.01,),
          Text(duration, style: AppTextStyle.titleText,),
          SizedBox(height: MediaQuery.of(context).size.height*0.01,),
          StreamBuilder(
            stream: _adminDetailsScreenBloc.remainingLeaveStream,
            builder: (context,AsyncSnapshot<RemainingLeave> snapshot) => Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 10,
                      width: MediaQuery.of(context).size.width*0.8,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      height: 10,
                      width: (snapshot.data?.remainingLeavePercentage == null)?(MediaQuery.of(context).size.width * 0.8) * 0:(MediaQuery.of(context).size.width * 0.8) * snapshot.data!.remainingLeavePercentage,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                Text(_localization.admin_leave_detail_placeholder_remaining_days(snapshot.data?.remainingLeave?? 0),),
              ],
            ),
          )
        ],
      ),
    );
  }
}