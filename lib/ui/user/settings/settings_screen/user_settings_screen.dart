import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/ui/user/settings/settings_screen/widget/user_settings_settings_options.dart';
import 'package:projectunity/ui/user/settings/settings_screen/widget/user_settings_user_profile.dart';
import 'package:projectunity/ui/widget/app_dialog.dart';
import '../../../../data/configs/colors.dart';
import '../../../../data/configs/space_constant.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/di/service_locator.dart';
import '../../../space/change_space_sheet/change_space_sheet.dart';
import '../../../widget/error_snack_bar.dart';
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
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).settings_tag),
      ),
      body: BlocConsumer<UserSettingsBloc, UserSettingsState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == Status.error) {
            showSnackBar(context: context, error: state.error);
          }
        },
        builder: (context, state) => ListView(
          padding: const EdgeInsets.all(primaryHorizontalSpacing),
          children: [
            UserProfile(
              employee: state.currentEmployee,
              onTap: () {
                // context.goNamed(Routes.userEditProfile,
                //     extra: state.currentEmployee);
              },
            ),
            const Divider(),
            SettingOption(
                icon: Icons.swap_vert_rounded,
                title: AppLocalizations.of(context).change_space_tag,
                onTap: () {
                  showBottomSheet(
                      context: context,
                      builder: (context) => const ChangeSpaceBottomSheet());
                }),
            const Divider(),
            SettingOption(
                icon: Icons.logout_rounded,
                title: AppLocalizations.of(context).sign_out_tag,
                onTap: () {
                  showAlertDialog(
                    actionButtonTitle:
                        AppLocalizations.of(context).sign_out_tag,
                    onActionButtonPressed: () {
                      context
                          .read<UserSettingsBloc>()
                          .add(UserSettingsLogOutEvent());
                    },
                    context: context,
                    title: AppLocalizations.of(context).sign_out_tag,
                    description: AppLocalizations.of(context).sign_out_alert,
                  );
                })
          ],
        ),
      ),
      backgroundColor: AppColors.whiteColor,
    );
  }
}
