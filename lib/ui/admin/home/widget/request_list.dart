import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/widget/empty_screen.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../../../../configs/text_style.dart';
import '../../../../core/utils/const/space_constant.dart';
import '../../../../core/utils/date_formatter.dart';
import 'requests/leave_content.dart';


class LeaveRequestList extends StatelessWidget {
  const LeaveRequestList({
    Key? key,
    required this.map,
  }) : super(key: key);

  final Map<DateTime, List<LeaveApplication>> map;

  @override
  Widget build(BuildContext context) {
    return map.isNotEmpty? ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
          bottom: primaryVerticalSpacing),
      children: map.entries
          .map(
            (mapEntry) =>
            StickyHeader(
                header: Container(
                    width:
                    MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.whiteColor
                                .withOpacity(0.50),
                            blurRadius: 3,
                            spreadRadius: 1,
                            offset: const Offset(0, 2),
                          )
                        ]),
                    padding: const EdgeInsets.all(
                        primaryHorizontalSpacing)
                        .copyWith(
                        bottom: primaryVerticalSpacing),
                    child: Text(
                        DateFormatter(
                            AppLocalizations.of(context))
                            .getDateRepresentation(
                            mapEntry.key),
                        style: AppTextStyle.settingSubTitle)),
                content: Column(
                  children: mapEntry.value
                      .map((leaveApplication) =>
                      LeaveRequestCard(
                          leaveApplication: leaveApplication))
                      .toList(),
                )),
      ).toList(),
    ):EmptyScreen(message: AppLocalizations
        .of(context)
        .admin_home_empty_leave_request_message,
      title: AppLocalizations
          .of(context)
          .no_request_title,);
  }
}


