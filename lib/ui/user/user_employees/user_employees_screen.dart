import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/configs/theme.dart';
import 'package:projectunity/ui/user/user_employees/bloc/user_employee_state.dart';
import 'package:projectunity/ui/user/user_employees/bloc/user_employees_bloc.dart';
import 'package:projectunity/ui/user/user_employees/bloc/user_employees_event.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/user_profile_image.dart';
import '../../../configs/colors.dart';
import '../../../core/utils/const/space_constant.dart';
import '../../../di/service_locator.dart';

class UserEmployeesPage extends StatelessWidget {
  const UserEmployeesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UserEmployeesBloc>()..add(FetchEmployeesEvent()),
      child: const UserEmployeesScreen(),
    );
  }
}

class UserEmployeesScreen extends StatefulWidget {
  const UserEmployeesScreen({Key? key}) : super(key: key);

  @override
  State<UserEmployeesScreen> createState() => _UserEmployeesScreenState();
}

class _UserEmployeesScreenState extends State<UserEmployeesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
            bottom: BorderSide(
          color: AppColors.dividerColor,
          width: 1,
        )),
        backgroundColor: AppColors.whiteColor,
        title: Text(
          AppLocalizations.of(context).employee_tag,
          style: AppTextStyle.headerDark,
        ),
      ),
      backgroundColor: AppColors.whiteColor,
      body: RefreshIndicator(
        color: AppColors.textDark,
        onRefresh: () async {
          context.read<UserEmployeesBloc>().add(FetchEmployeesEvent());
        },
        child: BlocBuilder<UserEmployeesBloc, UserEmployeesState>(
            builder: (context, state) {
          if (state is UserEmployeesLoadingState) {
            return const AppCircularProgressIndicator();
          } else if (state is UserEmployeesSuccessState) {
            return ListView.separated(
                padding: const EdgeInsets.symmetric(
                    horizontal: primaryVerticalSpacing),
                itemBuilder: (BuildContext context, int employee) => InkWell(
                      borderRadius: AppTheme.commonBorderRadius,
                      onTap: () {
                        ///TODO implement navigation to employee details screen
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: primaryVerticalSpacing,
                            vertical: primaryHalfSpacing),
                        child: Row(
                          children: [
                            ImageProfile(
                                imageUrl: state.employees[employee].imageUrl,
                                radius: 25,
                                borderColor: AppColors.textDark,
                                borderSize: 1,
                                backgroundColor: AppColors.dividerColor,
                                iconColor: AppColors.greyColor),
                            const SizedBox(
                              width: primaryHorizontalSpacing,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.employees[employee].name,
                                      style: AppTextStyle.titleDark),
                                  const SizedBox(height: 2),
                                  Text(state.employees[employee].designation,
                                      style: AppTextStyle.bodyDark),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                separatorBuilder: (context, index) => const Divider(
                    color: AppColors.dividerColor,
                    indent: primaryHorizontalSpacing,
                    endIndent: primaryHorizontalSpacing,
                    thickness: 1,
                    height: 1),
                itemCount: state.employees.length);
          }

          ///TODO implement empty employees screen.
          return const SizedBox();
        }),
      ),
    );
  }
}
