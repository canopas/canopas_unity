import 'package:flutter/material.dart';
import '../../configs/text_style.dart';
import '../../core/utils/const/other_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class ReasonField extends StatelessWidget {
  const ReasonField({Key? key, required this.reason}) : super(key: key);
  final String reason;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.all(primaryHorizontalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context).leave_reason_tag, style: AppTextStyle.secondarySubtitle500,),
          const SizedBox(height: 10,),
          Text(reason, style: AppTextStyle.subtitleTextDark,)
        ],
      ),
    );
  }
}

