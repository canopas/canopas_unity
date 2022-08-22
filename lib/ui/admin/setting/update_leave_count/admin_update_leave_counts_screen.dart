import 'package:flutter/material.dart';
import 'package:projectunity/bloc/admin/leave_count/all_leave_count.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/widget/error_snackbar.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../configs/font_size.dart';
import '../../../../di/service_locator.dart';

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
            style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor),
          ),
          const SizedBox(
            height: 5,
          ),
           Text(
            _localizations.admin_total_yearly_paid_leave_text,
            style: const TextStyle(
                color: AppColors.greyColor,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            onChanged: (val){setState(() {});},
            keyboardType: TextInputType.number,
            controller: _allLeaveCountController,
            cursorColor: Colors.black,
            style: const TextStyle(
                fontSize: subTitleTextSize, color: AppColors.darkText),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintStyle: const TextStyle(
                  fontSize: subTitleTextSize, color: AppColors.secondaryText),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: "Total Leaves",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: AppColors.primaryBlue,
                fixedSize: Size(MediaQuery.of(context).size.width, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                )
              ),
              onPressed: (_allLeaveCountController.text.isNotEmpty)
                  ? _onUpdateLeaveCount
                  : null,
              child: Text(_localizations.update_button_text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),)),
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
        showSnackBar(context, res);
      }
    } catch (e){
      showSnackBar(context, AppLocalizations.of(context).something_went_wrong_text);
    }
  }
}
