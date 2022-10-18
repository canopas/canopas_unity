import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/extensions/list.dart';
import 'package:projectunity/core/utils/const/leave_screen_type_map.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/ui/user/leave/leaveScreen/widget/leave_card.dart';

import '../../../../bloc/employee/leave/user_leave_bloc.dart';
import '../../../../configs/colors.dart';
import '../../../../core/utils/const/leave_map.dart';
import '../../../../model/leave/leave.dart';
import '../../../../rest/api_response.dart';
import '../../../../widget/circular_progress_indicator.dart';
import '../../../../widget/date_time_picker.dart';
import '../../../../widget/empty_screen.dart';
import '../../../../widget/error_snackbar.dart';

class LeaveScreen extends StatefulWidget {
  final int leaveScreenType;

  const LeaveScreen({Key? key, required this.leaveScreenType})
      : super(key: key);

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  final _userLeavesBLoc = getIt<UserLeavesBloc>();

  @override
  void initState() {
    _userLeavesBLoc.attach();
    _userLeavesBLoc.getUserLeaves(leaveScreenType: widget.leaveScreenType);
    super.initState();
  }

  @override
  void dispose() {
    _userLeavesBLoc.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
            localization.leave_screen_header_placeholder_leave_screen_type(
                widget.leaveScreenType)),
      ),
      body: StreamBuilder<ApiResponse<List<Leave>>>(
          stream: _userLeavesBLoc.leaveList,
          initialData: const ApiResponse.idle(),
          builder: (context, snapshot) {
            return snapshot.data!.when(
                idle: () => Container(),
                loading: () => const kCircularProgressIndicator(),
                completed: (List<Leave> leaves) {
                  if (leaves.isEmpty) {
                    return EmptyScreen(
                      message: _userLeavesBLoc.filterApplied
                          ? localization.empty_filter_screen_message
                          : localization.empty_leave_screen_message(
                              widget.leaveScreenType),
                      title: _userLeavesBLoc.filterApplied
                          ? localization.empty_filter_screen_title
                          : localization
                              .empty_leave_screen_title(widget.leaveScreenType),
                      actionButtonTitle:
                          localization.apply_for_leave_button_text,
                      onActionButtonTap:
                          _userLeavesBLoc.onApplyForLeaveButtonTap,
                      showActionButton: !_userLeavesBLoc.filterApplied,
                    );
                  } else {
                    return ListView.separated(
                      itemCount: leaves.length,
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, right: 16),
                      itemBuilder: (BuildContext context, int index) {
                        leaves.sortedByDate();
                        Leave leave = leaves[index];
                        return LeaveCard(
                          leave: leave,
                        );
                      },
                      separatorBuilder: (BuildContext context,
                          int index) => const SizedBox(height: 10),);
                  }
                },
                error: (String error) {
                  return showSnackBar(context: context, error: error);
                });
          }),
      floatingActionButton: (widget.leaveScreenType == allLeaves)
          ? FloatingActionButton.extended(
          onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  context: context,
                  builder: (context) => _filterBottomSheet(context),
                );
              },
              label: Text(localization.user_filters_tag),
              icon: const Icon(Icons.filter_list_rounded))
          : null,
    );
  }


  Widget _filterBottomSheet(BuildContext context,) {
    final localization = AppLocalizations.of(context);
    return StatefulBuilder(builder: (context, setModelsState) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(primaryHorizontalSpacing),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterTitle(text: localization.leave_type_tag),
            StreamBuilder<List<int>>(
                initialData: const [],
                stream: _userLeavesBLoc.filterByLeaveType,
                builder: (context, snapshot) {
                  return Wrap(
                    children: leaveTypeMap.entries
                        .map((e) => Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: FilterButton(
                                onPressed: () {
                                  _userLeavesBLoc.changeLeaveTypeFilter(
                                          e.key);
                                    },
                                    text: localization
                                        .leave_type_placeholder_leave_status(
                                        e.key),
                                    isSelected:
                                    snapshot.data?.contains(e.key) ?? false)))
                            .toList(),
                      );
                    }
                ),
                FilterTitle(text: localization.leave_status_tag),
                StreamBuilder<List<int>>(
                    initialData: const [],
                    stream: _userLeavesBLoc.filterByLeaveStatus,
                    builder: (context, snapshot) {
                      return Row(
                        children: leaveStatusMap.entries.map((e) =>
                            Expanded(child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6),
                                child: FilterButton(
                                  onPressed: () {
                                    _userLeavesBLoc
                                        .changeLeaveStatusFilter(e.key);
                                  },
                                  text: localization
                                      .leave_status_placeholder_text(e.key),
                                  isSelected:
                                      snapshot.data?.contains(e.key) ?? false,
                                ))))
                        .toList(),
                  );
                }),
            FilterTitle(text: localization.user_leave_filter_date_range_tag),
            StreamBuilder<DateTime?>(
                initialData: null,
                stream: _userLeavesBLoc.filterStartTime,
                builder: (context, snapshot) {
                  return ListTile(
                    onTap: () async {
                      DateTime? startTime = await pickDate(
                          context: context,
                          initialDate: snapshot.data ?? DateTime.now());
                      _userLeavesBLoc.changeStartTimeFilter(startTime);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    title: Text(
                      localization.user_apply_leave_from_tag,
                      style: AppTextStyle.subtitleTextDark,
                    ),
                    trailing: Text(
                      (snapshot.data == null)
                          ? localization.user_apply_leave_select_tag
                          : localization.date_format_yMMMd(snapshot.data!),
                      style: AppTextStyle.subtitleTextDark,
                    ),
                  );
                    }
                  ),
                  StreamBuilder<DateTime?>(
                    initialData: null,
                    stream: _userLeavesBLoc.filterEndTime,
                    builder: (context, snapshot) {
                      return ListTile(
                        onTap: () async {
                          DateTime? endTime = await pickDate(
                          context: context,
                          initialDate: snapshot.data ?? DateTime.now());
                      _userLeavesBLoc.changeEndTimeFilter(endTime);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    title: Text(
                      localization.user_apply_leave_to_tag,
                      style: AppTextStyle.subtitleTextDark,
                    ),
                    trailing: Text(
                      (snapshot.data == null)
                          ? localization.user_apply_leave_select_tag
                          : localization.date_format_yMMMd(snapshot.data!),
                      style: AppTextStyle.subtitleTextDark,
                    ),
                  );
                    }
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(child: OutlinedButton(
                        onPressed: () {
                    _userLeavesBLoc.removeFilters();
                    Navigator.pop(context);
                  },
                  child: Text(localization.user_leave_filter_remove_filter_tag),
                )),
                      const SizedBox(width: primaryHorizontalSpacing,),
                      Expanded(child: ElevatedButton(
                        onPressed: () {
                    _userLeavesBLoc.applyFilter();
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
    );
  }
}

class FilterButton extends StatelessWidget {
  final bool isSelected;
  final void Function()? onPressed;
  final String text;
  const FilterButton({Key? key, required this.isSelected, required this.onPressed, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            fixedSize: const Size.fromHeight(35),
            foregroundColor: (isSelected)?AppColors.primaryBlue:AppColors.secondaryText,
            side: BorderSide(color: (isSelected)?AppColors.primaryBlue:AppColors.secondaryText, width: 1)),
        onPressed: onPressed,
        child: Text(text));
  }
}

class FilterTitle extends StatelessWidget {
  final String text;
  const FilterTitle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: primaryVerticalSpacing,top: primaryHorizontalSpacing),
        child: Text(text,style: AppTextStyle.titleBlack600, textAlign: TextAlign.left,));
  }
}

