import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/provider/user_status_notifier.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../data/configs/space_constant.dart';
import '../../../data/configs/text_style.dart';
import '../../../data/configs/theme.dart';
import '../../../data/model/leave_application.dart';
import '../../../data/di/service_locator.dart';
import '../../navigation/app_router.dart';
import '../../widget/calendar.dart';
import '../../widget/circular_progress_indicator.dart';
import '../../widget/leave_application_card.dart';
import 'bloc/calendar_bloc/employees_calendar_bloc.dart';
import 'bloc/calendar_bloc/employees_calendar_event.dart';
import 'bloc/calendar_leaves_bloc/employees_calendar_leaves_bloc.dart';
import 'bloc/calendar_leaves_bloc/employees_calendar_leaves_state.dart';
import 'bloc/calendar_leaves_bloc/employees_calender_leaves_event.dart';

class EmployeesLeaveCalenderPage extends StatelessWidget {
  const EmployeesLeaveCalenderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => getIt<EmployeesCalenderBloc>(),
      ),
      BlocProvider(
        create: (_) => getIt<EmployeesCalendarLeavesBloc>()
          ..add(EmployeeCalenadarLeavesInitialLoadEvent()),
      ),
    ], child: const EmployeesCalendarScreen());
  }
}

class EmployeesCalendarScreen extends StatefulWidget {
  const EmployeesCalendarScreen({Key? key}) : super(key: key);

  @override
  State<EmployeesCalendarScreen> createState() =>
      _EmployeesCalendarScreenState();
}

class _EmployeesCalendarScreenState extends State<EmployeesCalendarScreen> {

  final userStateNotifier = getIt<UserStatusNotifier>();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(localization.leave_calendar_title),
        ),
        body: Column(
          children: [
            CalendarCard(
              calendar: TableCalendar(
                rangeSelectionMode: RangeSelectionMode.disabled,
                onDaySelected: (selectedDay, focusedDay) {
                  context
                      .read<EmployeesCalenderBloc>()
                      .add(EmployeesCalendarSelectDateEvent(selectedDay));
                  context
                      .read<EmployeesCalendarLeavesBloc>()
                      .add(GetSelectedDateLeavesEvent(selectedDay));
                },
                onFormatChanged: (format) {
                  context
                      .read<EmployeesCalenderBloc>()
                      .add(EmployeesCalendarFormatChangeEvent(format));
                },
                calendarFormat:
                    context.watch<EmployeesCalenderBloc>().state.calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(
                      context.watch<EmployeesCalenderBloc>().state.selectedDate,
                      day);
                },
                focusedDay:
                    context.watch<EmployeesCalenderBloc>().state.selectedDate,
                firstDay: DateTime(2020),
                lastDay: DateTime(2025),
                startingDayOfWeek: StartingDayOfWeek.sunday,
                calendarStyle: AppTheme.calendarStyle,
                headerStyle: AppTheme.calendarHeaderStyle,
                eventLoader:
                    context.watch<EmployeesCalendarLeavesBloc>().getEvents,
              ),
              onVerticalSwipe: (swipe) {
                context
                    .read<EmployeesCalenderBloc>()
                    .add(EmployeesCalendarVerticalSwipeEvent(swipe.index));
              },
            ),
            Expanded(
              child: BlocBuilder<EmployeesCalendarLeavesBloc,
                  EmployeesCalendarLeavesState>(builder: (context, state) {
                if (state is EmployeesCalendarLeavesLoadingState) {
                  return const AppCircularProgressIndicator();
                } else if (state is EmployeesCalendarLeavesSuccessState &&
                    state.leaveApplications.isNotEmpty) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (BuildContext context, int index) {
                      LeaveApplication leaveApplication =
                          state.leaveApplications[index];
                      return Padding(
                        padding:  const EdgeInsets.symmetric(
                            horizontal: primaryHorizontalSpacing, vertical: primaryHalfSpacing),
                        child: LeaveApplicationCard(
                            leaveApplication: leaveApplication,
                            onTap: () {
                              userStateNotifier.isAdmin || userStateNotifier.isHR
                                  ? context.pushNamed(
                                      Routes.adminAbsenceDetails,
                                      extra: leaveApplication)
                                  : context.pushNamed(Routes.userAbsenceDetails,
                                     params: {RoutesParamsConst.leaveId:leaveApplication.leave.leaveId});
                            }),
                      );
                    },
                    itemCount: state.leaveApplications.length,
                  );
                }
                return Center(
                    child: Text(
                  localization.calendar_no_leave_msg(context
                      .watch<EmployeesCalenderBloc>()
                      .state
                      .selectedDate),
                  style: AppFontStyle.labelGrey,
                  textAlign: TextAlign.center,
                ));
              }),
            )
          ],
        ));
  }
}
