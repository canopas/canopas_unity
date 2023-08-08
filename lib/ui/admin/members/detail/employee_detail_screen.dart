import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/configs/space_constant.dart';
import 'package:projectunity/ui/admin/members/detail/widget/time_off_card.dart';
import 'package:projectunity/ui/widget/widget_validation.dart';
import '../../../../data/di/service_locator.dart';
import '../../../../data/model/employee/employee.dart';
import '../../../navigation/app_router.dart';
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
        create: (_) => getIt<EmployeeDetailBloc>()
          ..add(EmployeeDetailInitialLoadEvent(employeeId: id)),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).details_tag,
          ),
          actions: [
            BlocBuilder<EmployeeDetailBloc, AdminEmployeeDetailState>(
              builder: (context, state){
                if(state is EmployeeDetailLoadedState){
                return PopupMenuButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text(AppLocalizations.of(context).edit_tag),
                          onTap: () {
                            context.goNamed(Routes.adminEditEmployee,
                                extra: state.employee,
                                params: {
                                  RoutesParamsConst.employeeId:
                                      state.employee.uid
                                });
                          },
                        ),
                        PopupMenuItem(
                          child: Text(
                            state.employee.status == EmployeeStatus.active?
                            AppLocalizations.of(context).deactivate_tag
                                :AppLocalizations.of(context).activate_tag,
                          ),
                          onTap: () {
                            if (state.employee.status ==
                                EmployeeStatus.inactive) {
                              context.read<EmployeeDetailBloc>().add(
                                  EmployeeStatusChangeEvent(
                                      status: EmployeeStatus.active,
                                      employeeId: widget.employeeId));
                            } else {
                              showAlertDialog(
                                context: context,
                                title:
                                    AppLocalizations.of(context).deactivate_tag,
                                description: AppLocalizations.of(context)
                                    .deactivate_user_account_alert(
                                        state.employee.name),
                                onActionButtonPressed: () {
                                  context.read<EmployeeDetailBloc>().add(
                                      EmployeeStatusChangeEvent(
                                          status: EmployeeStatus.inactive,
                                          employeeId: widget.employeeId));
                                  context.pop();
                                },
                                actionButtonTitle:
                                    AppLocalizations.of(context).deactivate_tag,
                              );
                            }
                          },
                        ),
                      ],
                    );
                }
                return const SizedBox();
              },
            ),
          ]),
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
      ),
    );
  }
}
