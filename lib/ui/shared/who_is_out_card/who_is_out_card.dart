import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/ui/shared/who_is_out_card/widget/absence_employee_view.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../data/configs/colors.dart';
import '../../../data/configs/space_constant.dart';
import '../../../data/configs/text_style.dart';
import '../../../data/configs/theme.dart';
import '../../../data/core/utils/bloc_status.dart';
import '../../widget/error_snack_bar.dart';
import 'bloc/who_is_out_card_bloc.dart';
import 'bloc/who_is_out_card_event.dart';
import 'bloc/who_is_out_card_state.dart';

class WhoIsOutCard extends StatelessWidget {
  const WhoIsOutCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<WhoIsOutCardBloc, WhoIsOutCardState>(
      listenWhen: (previous, current) => current.status == Status.error && current.error != null,
      listener: (context, state) {
        if (state.status == Status.error && state.error != null) {
          showSnackBar(context: context, error: state.error);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 16),
            child: Text(
              AppLocalizations.of(context).who_is_out_card_title,
              style: AppFontStyle.headerDark,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: AppTheme.commonBorderRadius,
              color: AppColors.whiteColor,
              boxShadow: AppTheme.commonBoxShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LeaveCalendar(),
                const SizedBox(height: 10),
                const Divider(
                    indent: primaryHorizontalSpacing,
                    endIndent: primaryHorizontalSpacing,
                    height: 0),
                BlocBuilder<WhoIsOutCardBloc, WhoIsOutCardState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status ||
                      previous.selectedDate != current.selectedDate,
                  builder: (context, state) =>
                      AbsenceEmployeesListWhoIsOutCardView(
                    status: state.status,
                    absence: state.selectedDayAbsences,
                    dateOfEmployeeAbsence: state.selectedDate,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LeaveCalendar extends StatefulWidget {
  const LeaveCalendar({Key? key}) : super(key: key);

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
          return TableCalendar(
            rangeSelectionMode: RangeSelectionMode.disabled,
            onPageChanged: (focusedDay) => context
                .read<WhoIsOutCardBloc>()
                .add(FetchMoreLeaves(focusedDay)),
            onDaySelected: (selectedDay, focusedDay) {
              context
                  .read<WhoIsOutCardBloc>()
                  .add(ChangeCalendarDate(selectedDay));
            },
            onFormatChanged: (format) => context
                .read<WhoIsOutCardBloc>()
                .add(ChangeCalendarFormat(format)),
            availableGestures: AvailableGestures.horizontalSwipe,
            calendarFormat: state.calendarFormat,
            selectedDayPredicate: (day) => isSameDay(state.selectedDate, day),
            firstDay: DateTime(2020),
            lastDay: DateTime(2025),
            startingDayOfWeek: StartingDayOfWeek.sunday,
            calendarStyle: AppTheme.calendarStyle,
            headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                leftChevronMargin: EdgeInsets.zero,
                leftChevronPadding: EdgeInsets.zero,
                leftChevronIcon: SizedBox(),
                headerPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                rightChevronMargin: EdgeInsets.zero,
                rightChevronPadding: EdgeInsets.zero,
                titleCentered: true,
                leftChevronVisible: true,
                rightChevronIcon: CalendarFormatButton(),
                titleTextStyle: AppFontStyle.labelRegular),
            eventLoader: (day) => context
                .read<WhoIsOutCardBloc>()
                .getSelectedDateAbsences(date: day, allAbsences: state.allAbsences),
            focusedDay: state.focusDay,
          );
        });
  }
}

class CalendarFormatButton extends StatelessWidget {
  const CalendarFormatButton({Key? key}) : super(key: key);

  getCalendarFormat(CalendarFormat format) {
    if (format == CalendarFormat.week) {
      return CalendarFormat.twoWeeks;
    } else if (format == CalendarFormat.twoWeeks) {
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
              ChangeCalendarFormat(getCalendarFormat(state.calendarFormat))),
          icon: Icon(state.calendarFormat == CalendarFormat.month
              ? Icons.keyboard_arrow_up_rounded
              : Icons.keyboard_arrow_down_rounded)),
    );
  }
}
