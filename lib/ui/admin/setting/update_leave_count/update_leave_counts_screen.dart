import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/core/utils/const/other_constant.dart';
import 'package:projectunity/widget/error_snackbar.dart';
import '../../../../bloc/admin/setting/total_paid_leave_count_bloc.dart';
import '../../../../configs/font_size.dart';
import '../../../../di/service_locator.dart';
import '../../../../widget/circular_progress_indicator.dart';

class AdminUpdateLeaveCountsScreen extends StatefulWidget {
  const AdminUpdateLeaveCountsScreen({Key? key}) : super(key: key);

  @override
  State<AdminUpdateLeaveCountsScreen> createState() =>
      _AdminUpdateLeaveCountsScreenState();
}

class _AdminUpdateLeaveCountsScreenState
    extends State<AdminUpdateLeaveCountsScreen> {

  final _adminLeaveCount = getIt<AdminPaidLeaveCountBloc>();
  final TextEditingController _allLeaveCountController = TextEditingController();

  @override
  void initState() {
    _adminLeaveCount.attach();
    _adminLeaveCount.totalLeaveCount.listen((response) {
      response.when(
          idle: () {},
          loading: () {},
          completed: (data) {
            _allLeaveCountController.text = data.toString();
          },
          error: (error) {
              showSnackBar(context: context, error: error);
          });
    });
    super.initState();
  }

  @override
  void dispose() {
    _adminLeaveCount.detach();
    super.dispose();
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
            onChanged: (val){
              _adminLeaveCount.changeButtonState(val);
            },
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            controller: _allLeaveCountController,
            cursorColor: Colors.black,
            style: AppTextStyle.subtitleTextDark,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintStyle: AppTextStyle.secondarySubtitle500,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: _localizations.total_paid_leaves,
            ),
          ),
          const SizedBox(
            height: primaryHorizontalSpacing,
          ),
          StreamBuilder<ApiResponse<int>>(
              stream: _adminLeaveCount.totalLeaveCount,
              initialData: const ApiResponse.idle(),
              builder: (context, snapshot) => snapshot.data!.when(
                    idle: () => _updateButton(),
                    loading: () => const kCircularProgressIndicator(),
                    completed: (data) => _updateButton(),
                    error: (error) => _updateButton(),
                  )),
        ],
      ),
      backgroundColor: AppColors.whiteColor,
    );
  }

  Widget _updateButton() {
    return StreamBuilder<bool>(
      initialData: false,
      stream: _adminLeaveCount.isEnable,
      builder: (context, snapshot) {
        return ElevatedButton(
            onPressed: (snapshot.data!)
                ? () async {
                    int _leaveCount = int.parse(_allLeaveCountController.text);
                    await _adminLeaveCount.updateLeaveCount(leaveCount: _leaveCount);
                  }
                : null,
            child: Text(
              AppLocalizations.of(context).update_button_text,
              style: AppTextStyle.subtitleText,
            ));
      }
    );
  }
}
