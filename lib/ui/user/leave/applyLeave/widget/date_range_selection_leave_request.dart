import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../core/extensions/date_time.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../../configs/colors.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../configs/theme.dart';
import '../../../../../core/utils/const/leave_time_constants.dart';
import '../../../../../core/utils/const/space_constant.dart';
import '../bloc/leave_request_form_bloc/leave_request_view_bloc.dart';
import '../bloc/leave_request_form_bloc/leave_request_view_events.dart';
import '../bloc/leave_request_form_bloc/leave_request_view_states.dart';

class LeaveRequestDateRange extends StatelessWidget {
  const LeaveRequestDateRange({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context).localeName;
    return BlocBuilder<LeaveRequestBloc, LeaveRequestViewState>(
      builder: (context, state) => state.selectedDates.length<3?Column(
          children: state.selectedDates.entries.map((date) => Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: primarySpacing,vertical: primaryHalfSpacing),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppTheme.commonBorderRadius,
                  boxShadow: AppTheme.commonBoxShadow
              ),
              child: Row(
                children: [
                  Text(DateFormat('EEEE, ',locale).format(date.key),style: AppTextStyle.bodyTextDark,),
                  Text(DateFormat('d ',locale).format(date.key),style: AppTextStyle.bodyTextDark.copyWith(color: AppColors.primaryBlue,fontWeight: FontWeight.bold),),
                  Text(DateFormat('MMMM',locale).format(date.key),style: AppTextStyle.bodyTextDark,),
                  const Spacer(),
                  LeaveTimePeriodBox(dayTimePeriod: date,),
                ],
              )

          ) ).toList()
      )
          :SingleChildScrollView(
        padding: const EdgeInsets.all(primaryHalfSpacing),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: state.selectedDates.entries.map((date) => Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: primaryHalfSpacing),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppTheme.commonBorderRadius,
                boxShadow: AppTheme.commonBoxShadow
            ),
            child: Column(
              children: [
                Text(DateFormat('EEE',locale).format(date.key),),
                Text(DateFormat('d',locale).format(date.key),style: AppTextStyle.titleText.copyWith(color: AppColors.primaryBlue, fontWeight: FontWeight.bold),),
                Text(DateFormat('MMM',locale).format(date.key),),
                const SizedBox(height: primaryVerticalSpacing,),
                LeaveTimePeriodBox(dayTimePeriod: date),
              ],
            ),
          )
          ).toList(),
        ),
      ),
    );
  }
}

class LeaveTimePeriodBox extends StatelessWidget {
  final MapEntry<DateTime,int> dayTimePeriod;
  const LeaveTimePeriodBox({Key? key, required this.dayTimePeriod, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width*0.12,
      width: MediaQuery.of(context).size.width*0.26,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: dayTimePeriod.key.isWeekend?AppColors.primaryGray:AppColors.darkGrey),
      ),
      child: Material(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            style: AppTextStyle.bodyTextDark,
            isExpanded: true,
            iconSize: 0.0,
            icon: const SizedBox(),
            borderRadius: BorderRadius.circular(12),
            alignment: Alignment.center,
            value: dayTimePeriod.value,
            items: dayLeaveTime.entries.where((e) => dayTimePeriod.key.weekday != DateTime.saturday || e.key == 0 || e.key == 3 ).map((e) => DropdownMenuItem(value:e.key,child: Center(child: Text(e.value)))).toList(),
            onChanged: !dayTimePeriod.key.isWeekend?(value) {
              context.read<LeaveRequestBloc>().add(LeaveRequestUpdateLeaveOfTheDayEvent(date: dayTimePeriod.key, value: value ?? dayTimePeriod.value
              ));
            }:null,),
        ),
      ),
    );
  }
}
