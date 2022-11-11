import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/core/extensions/double_extension.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../configs/theme.dart';
import '../../../../../core/utils/const/leave_map.dart';
import '../../../../../model/leave_count.dart';
import '../../../../../rest/api_response.dart';
import '../../../../../widget/circular_progress_indicator.dart';

class LeaveTypeCard extends StatelessWidget {
  final Stream<int> stream;
  final Stream<ApiResponse<LeaveCounts>> leaveCount;
  final void Function(int?, int) onChange;

  const LeaveTypeCard({Key? key, required this.stream, required this.onChange, required this.leaveCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: primaryHalfSpacing,horizontal: primarySpacing),
      padding: const EdgeInsets.all(primaryVerticalSpacing).copyWith(left: primaryHorizontalSpacing),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppTheme.commonBorderRadius,
        boxShadow: AppTheme.commonBoxShadow
      ),
      child: Material(
        color: AppColors.whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder<ApiResponse<LeaveCounts>>(
                initialData:  const ApiResponse.idle(),
                stream: leaveCount,
                builder: (context, snapshot) {
                  return snapshot.data!.when(
                    idle: () => const SizedBox(),
                    loading: () => Transform.scale(scale: 0.8,child: const kCircularProgressIndicator()),
                    completed: (data) => Text("${data.remainingLeaveCount.fixedAt(2)}/${data.paidLeaveCount}",style: AppTextStyle.subtitleGreyBold,),
                    error: (error) =>const SizedBox(),
                  );
                }
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: primaryHalfSpacing),
              child: Container(height: 50,width: 1, color: AppColors.secondaryText,),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Text(localization.leave_type_tag,
                  style: AppTextStyle.leaveRequestFormSubtitle),
            ),
            Expanded(
              flex: 12,
              child: StreamBuilder<int>(
                  stream: stream,
                  builder: (context, snapshot) {
                    int leaveType = snapshot.data ?? 0;
                    return DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        isExpanded: true,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        items: leaveTypeMap
                            .map((key, value) {
                              return MapEntry(
                                  key,
                                  DropdownMenuItem<int>(
                                    value: key,
                                    child: Row(
                                      children: [
                                        const SizedBox(width: primaryHalfSpacing,),
                                        Flexible(
                                          child: Text(localization
                                              .leave_type_placeholder_leave_status(key)),
                                        ),
                                      ],
                                    ),
                                  ));
                            })
                            .values
                            .toList(),
                        value: leaveType,
                        onChanged: (int? value) {
                          onChange(value, leaveType);
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
