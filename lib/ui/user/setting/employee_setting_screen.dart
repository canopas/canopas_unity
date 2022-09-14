import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/widget/error_snackbar.dart';
import 'package:projectunity/widget/user_intro_content.dart';

import '../../../bloc/authentication/logout_bloc.dart';
import '../../../configs/colors.dart';
import '../../../di/service_locator.dart';
import '../../../widget/setting_screen_subtitle.dart';
import '../../../widget/user_profile_image.dart';
class EmployeeSettingScreen extends StatefulWidget {
  const EmployeeSettingScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeSettingScreen> createState() => _EmployeeSettingScreenState();
}

class _EmployeeSettingScreenState extends State<EmployeeSettingScreen> {
  final _logOutBloc = getIt<LogOutBloc>();

  @override
  void initState() {
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
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        foregroundColor: AppColors.blackColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_localizations.settings_setting_text,
                style: AppTextStyle.largeHeaderBold),
            buildSettingSubTitle(
                subtitle: _localizations.settings_account_text),
            UserIntroContent(),
            Expanded(child: Container()),
            Center(child: signOutButton(onTap: () async {
              bool isSignOut = await _logOutBloc.signOutFromApp();
              isSignOut
                  ? showSnackBar(context, 'You have successfully logged out!')
                  : null;
            })),
          ],
        ),
      ),
    );
  }

  Widget signOutButton({required VoidCallback onTap}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.redColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(AppLocalizations.of(context).logout_button_text),
      ),
    );
  }
}



