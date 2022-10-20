import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/ui/admin/setting/widget/setting_option.dart';
import '../../../bloc/authentication/logout_bloc.dart';
import '../../../di/service_locator.dart';
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
  final _logOutBloc = getIt<LogOutBloc>();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
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
            Text(localizations.settings_setting_text,
                style: AppTextStyle.largeHeaderBold),
            buildSettingSubTitle(
                subtitle: localizations.settings_account_text),
            UserIntroContent(),
            buildSettingSubTitle(
                subtitle: localizations.settings_setting_text),
                      SettingOption(
                        icon: Icons.edit_note,
                        title: localizations.admin_total_leave_count_text,
                        onTap: () {
                          _stateManager.push(const NavStackItem.paidLeaveSettingsState());
              },
                      ),
                    StreamBuilder<ApiResponse<bool>>(
                        initialData: const ApiResponse.idle(),
                        stream: _logOutBloc.signOutResponse,
                        builder: (context, snapshot) {
                          return snapshot.data!.when(
                              idle: () => _signOutButton(),
                              loading: () =>const Center(child: CircularProgressIndicator()),
                              completed: (data) => _signOutButton(),
                              error: (error){
                                showSnackBar(
                          context: context,
                          error: localizations.sign_out_failed_message);
                      return _signOutButton();
                    }
                          );
                        } ,
                    ),
          ]),
        ));
  }
  _signOutButton(){
    return SettingOption(
      icon: Icons.logout_rounded,
      title: AppLocalizations.of(context).logout_button_text,
              onTap: () async {
                await _logOutBloc.signOutFromApp();
      },
      iconColor: AppColors.redColor,
      titleColor: AppColors.redColor,
    );
  }
}
