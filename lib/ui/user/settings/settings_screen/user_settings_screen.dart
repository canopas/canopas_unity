import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/ui/user/settings/settings_screen/widget/user_settings_settings_options.dart';
import 'package:projectunity/ui/user/settings/settings_screen/widget/user_settings_user_profile.dart';
import 'package:projectunity/widget/app_app_bar.dart';
import 'package:projectunity/widget/error_snack_bar.dart';

import '../../../../configs/colors.dart';
import '../../../../configs/text_style.dart';
import '../../../../core/utils/const/space_constant.dart';
import '../../../../di/service_locator.dart';
import '../../../../router/app_router.dart';
import 'bloc/user_settings_bloc.dart';
import 'bloc/user_settings_event.dart';
import 'bloc/user_settings_state.dart';

class UserSettingsPage extends StatelessWidget {
  const UserSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UserSettingsBloc>(),
      child: const UserSettingsScreen(),
    );
  }
}

class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({Key? key}) : super(key: key);

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        onBack: () {
          context.pop();
        },
        title: AppLocalizations.of(context).settings_setting_text,
      ),
      body: BlocConsumer<UserSettingsBloc, UserSettingsState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == UserSettingsStatus.failure) {
            showSnackBar(context: context, error: state.error);
          }
        },
        builder: (context, state) => ListView(
          padding: const EdgeInsets.all(primaryHorizontalSpacing),
          children: [
            UserProfile(
              employee: state.currentEmployee,
              onTap: () {
                context.goNamed(Routes.userEditProfile,
                    extra: state.currentEmployee);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: primaryHorizontalSpacing,
                  bottom: primaryVerticalSpacing),
              child: Text(AppLocalizations.of(context).settings_account_text,
                  style: AppTextStyle.titleDark),
            ),
            const Divider(
                color: AppColors.dividerColor, height: 1, thickness: 1),
            const SizedBox(height: primaryVerticalSpacing),
            SettingOption(
                icon: Icons.logout_rounded,
                title: AppLocalizations.of(context).logout_button_text,
                onTap: () {
                  context
                      .read<UserSettingsBloc>()
                      .add(UserSettingsLogOutEvent());
                })
          ],
        ),
      ),
      backgroundColor: AppColors.whiteColor,
    );
  }
}
