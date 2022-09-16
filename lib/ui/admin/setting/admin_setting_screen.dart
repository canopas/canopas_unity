import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/utils/const/other_constant.dart';
import 'package:projectunity/ui/admin/setting/widget/setting_option.dart';

import '../../../bloc/admin/leave_count/all_leave_count.dart';
import '../../../bloc/authentication/logout_bloc.dart';
import '../../../di/service_locator.dart';
import '../../../navigation/navigationStackItem/admin/admin_navigation_stack_items.dart';
import '../../../navigation/navigation_stack_manager.dart';
import '../../../widget/error_snackbar.dart';
import '../../../widget/setting_screen_subtitle.dart';
import '../../../widget/user_intro_content.dart';

class AdminSettingScreen extends StatefulWidget {
  const AdminSettingScreen({Key? key}) : super(key: key);

  @override
  State<AdminSettingScreen> createState() => _AdminSettingScreenState();
}

class _AdminSettingScreenState extends State<AdminSettingScreen> {
  final _stateManager = getIt<NavigationStackManager>();
  final _adminLeaveCount = getIt<AdminLeaveCount>();
  final _logOutBloc = getIt<LogOutBloc>();

  @override
  void initState() {
    _adminLeaveCount.fetchTotalLeaveCounts();
    super.initState();
  }

  @override
  void dispose() {
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
        backgroundColor: AppColors.whiteColor,
        body: Padding(
          padding: const EdgeInsets.all(primaryHorizontalSpacing),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(_localizations.settings_setting_text,
                style: AppTextStyle.largeHeaderBold),
            buildSettingSubTitle(
                subtitle: _localizations.settings_account_text),
            UserIntroContent(),
            buildSettingSubTitle(
                subtitle: _localizations.settings_setting_text),
                      SettingOption(
                        icon: Icons.edit_note,
                        title: _localizations.admin_total_leave_count_text,
                        onTap: () {
                          _stateManager.push(const AdminNavigationStackItem
                              .updateLeaveCountsState());
                        },
                      ),
            SettingOption(
              icon: Icons.logout_rounded,
              title: _localizations.logout_button_text,
              onTap: () async {
                bool isSignOut = await _logOutBloc.signOutFromApp();
                isSignOut
                    ? showSnackBar(context, 'You have successfully logged out!')
                    : null;
              },
              iconColor: AppColors.redColor,
              titleColor: AppColors.redColor,
            ),
          ]),
        ));
  }
}
