import 'package:flutter/material.dart';
import 'package:projectunity/bloc/shared/user_leave_calendar/user_leave_calendar_bloc.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/ui/user/leave/leaveScreen/widget/leave_card.dart';
import 'package:projectunity/widget/calendar.dart';
import '../../../configs/colors.dart';
import '../../../core/utils/const/space_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../model/leave_application.dart';
import '../../../rest/api_response.dart';
import '../../../widget/circular_progress_indicator.dart';


class UserLeaveCalendarView extends StatefulWidget {
  final String userId;
  const UserLeaveCalendarView({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserLeaveCalendarView> createState() => _UserLeaveCalendarViewState();
}

class _UserLeaveCalendarViewState extends State<UserLeaveCalendarView> {

  final UserLeaveCalendarBloc _userLeaveCalendarBloc = getIt<UserLeaveCalendarBloc>();
  @override
  void initState() {
    _userLeaveCalendarBloc.getUserAllLeave(userID: widget.userId);
    super.initState();
  }

  @override
  void dispose() {
    _userLeaveCalendarBloc.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.leave_calendar_title),
      ),
      body: StreamBuilder<ApiResponse<List<LeaveApplication>>>(
          initialData: const ApiResponse.idle(),
          stream: _userLeaveCalendarBloc.allLeave,
          builder: (context, snapshot) {
            final Widget calender = DateRangeCalendar(
                calendarFormatStream: _userLeaveCalendarBloc.calendarFormat,
                selectedDateRangeStream: _userLeaveCalendarBloc.selectedDateRange,
                onRangeSelected: _userLeaveCalendarBloc.getDateRangeLeaves,
                onVerticalSwipe: _userLeaveCalendarBloc.changeCalendarFormatBySwipe,
                onFormatChanged: _userLeaveCalendarBloc.changeCalendarFormat,
                eventLoader: _userLeaveCalendarBloc.getEventsOfDay,
            );
            final Widget emptyScreen = Center(child: Text(
              (_userLeaveCalendarBloc.selectedDateRange.value.endDate!=null)?localization.range_calendar_no_leave_msg(_userLeaveCalendarBloc.selectedDateRange.value.startDate!, _userLeaveCalendarBloc.selectedDateRange.value.endDate!):localization.calendar_no_leave_msg(_userLeaveCalendarBloc.selectedDateRange.value.selectedDate,),style: AppTextStyle.secondarySubtitle500,textAlign: TextAlign.center,));
            return snapshot.data!.when(
              idle: () => Column(
                children: [
                  calender,
                  emptyScreen,
                ],
              ),
              loading: () => const kCircularProgressIndicator(),
              completed: (leaveApplications) => Column(
                children: [
                  calender,
                  Expanded(
                    child: (leaveApplications.isNotEmpty)?ListView.separated(
                      padding: const EdgeInsets.all( primaryHorizontalSpacing),
                      itemBuilder: (BuildContext context, int index) => LeaveCard(leaveApplication: leaveApplications[index], onTap: () {_userLeaveCalendarBloc.onLeaveCardTap(leaveApplications[index]);},),
                      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: primaryHorizontalSpacing,),
                      itemCount: leaveApplications.length,
                    ):emptyScreen,
                  ),
                ],
              ),
              error: (error) => Column(
                children: [
                  calender,
                  emptyScreen,
                ],
              ),
            );
          }),
      backgroundColor: AppColors.whiteColor,
    );
  }
}
