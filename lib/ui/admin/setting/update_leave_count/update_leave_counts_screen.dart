import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/bloc/admin/leave_count/all_leave_count.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/utils/const/other_constant.dart';
import 'package:projectunity/widget/error_snackbar.dart';

import '../../../../configs/font_size.dart';
import '../../../../di/service_locator.dart';
import '../../../../exception/error_const.dart';

class AdminUpdateLeaveCountsScreen extends StatefulWidget {
  const AdminUpdateLeaveCountsScreen({Key? key}) : super(key: key);

  @override
  State<AdminUpdateLeaveCountsScreen> createState() =>
      _AdminUpdateLeaveCountsScreenState();
}

class _AdminUpdateLeaveCountsScreenState
    extends State<AdminUpdateLeaveCountsScreen> {
  final _adminLeaveCount = getIt<AdminLeaveCount>();
  final TextEditingController _allLeaveCountController =
      TextEditingController();

  @override
  void initState() {
    _allLeaveCountController.text = _adminLeaveCount.totalLeaveCount.value.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        foregroundColor: AppColors.blackColor,
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(30),
        children: [
           Text(
            _localizations.settings_setting_text,
            style: AppTextStyle.largeHeaderBold,
          ),
          const SizedBox(
            height: primaryVerticalSpacing,
          ),
           Text(
            _localizations.admin_total_yearly_paid_leave_text,
            style: AppTextStyle.settingSubTitle.copyWith(fontSize: subTitleTextSize),
          ),
          const SizedBox(
            height: primaryHorizontalSpacing,
          ),
          TextField(
            onChanged: (val){setState(() {});},
            keyboardType: TextInputType.number,
            controller: _allLeaveCountController,
            cursorColor: Colors.black,
            style: AppTextStyle.subtitleTextDark,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintStyle: AppTextStyle.secondarySubtitle500,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: "Total Leaves",
            ),
          ),
          const SizedBox(
            height: primaryHorizontalSpacing,
          ),
          ElevatedButton(
              onPressed: (_allLeaveCountController.text.isNotEmpty)
                  ? _onUpdateLeaveCount
                  : null,
              child: Text(_localizations.update_button_text, style: AppTextStyle.subtitleText,)),
        ],
      ),
      backgroundColor: AppColors.whiteColor,
      resizeToAvoidBottomInset: false,
    );
  }

  _onUpdateLeaveCount() async {
    try{
      int.parse(_allLeaveCountController.text);
      String res = await _adminLeaveCount.updateLeaveCount(
          context: context, leaveCount: _allLeaveCountController.text);
      _allLeaveCountController.text =
          _adminLeaveCount.totalLeaveCount.value.toString();
      if (res.isNotEmpty) {
        showSnackBar(context: context, msg: res);
      }
    } catch (e){
      showSnackBar(context: context, error: undefinedError);
    }
  }
}
