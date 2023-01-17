import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/bloc/authentication/logout_bloc.dart';
import 'package:projectunity/bloc/authentication/logout_event.dart';
import 'package:projectunity/bloc/authentication/logout_state.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/widget/user_intro_content.dart';
import '../../../configs/colors.dart';
import '../../../router/app_router.dart';
import '../../../widget/error_snack_bar.dart';
import '../../../widget/setting_screen_subtitle.dart';
import 'bloc/employee_setting_bloc.dart';
import 'bloc/employee_setting_state.dart';

class EmployeeSettingPage extends StatelessWidget {
  const EmployeeSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => getIt<LogOutBloc>()),
      BlocProvider(create: (_) => getIt<EmployeeSettingBloc>()),
    ],
    child: const EmployeeSettingView(),);
  }
}

class EmployeeSettingView extends StatefulWidget {
  const EmployeeSettingView({Key? key}) : super(key: key);

  @override
  State<EmployeeSettingView> createState() => _EmployeeSettingViewState();
}

class _EmployeeSettingViewState extends State<EmployeeSettingView> {
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
      body: BlocListener<LogOutBloc,LogOutState>(
        listener: (context, state) {
          if(state is LogOutFailureState){
            showSnackBar(context: context,error: state.error);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(primaryHorizontalSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(localizations.settings_setting_text,
                  style: AppTextStyle.largeHeaderBold),
              buildSettingSubTitle(
                  subtitle: localizations.settings_account_text),
              BlocBuilder<EmployeeSettingBloc,EmployeeSettingState>(builder: (context, state) => UserIntroContent(employee: state.employee,onTap: () {
                context.goNamed(Routes.employeeEditEmployeeDetails,extra: state.employee);
              },)),
              const Spacer(),
              Center(
                child: BlocBuilder<LogOutBloc, LogOutState>(
                    builder: (context, state) => state is LogOutLoadingState
                        ? const CircularProgressIndicator()
                        : const LogOutButton()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.redColor,
      ),
      onPressed: () {
        context.read<LogOutBloc>().add(LogOutEvent());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45.0),
        child: Text(AppLocalizations.of(context).logout_button_text),
      ),
    );
  }
}
