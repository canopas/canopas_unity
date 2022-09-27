import 'package:flutter/material.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/error_snackbar.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../../../../configs/text_style.dart';
import '../../../../core/utils/const/other_constant.dart';
import '../../../../core/utils/date_string_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../exception/error_const.dart';
import '../leaveRequestCard/leave_request_card.dart';

class AdminLeaveRequestsList extends StatefulWidget {
  Stream<ApiResponse<Map<DateTime, List<LeaveApplication>>>> leaveApplicationStream;

  AdminLeaveRequestsList({Key? key, required this.leaveApplicationStream}) : super(key: key);

  @override
  State<AdminLeaveRequestsList> createState() => _AdminLeaveRequestsListState();
}

class _AdminLeaveRequestsListState extends State<AdminLeaveRequestsList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse<Map<DateTime, List<LeaveApplication>>>>(
        initialData: const ApiResponse.idle(),
        stream: widget.leaveApplicationStream,
        builder: (context, snapshot) {
          return snapshot.data!.when(
              idle: () => Container(),
              loading: () => const Expanded(child: kCircularProgressIndicator()),
              completed: (Map<DateTime, List<LeaveApplication>> leaveApplicationMap) {
                return Expanded(
                    child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(primaryHorizontalSpacing).copyWith(top: 0),
                  children: leaveApplicationMap.entries.map((mapEntry) => StickyHeader(
                            header: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    boxShadow: [BoxShadow(
                                        color: AppColors.whiteColor.withOpacity(0.50),
                                        blurRadius: 3,
                                        spreadRadius: 1,
                                        offset: const Offset(0, 2),
                                      )]),
                                padding: const EdgeInsets.only(top: primaryHorizontalSpacing, bottom: primaryVerticalSpacing,),
                                child: Text(dateToDayMonth(date: mapEntry.key, locale: AppLocalizations.of(context).localeName), style: AppTextStyle.settingSubTitle)),
                            content: Column(
                              children: mapEntry.value.map((leaveApplication) => LeaveRequestCard(leaveApplication: leaveApplication)).toList(),
                            )),
                  ).toList(),
                ));
              },
              error: (String error) {
                return showSnackBar(context: context, error: firestoreFetchDataError);
              });
        });
  }
}
