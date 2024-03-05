import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/configs/space_constant.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_page.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/ui/admin/members/detail/widget/time_off_card.dart';
import 'package:projectunity/ui/widget/widget_validation.dart';
import '../../../../data/di/service_locator.dart';
import '../../../../data/model/employee/employee.dart';
import '../../../../app_router.dart';
import '../../../widget/app_dialog.dart';
import '../../../widget/circular_progress_indicator.dart';
import '../../../widget/error_snack_bar.dart';
import 'bloc/employee_detail_bloc.dart';
import 'bloc/employee_detail_event.dart';
import 'bloc/employee_detail_state.dart';
import 'widget/profile_card.dart';
import 'widget/profile_detail.dart';

class EmployeeDetailPage extends StatelessWidget {
  final String id;

  const EmployeeDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmployeeDetailBloc>(
        create: (_) => getIt<EmployeeDetailBloc>(),
        child: EmployeeDetailScreen(employeeId: id));
  }
}

class EmployeeDetailScreen extends StatefulWidget {
  final String employeeId;

  const EmployeeDetailScreen({Key? key, required this.employeeId})
      : super(key: key);

  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  @override
  void initState() {
    context.read<EmployeeDetailBloc>().add(EmployeeDetailInitialLoadEvent(employeeId: widget.employeeId));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AppPage(
        title: context.l10n.details_tag,
        actions: [
          BlocBuilder<EmployeeDetailBloc, AdminEmployeeDetailState>(
            builder: (context, state) {
              if (state is EmployeeDetailLoadedState) {
                return PopupMenuButton(
                  color: context.colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 6,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text(context.l10n.edit_tag, style: AppTextStyle.style14.copyWith(color:context.colorScheme.textSecondary ),),
                      onTap: () {
                        context.goNamed(
                          Routes.adminEditEmployee,
                          extra: state.employee,
                        );
                      },
                    ),
                    PopupMenuItem(
                      child: Text(
                        state.employee.status == EmployeeStatus.active
                            ? AppLocalizations.of(context).deactivate_tag
                            : AppLocalizations.of(context).activate_tag,
                          style: AppTextStyle.style14.copyWith(color:context.colorScheme.textSecondary)                      ),
                      onTap: () {
                        if (state.employee.status == EmployeeStatus.inactive) {
                          context.read<EmployeeDetailBloc>().add(
                              EmployeeStatusChangeEvent(
                                  status: EmployeeStatus.active,
                                  employeeId: widget.employeeId));
                        } else {
                          showAppAlertDialog(
                              context: context,
                              title: context.l10n.deactivate_tag,
                              actionButtonTitle: context.l10n.deactivate_tag,
                              description: context.l10n
                                  .deactivate_user_account_alert(
                                      state.employee.name),
                              onActionButtonPressed: () {
                                context.read<EmployeeDetailBloc>().add(
                                    EmployeeStatusChangeEvent(
                                        status: EmployeeStatus.inactive,
                                        employeeId: widget.employeeId));
                              });
                        }
                      },
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ],
        body: BlocConsumer<EmployeeDetailBloc, AdminEmployeeDetailState>(
          builder: (BuildContext context, AdminEmployeeDetailState state) {
            if (state is EmployeeDetailLoadingState) {
              return const AppCircularProgressIndicator();
            } else if (state is EmployeeDetailLoadedState) {
              return ListView(
                  padding: const EdgeInsets.symmetric(
                      vertical: primaryHorizontalSpacing),
                  physics: const ClampingScrollPhysics(),
                  children: [
                    ProfileCard(employee: state.employee),
                    ValidateWidget(
                      isValid: state.employee.role != Role.admin,
                      child: TimeOffCard(
                        employee: state.employee,
                        percentage: state.timeOffRatio,
                        usedLeaves: state.usedLeaves,
                      ),
                    ),
                    ProfileDetail(employee: state.employee),
                  ]);
            }
            return const SizedBox();
          },
          listener: (BuildContext context, AdminEmployeeDetailState state) {
            if (state is EmployeeDetailFailureState) {
              showSnackBar(context: context, error: state.error);
              context.pop();
            }
          },
        ));
  }
}
