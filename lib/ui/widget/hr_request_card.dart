import 'package:flutter/material.dart';
import '../../data/configs/colors.dart';
import '../../data/configs/text_style.dart';
import '../../data/configs/theme.dart';
import '../../data/core/utils/date_formatter.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../data/model/hr_request/hr_request.dart';

class HrServiceDeskRequestCard extends StatelessWidget {
  final void Function()? onTap;
  final HrRequest hrRequest;

  const HrServiceDeskRequestCard(
      {super.key, this.onTap, required this.hrRequest});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: AppTheme.commonBorderRadius,
        boxShadow: AppTheme.commonBoxShadow,
      ),
      child: Material(
        borderRadius: AppTheme.commonBorderRadius,
        color: AppColors.whiteColor,
        child: InkWell(
          borderRadius: AppTheme.commonBorderRadius,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HRStatusView(status: hrRequest.status),
                    Text(
                        DateFormatter(AppLocalizations.of(context))
                            .getDateRepresentation(hrRequest.requestedAt),
                        style: AppFontStyle.bodyMedium,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
                const Divider(height: 32),
                Text(
                    AppLocalizations.of(context)
                        .hr_request_types(hrRequest.type.value.toString()),
                    style: AppFontStyle.titleDark),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HRStatusView extends StatelessWidget {
  final double verticalPadding;
  final double horizontalPadding;
  final HrRequestStatus status;

  const HRStatusView(
      {Key? key,
      required this.status,
      this.verticalPadding = 4,
      this.horizontalPadding = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: hrRequestStatusColor(status),
      ),
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      child: Row(
        children: [
          HrRequestStatusIcon(status: status),
          const SizedBox(width: 5),
          Text(
            AppLocalizations.of(context).hr_request_status(status.value.toString()),
            style: AppFontStyle.labelRegular,
          ),
        ],
      ),
    );
  }
}

Color hrRequestStatusColor(HrRequestStatus status) {
  if (status == HrRequestStatus.resolved) {
    return const Color(0xffB6F5D4);
  } else if (status == HrRequestStatus.pending) {
    return const Color(0xffF5F5F5);
  }
  return const Color(0xffFFE5E1);
}

class HrRequestStatusIcon extends StatelessWidget {
  final HrRequestStatus status;

  const HrRequestStatusIcon({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == HrRequestStatus.resolved) {
      return const Icon(Icons.done_all_rounded,
          color: AppColors.greenColor, size: 20);
    } else if (status == HrRequestStatus.canceled) {
      return const Icon(Icons.clear_rounded,
          color: AppColors.redColor, size: 20);
    }
    return const Icon(Icons.query_builder,
        color: AppColors.blackColor, size: 20);
  }
}
