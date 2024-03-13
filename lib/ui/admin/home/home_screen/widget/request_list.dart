import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../data/core/utils/date_formatter.dart';
import '../../../../../data/model/leave_application.dart';
import '../../../../../style/app_text_style.dart';
import '../../../../../app_router.dart';
import '../../../../widget/leave_application_card.dart';

class LeaveRequestList extends StatelessWidget {
  const LeaveRequestList({
    super.key,
    required this.map,
  });

  final Map<DateTime, List<LeaveApplication>> map;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: map.entries
          .map(
            (mapEntry) => StickyHeader(
                header: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: primaryHorizontalSpacing),
                    padding: const EdgeInsets.symmetric(
                            horizontal: primaryHorizontalSpacing)
                        .copyWith(top: primaryHalfSpacing),
                    decoration:
                        BoxDecoration(color: context.colorScheme.surface),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                DateFormatter(context.l10n)
                                    .getDateRepresentation(mapEntry.key),
                                style: AppTextStyle.style20.copyWith(
                                  color: context.colorScheme.textPrimary,
                                )),
                            Text(
                              mapEntry.value.length.toString(),
                              style: AppTextStyle.style20,
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    )),
                content: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: primaryVerticalSpacing),
                  child: Column(
                    children: mapEntry.value
                        .map((leaveApplication) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: primaryHorizontalSpacing,
                                  vertical: primaryHalfSpacing),
                              child: LeaveApplicationCard(
                                  onTap: () => context.goNamed(
                                      Routes.leaveRequestDetail,
                                      extra: leaveApplication),
                                  leaveApplication: leaveApplication),
                            ))
                        .toList(),
                  ),
                )),
          )
          .toList(),
    );
  }
}
