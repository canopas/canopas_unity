import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/ui/widget/widget_validation.dart';
import '../../../../data/configs/colors.dart';
import '../../../../data/configs/space_constant.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/di/service_locator.dart';
import '../../../navigation/app_router.dart';
import '../../../space/change_space_sheet/change_space_sheet.dart';
import '../../../user/settings/settings_screen/widget/user_settings_settings_options.dart';
import '../../../user/settings/settings_screen/widget/user_settings_user_profile.dart';
import '../../../widget/app_dialog.dart';
import '../../../widget/error_snack_bar.dart';
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

  final userManager = getIt<UserManager>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).settings_tag),
      ),
      body: BlocConsumer<AdminSettingsBloc, AdminSettingsState>(
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
                context.goNamed(Routes.adminEditProfile,
                    extra: state.currentEmployee);
              },
            ),
            const Divider(),
            SettingOption(
              iconColor: Colors.black87,
              icon: Icons.home_work_outlined,
              title: AppLocalizations.of(context).space_tag,
              onTap: () => context.pushNamed(Routes.editWorkspaceDetails),
            ),
            SettingOption(
                icon: Icons.swap_vert_rounded,
                title: AppLocalizations.of(context).change_space_tag,
                onTap: () {
                  showBottomSheet(
                      context: context,
                      builder: (context) => const ChangeSpaceBottomSheet());
                }),
            ValidateWidget(isValid: userManager.isHR,child: const Divider()),
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
                          .read<AdminSettingsBloc>()
                          .add(AdminSettingsLogOutEvent());
                    },
                    context: context,
                    title: AppLocalizations.of(context).sign_out_tag,
                    description: AppLocalizations.of(context).sign_out_alert,
                  );
                }),
          ],
        ),
      ),
      backgroundColor: AppColors.whiteColor,
    );
  }
}
