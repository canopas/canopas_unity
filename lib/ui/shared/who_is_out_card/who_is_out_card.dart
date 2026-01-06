import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/core/extensions/date_formatter.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/ui/shared/who_is_out_card/widget/absence_employee_view.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../data/configs/theme.dart';
import '../../../data/core/utils/bloc_status.dart';
import '../../widget/error_snack_bar.dart';
import 'bloc/who_is_out_card_bloc.dart';
import 'bloc/who_is_out_card_event.dart';
import 'bloc/who_is_out_card_state.dart';

class WhoIsOutCard extends StatelessWidget {
  const WhoIsOutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<WhoIsOutCardBloc, WhoIsOutCardState>(
      listenWhen: (previous, current) =>
          current.status == Status.error && current.error != null,
      listener: (context, state) {
        if (state.status == Status.error && state.error != null) {
          showSnackBar(context: context, error: state.error);
        }
      },
      child: BlocBuilder<WhoIsOutCardBloc, WhoIsOutCardState>(
        buildWhen: (previous, current) =>
            previous.status != current.status ||
            previous.selectedDate != current.selectedDate ||
            previous.calendarFormat != current.calendarFormat,
        builder: (context, state) {
          final calendarFormat = state.calendarFormat;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  boxShadow: calendarFormat == CalendarFormat.week
                      ? [
                          BoxShadow(
                            color: context.colorScheme.outlineColor,
                            blurRadius: 3.0,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                child: const LeaveCalendar(),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  context.l10n.who_is_out_card_title,
                  style: AppTextStyle.style20.copyWith(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              BlocBuilder<WhoIsOutCardBloc, WhoIsOutCardState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status ||
                    previous.selectedDate != current.selectedDate,
                builder: (context, state) =>
                    AbsenceEmployeesListWhoIsOutCardView(
                      status: state.status,
                      absence: state.selectedDayAbsences ?? [],
                      dateOfEmployeeAbsence: state.selectedDate,
                    ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class LeaveCalendar extends StatefulWidget {
  const LeaveCalendar({super.key});

  @override
  State<LeaveCalendar> createState() => _LeaveCalendarState();
}

class _LeaveCalendarState extends State<LeaveCalendar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WhoIsOutCardBloc, WhoIsOutCardState>(
      buildWhen: (previous, current) =>
          previous.allAbsences != current.allAbsences ||
          previous.selectedDate != current.selectedDate ||
          previous.calendarFormat != current.calendarFormat,
      builder: (context, state) {
        final calendarFormat = state.calendarFormat;
        return TableCalendar(
          calendarBuilders: CalendarBuilders(
            headerTitleBuilder: (context, day) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    calendarFormat == CalendarFormat.week
                        ? day.toDateWithYear()
                        : day.toMonthYear(),
                    style: AppTextStyle.style18.copyWith(
                      color: context.colorScheme.textPrimary,
                    ),
                  ),
                  const CalendarFormatButton(),
                ],
              );
            },
          ),
          headerVisible: true,
          rangeSelectionMode: RangeSelectionMode.disabled,
          onPageChanged: (focusedDay) => context.read<WhoIsOutCardBloc>().add(
            FetchWhoIsOutCardLeaves(focusDay: focusedDay),
          ),
          onDaySelected: (selectedDay, focusedDay) {
            context.read<WhoIsOutCardBloc>().add(
              ChangeCalendarDate(selectedDay),
            );
          },
          onFormatChanged: (format) => context.read<WhoIsOutCardBloc>().add(
            ChangeCalendarFormat(format),
          ),
          availableGestures: AvailableGestures.horizontalSwipe,
          calendarFormat: state.calendarFormat,
          selectedDayPredicate: (day) => isSameDay(state.selectedDate, day),
          firstDay: DateTime(2022),
          lastDay: DateTime(2040),
          startingDayOfWeek: StartingDayOfWeek.sunday,
          calendarStyle: AppTheme.calendarStyle(context),
          daysOfWeekStyle: AppTheme.daysOfWeekStyle(context),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            rightChevronVisible: false,
            leftChevronVisible: false,
          ),
          eventLoader: (day) =>
              context.read<WhoIsOutCardBloc>().getSelectedDateAbsences(
                date: day,
                allAbsences: state.allAbsences,
              ),
          focusedDay: state.focusDay,
        );
      },
    );
  }
}

class CalendarFormatButton extends StatelessWidget {
  const CalendarFormatButton({super.key});

  CalendarFormat getCalendarFormat(CalendarFormat format) {
    if (format == CalendarFormat.week) {
      return CalendarFormat.month;
    } else {
      return CalendarFormat.week;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WhoIsOutCardBloc, WhoIsOutCardState>(
      buildWhen: (previous, current) =>
          previous.calendarFormat != current.calendarFormat,
      builder: (context, state) => IconButton(
        onPressed: () => context.read<WhoIsOutCardBloc>().add(
          ChangeCalendarFormat(getCalendarFormat(state.calendarFormat)),
        ),
        icon: Icon(
          state.calendarFormat == CalendarFormat.month
              ? Icons.arrow_drop_up
              : Icons.arrow_drop_down,
        ),
      ),
    );
  }
}
