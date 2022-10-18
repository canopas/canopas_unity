import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/widget/error_snackbar.dart';
import 'package:projectunity/widget/user_intro_content.dart';

import '../../../bloc/authentication/logout_bloc.dart';
import '../../../configs/colors.dart';
import '../../../di/service_locator.dart';
import '../../../widget/setting_screen_subtitle.dart';

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
    _logOutBloc.signOutResponse.listen((event) {
      event.whenOrNull(error: (error) {
        showSnackBar(context: context, error: error);
      });
    });
  }

  @override
  void dispose() {
    _logOutBloc.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        foregroundColor: AppColors.blackColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(primaryHorizontalSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(localizations.settings_setting_text,
                style: AppTextStyle.largeHeaderBold),
            buildSettingSubTitle(subtitle: localizations.settings_account_text),
            UserIntroContent(),
            Expanded(child: Container()),
            Center(
                child: StreamBuilder<ApiResponse<bool>>(
              stream: _logOutBloc.signOutResponse,
              initialData: const ApiResponse.idle(),
              builder: (context, snapshot) => snapshot.data!.maybeWhen(
                  loading: () => const CircularProgressIndicator(),
                  orElse: () => _signOutButton()),
            )),
          ],
        ),
      ),
    );
  }

  Widget _signOutButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.redColor,
      ),
      onPressed: () async {
        await _logOutBloc.signOutFromApp();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45.0),
        child: Text(AppLocalizations.of(context).logout_button_text),
      ),
    );
  }
}
