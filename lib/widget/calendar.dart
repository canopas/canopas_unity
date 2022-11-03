import 'package:flutter/material.dart';
import 'package:projectunity/configs/theme.dart';
import 'package:projectunity/model/date_range_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import '../configs/colors.dart';
import 'bottom_sheet_top_divider.dart';

class Calendar extends StatelessWidget {
  final Stream<CalendarFormat> calendarFormatStream;
  final Stream<DateTime> selectedDateStream;
  final void Function(DateTime, DateTime)? onDaySelected;
  final List<dynamic> Function(DateTime)? eventLoader;
  final void Function(int) onVerticalSwipe;
  final void Function(CalendarFormat)? onFormatChanged;

  const Calendar(
      {Key? key,
      required this.calendarFormatStream,
      required this.selectedDateStream,
      required this.onDaySelected,
      required this.eventLoader,
      required this.onVerticalSwipe,
      required this.onFormatChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleGestureDetector(
      onVerticalSwipe: (direction){onVerticalSwipe(direction.index);},
      child: Card(
        elevation: 6,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(12),
                bottomLeft: Radius.circular(12))),
        shadowColor: AppColors.primaryGray.withOpacity(0.60),
        child: Column(
          children: [
            StreamBuilder<CalendarFormat>(
                initialData: CalendarFormat.month,
                stream: calendarFormatStream,
                builder: (context, calendarFormat) {
                  return StreamBuilder<DateTime>(
                      initialData: DateTime.now(),
                      stream: selectedDateStream,
                      builder: (context, selectedDate) {
                        return TableCalendar(
                          selectedDayPredicate: (day) {
                            return isSameDay(selectedDate.data, day);
                          },
                          onDaySelected: onDaySelected,
                          onFormatChanged: onFormatChanged,
                          calendarFormat: calendarFormat.data!,
                          focusedDay: selectedDate.data!,
                          firstDay: DateTime(2020),
                          lastDay: DateTime(2025),
                          startingDayOfWeek: StartingDayOfWeek.sunday,
                          calendarStyle: AppTheme.calendarStyle,
                          eventLoader: eventLoader,
                          headerStyle: AppTheme.calendarHeaderStyle,
                        );
                      });
                }),
            const BottomSheetTopSlider(),
          ],
        ),
      ),
    );
  }
}


class DateRangeCalendar extends StatelessWidget {

  final Stream<CalendarFormat> calendarFormatStream;
  final Stream<SelectedDateRange> selectedDateRangeStream;
  final void Function(DateTime?, DateTime?, DateTime)? onRangeSelected;
  final void Function(int) onVerticalSwipe;
  final List<dynamic> Function(DateTime)? eventLoader;
  final void Function(CalendarFormat)? onFormatChanged;

  const DateRangeCalendar({Key? key,
    required this.calendarFormatStream,
    required this.selectedDateRangeStream,
    required this.onRangeSelected,
    required this.onVerticalSwipe,
    required this.onFormatChanged,
    required this.eventLoader}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleGestureDetector(
        onVerticalSwipe: (direction){onVerticalSwipe(direction.index);},
        child: Card(
          elevation: 6,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12))),
          shadowColor: AppColors.primaryGray.withOpacity(0.60),
          child: Column(
            children: [
              StreamBuilder<CalendarFormat>(
                  initialData: CalendarFormat.month,
                  stream: calendarFormatStream,
                  builder: (context, calendarFormat) {
                    return StreamBuilder<SelectedDateRange>(
                        initialData: SelectedDateRange(selectedDate: DateTime.now(),),
                        stream: selectedDateRangeStream,
                        builder: (context, dateRange) {
                          return TableCalendar(
                            rangeSelectionMode: RangeSelectionMode.toggledOn,
                            onRangeSelected: onRangeSelected,
                            onFormatChanged: onFormatChanged,
                            calendarFormat: calendarFormat.data!,
                            focusedDay: dateRange.data!.selectedDate,
                            rangeStartDay: dateRange.data!.startDate,
                            rangeEndDay: dateRange.data!.endDate,
                            firstDay: DateTime(2020),
                            lastDay: DateTime(2025),
                            startingDayOfWeek: StartingDayOfWeek.sunday,
                            calendarStyle: AppTheme.calendarStyle,
                            headerStyle: AppTheme.calendarHeaderStyle,
                            eventLoader: eventLoader,
                          );
                        });
                  }),
              const BottomSheetTopSlider(),
            ],
          ),
        ),
    );
  }
}
