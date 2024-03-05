import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:intl/intl.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/style/app_text_style.dart';
import '../../../../../data/configs/space_constant.dart';
import '../bloc/apply_leave_bloc.dart';
import '../bloc/apply_leave_event.dart';
import '../bloc/apply_leave_state.dart';

class LeaveRequestDateRange extends StatelessWidget {
  const LeaveRequestDateRange({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context).localeName;
    return BlocBuilder<ApplyLeaveBloc, ApplyLeaveState>(
      buildWhen: (previous, current) =>
          previous.selectedDates != current.selectedDates,
      builder: (context, state) => state.selectedDates.length < 3
          ? Column(
              children: state.selectedDates.entries
                  .map((date) => Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: primarySpacing,
                          vertical: primaryHalfSpacing),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: context.colorScheme.containerHigh),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Text(
                            DateFormat('EEEE, ', locale).format(date.key),
                            style: AppTextStyle.style14.copyWith(
                                color: context.colorScheme.textPrimary),
                          ),
                          Text(
                            DateFormat('d ', locale).format(date.key),
                            style: AppTextStyle.style20
                                .copyWith(color: context.colorScheme.primary),
                          ),
                          Text(
                            DateFormat('MMMM', locale).format(date.key),
                            style: AppTextStyle.style14.copyWith(
                                color: context.colorScheme.textPrimary),
                          ),
                          const Spacer(),
                          LeaveTimePeriodBox(
                            dayTimePeriod: date,
                          ),
                        ],
                      )))
                  .toList())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(primaryHalfSpacing),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: state.selectedDates.entries
                    .map((date) => Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.symmetric(
                              horizontal: primaryHalfSpacing),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: context.colorScheme.containerHigh),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Text(
                                DateFormat('EEE', locale).format(date.key),
                                style: AppTextStyle.style14.copyWith(
                                    color: context.colorScheme.textPrimary),
                              ),
                              Text(
                                DateFormat('d', locale).format(date.key),
                                style: AppTextStyle.style20.copyWith(
                                    color: context.colorScheme.primary),
                              ),
                              Text(DateFormat('MMM', locale).format(date.key),
                                  style: AppTextStyle.style14.copyWith(
                                      color: context.colorScheme.textPrimary)),
                              const SizedBox(
                                height: primaryVerticalSpacing,
                              ),
                              LeaveTimePeriodBox(dayTimePeriod: date),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
    );
  }
}

class LeaveTimePeriodBox extends StatelessWidget {
  final MapEntry<DateTime, LeaveDayDuration> dayTimePeriod;

  const LeaveTimePeriodBox({
    super.key,
    required this.dayTimePeriod,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 150,
      ),
      height: 50,
      width: MediaQuery.of(context).size.width * 0.26,
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.containerHigh),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<LeaveDayDuration>(
            dropdownColor: context.colorScheme.surface,
            isExpanded: true,
            iconSize: 0.0,
            icon: const SizedBox(),
            borderRadius: BorderRadius.circular(12),
            alignment: Alignment.center,
            value: dayTimePeriod.value,
            items: LeaveDayDuration.values
                .map((dayDuration) => DropdownMenuItem(
                    value: dayDuration,
                    child: Center(
                        child: Text(
                      context.l10n.leave_day_duration_tag(dayDuration.name),
                      style: AppTextStyle.style14,
                    ))))
                .toList(),
            onChanged: (value) {
              context.read<ApplyLeaveBloc>().add(
                  ApplyLeaveUpdateLeaveOfTheDayEvent(
                      date: dayTimePeriod.key,
                      value: value ?? dayTimePeriod.value));
            },
          ),
        ),
      ),
    );
  }
}
