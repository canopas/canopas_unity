import 'package:flutter/material.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/ui/admin/setting/widgets/settingOption.dart';
import '../../../bloc/admin/leave_count/all_leave_count.dart';
import '../../../bloc/user/setting_view_bloc.dart';
import '../../../di/service_locator.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../navigation/navigationStackItem/admin/admin_navigation_stack_items.dart';
import '../../../navigation/navigation_stack_manager.dart';
import '../../../widget/setting_screen_subtitle.dart';
import '../../../widget/user_profile_image.dart';

class AdminSettingScreen extends StatefulWidget {
  const AdminSettingScreen({Key? key}) : super(key: key);

  @override
  State<AdminSettingScreen> createState() => _AdminSettingScreenState();
}

class _AdminSettingScreenState extends State<AdminSettingScreen> {
  final _stateManager = getIt<NavigationStackManager>();
  final _adminLeaveCount = getIt<AdminLeaveCount>();
  final _userManager = getIt<UserManager>();

  @override
  void initState() {
    _adminLeaveCount.fetchTotalLeaveCounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor, elevation: 0, foregroundColor: AppColors.blackColor,
      ),
      backgroundColor: AppColors.whiteColor,
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(30),
        children: [
           Text(_localizations.settings_setting_text, style: AppTextStyle.largeHeaderBold),
          settingSubTitle(subtitle: _localizations.settings_account_text),
          Row(
            children: [
              ImageProfile(imageUrl: _userManager.userImage, radius: 35),
              const SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_userManager.userName, style: AppTextStyle.headerTextBold),
                  const SizedBox(height: 5,),
                  Text(_userManager.employeeDesignation, style: AppTextStyle.bodyTextDark,),

                ],
              ),
            ],
          ),
         settingSubTitle(subtitle: _localizations.settings_setting_text),
          SettingOption(
            icon: Icons.edit_note,
            title: _localizations.admin_total_leave_count_text,
            onTap: () {
              _stateManager.push(
                  const AdminNavigationStackItem.updateLeaveCountsState());
            },
          ),
          SettingOption(
            icon: Icons.logout_rounded,
            title: _localizations.logout_button_text,
            onTap: () async {
              getIt<SettingViewBLoc>().singOut();
            },
            iconColor: AppColors.redColor,
            titleColor: AppColors.redColor,
          ),
        ],
      ),
    );
  }
}

