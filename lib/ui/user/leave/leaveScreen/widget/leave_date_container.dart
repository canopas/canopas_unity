import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../../../../configs/colors.dart';
import '../../../../../core/utils/date_formatter.dart';

class BuildLeaveDateContainer extends StatelessWidget {
  const BuildLeaveDateContainer(
      {Key? key,
      required this.startDate,
      required this.endDate,
      required this.color})
      : super(key: key);

  final int startDate;
  final int endDate;
  final Color color;

  @override
  Widget build(BuildContext context) {
    String duration = DateFormatter(AppLocalizations.of(context))
        .dateDoubleLine(startDate: startDate, endDate: endDate);

    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10), bottomRight: Radius.circular(10))),
      height: 150,
      width: 60,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
            child: Text(
          duration,
          style: TextStyle(
              color: color == AppColors.blackColor
                  ? AppColors.whiteColor
                  : AppColors.darkText,
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
