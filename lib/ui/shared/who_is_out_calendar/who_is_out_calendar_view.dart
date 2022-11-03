import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/user_profile_image.dart';
import '../../../bloc/shared/who_is_out_calendar/who_is_out_calendar_view_bloc.dart';
import '../../../configs/text_style.dart';
import '../../../core/utils/const/leave_map.dart';
import '../../../core/utils/const/space_constant.dart';
import '../../../model/leave_application.dart';
import '../../../widget/calendar.dart';

class WhoIsOutCalendarView extends StatefulWidget {
  const WhoIsOutCalendarView({Key? key}) : super(key: key);

  @override
  State<WhoIsOutCalendarView> createState() => _WhoIsOutCalendarViewState();
}

class _WhoIsOutCalendarViewState extends State<WhoIsOutCalendarView> {
  final _whoIsOutCalendarBloc = getIt<WhoIsOutCalendarBloc>();

  @override
  void initState() {
    _whoIsOutCalendarBloc.attach();
    super.initState();
  }

  @override
  void dispose() {
    _whoIsOutCalendarBloc.detach();
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
          stream: _whoIsOutCalendarBloc.allLeave,
          initialData: const ApiResponse.idle(),
          builder: (context, snapshot) {
            final Widget calender = Calendar(
                calendarFormatStream: _whoIsOutCalendarBloc.calendarFormat,
                selectedDateStream: _whoIsOutCalendarBloc.focusedDate.stream,
                onDaySelected: _whoIsOutCalendarBloc.selectDate,
                onVerticalSwipe: _whoIsOutCalendarBloc.changeCalendarFormatBySwipe,
                onFormatChanged: _whoIsOutCalendarBloc.changeCalendarFormat,
                eventLoader: _whoIsOutCalendarBloc.getEventsOfDay);
            final Widget emptyScreen = Center(child: Text( localization.calendar_no_leave_msg(_whoIsOutCalendarBloc.focusedDate.value,),style: AppTextStyle.secondarySubtitle500,textAlign: TextAlign.center,));
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
                          padding: const EdgeInsets.all(primaryHorizontalSpacing),
                          itemBuilder: (BuildContext context, int index) => CalendarEmployeeLeaveCard(
                            leaveApplication: leaveApplications[index],
                            onTap: (){
                              _whoIsOutCalendarBloc.onLeaveCardTap(leaveApplications[index]);
                            },
                          ),
                          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: primaryVerticalSpacing,),
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

class CalendarEmployeeLeaveCard extends StatelessWidget {
  final LeaveApplication leaveApplication;
  final void Function()? onTap;
  const CalendarEmployeeLeaveCard({Key? key,required this.leaveApplication, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: AppColors.primaryGray.withOpacity(0.60),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), topRight: Radius.circular(12)),
      ),
      child: Container(
        decoration:   BoxDecoration(
          border: Border(left: BorderSide(color: leaveRequestCardColor[leaveApplication.leave.leaveType]!,width: 5)),
        ),
        child: ListTile(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), topRight: Radius.circular(12)),
          ),
          onTap: onTap,
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
          leading: ImageProfile(radius: 30,imageUrl: leaveApplication.employee.imageUrl),
          title: Text(leaveApplication.employee.name),
          subtitle: Text(leaveApplication.employee.employeeId),
        ),
      ),
    );
  }
}
