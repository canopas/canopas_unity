import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/error_snack_bar.dart';

import '../../../../../di/service_locator.dart';
import '../../../../core/utils/const/role.dart';
import '../../../../navigation/app_router.dart';
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
                buildWhen: (previous, current) =>
                    previous is! EmployeeDetailLoadedState &&
                    current is EmployeeDetailLoadedState,
                builder: (context, state) {
                  if (state is EmployeeDetailLoadedState &&
                      context.read<EmployeeDetailBloc>().currentUserIsAdmin) {
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
                                      state.employee.id
                                });
                          },
                        ),
                        PopupMenuItem(
                          child: Text(
                            AppLocalizations.of(context).delete_button_tag,
                          ),
                          onTap: () {
                            context.read<EmployeeDetailBloc>().add(
                                DeleteEmployeeEvent(
                                    employeeId: widget.employeeId));
                            context.pop();
                          },
                        ),
                        PopupMenuItem(
                          child: Text(state.employee.roleType == kRoleTypeAdmin
                              ? AppLocalizations.of(context)
                                  .admin_employee_details_remove_admin_tag
                              : AppLocalizations.of(context)
                                  .admin_employee_details_make_admin_tag),
                          onTap: () {
                            context
                                .read<EmployeeDetailBloc>()
                                .add(EmployeeDetailsChangeRoleEvent());
                          },
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                }),
          ]),
      body: BlocConsumer<EmployeeDetailBloc, AdminEmployeeDetailState>(
        builder: (BuildContext context, AdminEmployeeDetailState state) {
          if (state is EmployeeDetailLoadingState) {
            return const AppCircularProgressIndicator();
          } else if (state is EmployeeDetailLoadedState) {
            return ListView(children: [
              ProfileCard(employee: state.employee),
              ProfileDetail(
                employee: state.employee,
                usedLeaves: state.usedLeaves,
                paidLeaves: state.paidLeaves,
                percentage: state.timeOffRatio,
              ),
            ]);
          }
          return const SizedBox();
        },
        listener: (BuildContext context, AdminEmployeeDetailState state) {
          if (state is EmployeeDetailFailureState) {
            showSnackBar(context: context, error: state.error);
          }
        },
      ),
    );
  }
}
