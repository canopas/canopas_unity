import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:projectunity/core/utils/const/other_constant.dart';
import 'package:provider/provider.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../stateManager/user/leave_request_data_manager.dart';

class ReasonCard extends StatelessWidget {
  ReasonCard({Key? key}) : super(key: key);
  final TextEditingController _textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: primaryHorizontalSpacing),
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        focusNode: focusNode,
        style: const TextStyle(
            color: AppColors.darkText, fontSize: bodyTextSize),
        cursorColor: AppColors.secondaryText,
        maxLines: 5,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: AppLocalizations.of(context).leave_reason_tag,
          hintStyle:  AppTextStyle.leaveRequestFormSubtitle,
        ),
        validator: (String? value) {
              if (value == null || value == '') {
                return AppLocalizations.of(context)
                .user_apply_leave_error_valid_reason;
          }
              Provider.of<LeaveRequestDataManager>(context, listen: false)
              .setReasonOfLeave(value);
              return null;
            },
            controller: _textEditingController,
            keyboardType: TextInputType.text,
      ),
    ));
  }
}

