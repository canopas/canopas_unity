import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../data/configs/colors.dart';
import '../../../data/configs/space_constant.dart';
import '../../../data/configs/text_style.dart';
import '../../../data/di/service_locator.dart';
import '../../navigation/app_router.dart';
import '../../user/settings/settings_screen/widget/user_settings_settings_options.dart';
import '../../user/settings/settings_screen/widget/user_settings_user_profile.dart';
import '../../widget/error_snack_bar.dart';
import 'bloc/admin_settings_bloc.dart';
import 'bloc/admin_settings_event.dart';
import 'bloc/admin_settings_state.dart';

class AdminSettingPage extends StatelessWidget {
  const AdminSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AdminSettingsBloc>(),
      child: const AdminSettingScreen(),
    );
  }
}

class AdminSettingScreen extends StatefulWidget {
  const AdminSettingScreen({Key? key}) : super(key: key);

  @override
  State<AdminSettingScreen> createState() => _AdminSettingScreenState();
}

class _AdminSettingScreenState extends State<AdminSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).settings_tag),
      ),
      body: BlocConsumer<AdminSettingsBloc, AdminSettingsState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == AdminSettingsStatus.failure) {
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
              child: Text(AppLocalizations.of(context).settings_tag,
                  style: AppFontStyle.titleDark),
            ),
            const Divider(
                color: AppColors.dividerColor, height: 1, thickness: 1),
            const SizedBox(height: primaryVerticalSpacing),
            SettingOption(
              icon: Icons.edit_note,
              title: AppLocalizations.of(context)
                  .admin_settings_update_total_leave_count_tag,
              onTap: () => context.pushNamed(Routes.updateLeaveCount),
            ),
            SettingOption(
                icon: Icons.logout_rounded,
                title: AppLocalizations.of(context).sign_out_tag,
                onTap: () {
                  context
                      .read<AdminSettingsBloc>()
                      .add(AdminSettingsLogOutEvent());
                }),
          ],
        ),
      ),
      backgroundColor: AppColors.whiteColor,
    );
  }
}
