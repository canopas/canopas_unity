import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/ui/user/home/bloc/employee_home_state.dart';
import 'package:projectunity/ui/user/user_settings/bloc/user_settings_bloc.dart';
import 'package:projectunity/ui/user/user_settings/bloc/user_settings_event.dart';
import 'package:projectunity/ui/user/user_settings/bloc/user_settings_state.dart';
import 'package:projectunity/widget/app_app_bar.dart';
import 'package:projectunity/widget/error_snack_bar.dart';
import '../../../configs/colors.dart';
import '../../../configs/text_style.dart';
import '../../../configs/theme.dart';
import '../../../core/utils/const/space_constant.dart';
import '../../../di/service_locator.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../widget/user_profile_image.dart';

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
        title: AppLocalizations.of(context).settings_setting_text,
      ),
      body: BlocConsumer<UserSettingsBloc, UserSettingsState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == EmployeeHomeStatus.failure) {
            showSnackBar(context: context, error: state.error);
          }
        },
        builder: (context, state) => ListView(
          padding: const EdgeInsets.all(primaryHorizontalSpacing),
          children: [
            UserProfile(
              employee: state.currentEmployee,
              onTap: () {
                ///TODO need to implement navigation to employee details screen or employee edit screen.
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: primaryHorizontalSpacing,bottom: primaryVerticalSpacing),
              child: Text(AppLocalizations.of(context).settings_account_text, style: AppTextStyle.subTitleDark),
            ),
            const Divider(color: AppColors.dividerColor, height: 1, thickness: 1),
            const SizedBox(height: primaryVerticalSpacing),
            SettingOption(
                icon: Icons.logout_rounded,
                title: AppLocalizations.of(context).logout_button_text,
                onTap: () {context.read<UserSettingsBloc>().add(UserSettingsLogOutEvent());})
          ],
        ),
      ),
      backgroundColor: AppColors.whiteColor,
    );
  }
}

class SettingOption extends StatelessWidget {
  const SettingOption(
      {required this.icon,
      required this.title,
      required this.onTap,
      this.iconColor = AppColors.textDark,
      this.titleColor = AppColors.textDark,
      Key? key})
      : super(key: key);
  final Color titleColor;
  final Color iconColor;
  final IconData icon;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppTheme.commonBorderRadius,
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(primaryVerticalSpacing),
        decoration: BoxDecoration(
          borderRadius: AppTheme.commonBorderRadius,
          color: const Color(0xffFAFAFA),
        ),
        child: Row(
          children: [
            Icon(icon, size: 30, color: iconColor,),
            const SizedBox(width: primaryHorizontalSpacing,),
            Text(title, style: AppTextStyle.subTitleDark,),
          ],
        ),
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  final void Function()? onTap;
  final Employee employee;

  const UserProfile({Key? key, this.onTap, required this.employee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppTheme.commonBorderRadius,
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: AppTheme.commonBorderRadius,
          color: const Color(0xffFAFAFA),
        ),
        padding: const EdgeInsets.all(primaryHorizontalSpacing),
        child: Row(
          children: [
            ImageProfile(
                imageUrl: employee.imageUrl,
                radius: 25,
                borderColor: AppColors.textDark,
                borderSize: 1,
                backgroundColor: AppColors.dividerColor,
                iconColor: AppColors.greyColor),
            const SizedBox(width: primaryHorizontalSpacing,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(employee.name, style: AppTextStyle.titleDark, overflow: TextOverflow.fade,),
                  const SizedBox(height: 2),
                  Text(employee.designation, style: AppTextStyle.bodyDark),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.textDark,
            ),
          ],
        ),
      ),
    );
  }
}