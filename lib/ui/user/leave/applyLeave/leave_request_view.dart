import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:intl/intl.dart';
import 'package:projectunity/bloc/employee/leave/request_leave_bloc.dart';
import 'package:projectunity/configs/theme.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/utils/const/leave_time_constants.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/bottom_button.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/leave_request_reason_card.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/picker_card.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/leave_type_card.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/total_leave_card.dart';
import 'package:projectunity/widget/error_snackbar.dart';
import '../../../../configs/colors.dart';
import '../../../../configs/text_style.dart';
import '../../../../core/utils/const/space_constant.dart';
import '../../../../widget/date_time_picker.dart';

class RequestLeaveView extends StatefulWidget {
  const RequestLeaveView({Key? key}) : super(key: key);

  @override
  State<RequestLeaveView> createState() => _RequestLeaveViewState();
}

class _RequestLeaveViewState extends State<RequestLeaveView> {
  final _requestLeaveBloc = getIt<RequestLeaveBloc>();

  @override
  void initState() {
    _requestLeaveBloc.attach();
    _requestLeaveBloc.validLeave.listen((event) {
      event.whenOrNull(error: (error) {
        showSnackBar(context: context, error: error);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _requestLeaveBloc.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localization.leave_request_tag,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: primaryHalfSpacing, bottom: 80),
        children: [
           LeaveTypeCard(
             stream: _requestLeaveBloc.leaveType,
             onChange: (int? value, int leaveType) {
               leaveType = value ?? 0;
               _requestLeaveBloc.updateLeaveType(leaveType);
             }, leaveCount: _requestLeaveBloc.leaveCount,
           ),
          _buildDateSelection(),
          _buildDateRange(),
           TotalDaysMsgBox(totalLeaves: _requestLeaveBloc.totalLeave),
           LeaveRequestReasonCard(reason: _requestLeaveBloc.reason, onChanged: _requestLeaveBloc.updateReason),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ApplyButton(
        stream: _requestLeaveBloc.validLeave.stream,
        onPress: _requestLeaveBloc.validation,
      ),
    );
  }

  _buildDateRange(){
    var locale = AppLocalizations.of(context).localeName;
    return StreamBuilder<Map<DateTime,int>>(
      initialData: const {},
    stream: _requestLeaveBloc.selectedDates,
      builder: (context, snapshot) => snapshot.data!.length<3?Column(
        children: snapshot.data!.entries.map((date) => Container(
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
              _leaveTimePeriodBox(date)
            ],
          )

        ) ).toList()
      )
          :SingleChildScrollView(
        padding: const EdgeInsets.all(primaryHalfSpacing),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: snapshot.data!.entries.map((date)
          => Container(
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
                _leaveTimePeriodBox(date),
              ],
            ),
          )
          ).toList(),
        ),
      ),
    );
  }

  Widget _leaveTimePeriodBox(MapEntry<DateTime, int> date){
    return Container(
      height: MediaQuery.of(context).size.width*0.12,
      width: MediaQuery.of(context).size.width*0.26,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: date.key.isWeekend?AppColors.primaryGray:AppColors.darkGrey),
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
            value: date.value,
            items: dayLeaveTime.entries.map((e) => DropdownMenuItem(value:e.key,child: Center(child: Text(e.value)))).toList(),
            onChanged: !date.key.isWeekend?(value) {
            _requestLeaveBloc.updateLeaveOfDay(date.key,value!);
          }:null,),
        ),
      ),
    );
  }

  Widget _buildDateSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: primaryHalfSpacing),
      child: Row(
        children: [
          DatePickerCard(
            title: AppLocalizations.of(context).user_apply_leave_from_tag,
            stream: _requestLeaveBloc.startDate,
            onPress: () async {
              DateTime datetime = await _requestLeaveBloc.startDate.first;
              DateTime? date =
              await pickDate(context: context, initialDate: datetime,onlyFutureDateSelection: true);
              _requestLeaveBloc.updateStartLeaveDate(date);
            },
          ),
          DatePickerCard(
            title: AppLocalizations.of(context).user_apply_leave_to_tag,
            stream: _requestLeaveBloc.endDate,
            onPress: () async {
              DateTime dateTime = await _requestLeaveBloc.endDate.first;
              DateTime? date =
              await pickDate(context: context, initialDate: dateTime, onlyFutureDateSelection: true);
              _requestLeaveBloc.updateEndLeaveDate(date);
            },
          ),
        ],
      ),
    );
  }
}



