import 'package:flutter/material.dart';
import 'package:projectunity/configs/text_style.dart';
import '../../../../../configs/colors.dart';
import '../../../../../core/utils/const/space_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class TotalDaysMsgBox extends StatelessWidget {
  final Stream<double> totalLeaves;
  const TotalDaysMsgBox({Key? key, required this.totalLeaves}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
        initialData: 0.0,
        stream: totalLeaves,
        builder: (context, snapshot) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: primaryHalfSpacing, horizontal: primarySpacing),
            height: MediaQuery.of(context).size.height*0.08,
            width:  MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(AppLocalizations.of(context).leave_request_total_days_text(snapshot.data!),style: AppTextStyle.subtitleText.copyWith(color: AppColors.primaryBlue),),
          );
        }
    );
  }
}