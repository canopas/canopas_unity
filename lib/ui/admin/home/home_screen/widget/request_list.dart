import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../../../../configs/space_constant.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../core/utils/date_formatter.dart';
import '../../../../../navigation/app_router.dart';
import '../../../../../widget/leave_application_card.dart';

class LeaveRequestList extends StatelessWidget {
  const LeaveRequestList({
    Key? key,
    required this.map,
  }) : super(key: key);

  final Map<DateTime, List<LeaveApplication>> map;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: map.entries
          .map(
            (mapEntry) => StickyHeader(
                header: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                            horizontal: primaryHorizontalSpacing)
                        .copyWith(top: primaryHalfSpacing),
                    decoration: const BoxDecoration(
                      color: AppColors.whiteColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                DateFormatter(AppLocalizations.of(context))
                                    .getDateRepresentation(mapEntry.key),
                                style: AppFontStyle.headerGrey),
                            Text(
                              mapEntry.value.length.toString(),
                              style: AppFontStyle.headerGrey,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: primaryHalfSpacing,
                        ),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: AppColors.dividerColor,
                        )
                      ],
                    )),
                content: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: primaryVerticalSpacing),
                  child: Column(
                    children: mapEntry.value
                        .map((leaveApplication) => LeaveApplicationCard(
                            onTap: () => context.goNamed(
                                Routes.leaveApplicationDetail,
                                extra: leaveApplication),
                            leaveApplication: leaveApplication))
                        .toList(),
                  ),
                )),
          )
          .toList(),
    );
  }
}
