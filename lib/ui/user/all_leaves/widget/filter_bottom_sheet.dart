import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../ui/user/all_leaves/bloc/leaves_bloc/all_leaves_bloc.dart';
import '../../../../ui/user/all_leaves/bloc/leaves_bloc/all_leaves_event.dart';
import '../../../../configs/text_style.dart';
import '../../../../core/utils/const/leave_map.dart';
import '../../../../core/utils/const/space_constant.dart';
import '../../../../widget/bottom_sheet_top_divider.dart';
import '../../../../widget/date_time_picker.dart';
import '../bloc/filter_bloc/all_leaves_filter_event.dart';
import '../bloc/filter_bloc/all_leaves_filter_state.dart';
import '../bloc/filter_bloc/all_leaves_filter_bloc.dart';
import 'filter_button.dart';
import 'filter_title.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding:
      const EdgeInsets.all(primaryHorizontalSpacing).copyWith(top: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BottomSheetTopSlider(),
          FilterTitle(text: localization.leave_type_tag),
          BlocBuilder<AllLeavesFilterBloc, AllLeavesFilterState>(
            buildWhen: (previous, current) =>
            previous.filterByLeaveTypes != current.filterByLeaveTypes,
            builder: (context, state) {
              return Wrap(
                children: leaveTypeMap.entries
                    .map((e) => Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: FilterButton(
                        onPressed: () =>
                            context.read<AllLeavesFilterBloc>()
                                .add(LeaveTypeChangeEvent(e.key)),
                        text: localization
                            .leave_type_placeholder_leave_status(e.key),
                        isSelected:
                        state.filterByLeaveTypes.contains(e.key))))
                    .toList(),
              );
            },
          ),
          FilterTitle(text: localization.leave_status_tag),
          BlocBuilder<AllLeavesFilterBloc, AllLeavesFilterState>(
            buildWhen: (previous, current) =>
            previous.filterByLeaveStatus != current.filterByLeaveStatus,
            builder: (context, state) => Row(
              children: leaveStatusMap.entries
                  .map((e) => Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: FilterButton(
                        onPressed: () =>
                            context.read<AllLeavesFilterBloc>()
                                .add(LeaveStatusChangeEvent(e.key)),
                        text: localization
                            .leave_status_placeholder_text(e.key),
                        isSelected:
                        state.filterByLeaveStatus.contains(e.key),
                      ))))
                  .toList(),
            ),
          ),
          FilterTitle(text: localization.user_leave_filter_date_range_tag),
          BlocBuilder<AllLeavesFilterBloc, AllLeavesFilterState>(
            buildWhen: (previous, current) =>
            previous.filterStartDate != current.filterStartDate,
            builder: (context, state) => ListTile(
              onTap: () async {
                final bloc = context.read<AllLeavesFilterBloc>();
                DateTime? startTime = await pickDate(
                    context: context,
                    initialDate: state.filterStartDate ?? DateTime.now());

                bloc.add(StartDateChangeEvent(startTime));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Text(
                localization.user_apply_leave_from_tag,
                style: AppTextStyle.subtitleTextDark,
              ),
              trailing: Text(
                (state.filterStartDate == null)
                    ? localization.user_apply_leave_select_tag
                    : localization.date_format_yMMMd(state.filterStartDate!),
                style: AppTextStyle.subtitleTextDark,
              ),
            ),
          ),
          BlocBuilder<AllLeavesFilterBloc, AllLeavesFilterState>(
            buildWhen: (previous, current) =>
            previous.filterEndDate != current.filterEndDate,
            builder: (context, state) => ListTile(
              onTap: () async {
                final bloc = context.read<AllLeavesFilterBloc>();
                DateTime? endDate = await pickDate(
                    context: context,
                    initialDate: state.filterEndDate ?? DateTime.now());
                bloc.add(EndDateChangeEvent(endDate));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Text(
                localization.user_apply_leave_to_tag,
                style: AppTextStyle.subtitleTextDark,
              ),
              trailing: Text(
                (state.filterEndDate == null)
                    ? localization.user_apply_leave_select_tag
                    : localization.date_format_yMMMd(state.filterEndDate!),
                style: AppTextStyle.subtitleTextDark,
              ),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context.read<AllLeavesFilterBloc>()
                          .add(RemoveFilterEvent());
                      context.read<AllLeavesViewBloc>()
                          .add(RemoveFilterAllLeavesViewEvent());
                      Navigator.pop(context);
                    },
                    child: Text(localization.user_leave_filter_remove_filter_tag),
                  )),
              const SizedBox(
                width: primaryHorizontalSpacing,
              ),
              Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AllLeavesFilterBloc>().add(ApplyFilterEvent());
                      AllLeavesFilterState filterState = context.read<AllLeavesFilterBloc>().state;
                      context.read<AllLeavesViewBloc>()
                          .add(ApplyFilterAllLeavesViewEvent(
                        leaveType: filterState.filterByLeaveTypes,
                        leaveStatus: filterState.filterByLeaveStatus,
                        endDate: filterState.filterEndDate,
                        startDate: filterState.filterStartDate,
                      ));
                      Navigator.pop(context);
                    },
                    child: Text(localization.user_leave_filter_apply_filter_tag),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
