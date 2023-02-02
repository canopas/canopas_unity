import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/extensions/double_extension.dart';
import 'package:projectunity/widget/user_profile_image.dart';
import '../../../../../model/employee/employee.dart';
import '../../../../../model/leave_count.dart';

class EmployeeContent extends StatelessWidget {
  final Employee employee;
  final LeaveCounts? leaveCounts;

  const EmployeeContent({Key? key, required this.employee, required this.leaveCounts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Row(
      children: [
        ImageProfile(
          borderColor: AppColors.blackColor,
          borderSize: 1,
          radius: 25,
          imageUrl: employee.imageUrl,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                employee.name,
                style: AppTextStyle.mediumDark
                    .copyWith(fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                employee.employeeId,
                style: AppTextStyle.bodyDarkGrey,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        leaveCounts!=null?Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              localization.admin_leave_detail_daysLeft_tag,
              style: AppTextStyle.mediumDark.copyWith(fontWeight: FontWeight.w500),),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${leaveCounts!.remainingLeaveCount.fixedAt(1)}/${leaveCounts!.paidLeaveCount}',
              style: AppTextStyle.bodyDarkGrey,
            ),
          ],
        ):const SizedBox(),
      ],
    );
  }
}
