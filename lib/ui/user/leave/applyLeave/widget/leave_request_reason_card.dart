import 'package:flutter/material.dart';
import 'package:projectunity/exception/exception_msg.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../../configs/colors.dart';
import '../../../../../configs/font_size.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../configs/theme.dart';
import '../../../../../core/utils/const/space_constant.dart';

class LeaveRequestReasonCard extends StatelessWidget {
  final Stream<String> reason;
  final void Function(String)? onChanged;

  const LeaveRequestReasonCard({Key? key, required this.reason, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: primaryHalfSpacing,horizontal: primarySpacing),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppTheme.commonBorderRadius,
          boxShadow: AppTheme.commonBoxShadow
      ),
      padding: const EdgeInsets.all(primaryHorizontalSpacing).copyWith(top:0,bottom: primaryVerticalSpacing),
      child: StreamBuilder<String>(
          stream: reason,
          builder: (context, snapshot) {
            return TextField(
              style: AppTextStyle.bodyTextDark,
              cursorColor: AppColors.secondaryText,
              maxLines: 5,
              decoration: InputDecoration(
                errorText: snapshot.hasError
                    ? snapshot.error.toString().errorMessage(context)
                    : null,
                border: InputBorder.none,
                hintText: AppLocalizations.of(context).leave_reason_text_field_tag,
                hintStyle: AppTextStyle.leaveRequestFormSubtitle,
              ),
              onChanged: onChanged,
              keyboardType: TextInputType.text,
            );
          }),
    );
  }
}