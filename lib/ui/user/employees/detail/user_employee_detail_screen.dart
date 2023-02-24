import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/ui/admin/employee/detail/widget/profile_card.dart';
import 'package:projectunity/ui/user/employees/detail/bloc/user_employee_detail_bloc.dart';
import 'package:projectunity/ui/user/employees/detail/bloc/user_employee_detail_event.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/error_snack_bar.dart';

import '../../../../configs/colors.dart';
import '../../../../model/employee/employee.dart';
import '../../../../model/leave/leave.dart';
import '../../../admin/employee/detail/widget/profile_detail.dart';
import '../../leaves/leaves_screen/widget/leave_card.dart';
import 'bloc/user_employee_detail_state.dart';

class UserEmployeeDetailPage extends StatelessWidget {
  final String employeeId;
  const UserEmployeeDetailPage({Key? key, required this.employeeId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserEmployeeDetailBloc>(
        create: (_) => getIt<UserEmployeeDetailBloc>()
          ..add(UserEmployeeDetailFetchEvent(employeeId: employeeId)),
        child: const UserEmployeeDetailScreen());
  }
}

class UserEmployeeDetailScreen extends StatefulWidget {
  const UserEmployeeDetailScreen({Key? key}) : super(key: key);

  @override
  State<UserEmployeeDetailScreen> createState() =>
      _UserEmployeeDetailScreenState();
}

class _UserEmployeeDetailScreenState extends State<UserEmployeeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)
            .admin_employee_detail_appbar_title_detail_tag),
      ),
      body: BlocConsumer<UserEmployeeDetailBloc, UserEmployeeDetailState>(
          listenWhen: (previous, current) =>
              previous is! UserEmployeeDetailErrorState &&
              current is UserEmployeeDetailErrorState,
          listener: (context, state) {
            if (state is UserEmployeeDetailErrorState) {
              showSnackBar(context: context, error: state.error);
            }
          },
          builder: (context, state) {
            if (state is UserEmployeeDetailInitialState) {
              return Container();
            }
            if (state is UserEmployeeDetailLoadingState) {
              return const AppCircularProgressIndicator();
            }
            if (state is UserEmployeeDetailSuccessState) {
              return ListView(
                children: [
                  ProfileCard(employee: state.employee),
                  TabContent(leaves: state.upcomingLeaves),
                  const Divider(
                    color: AppColors.lightGreyColor,
                    indent: 15,
                    endIndent: 15,
                  ),
                  EmployeeInfo(employee: state.employee),
                ],
              );
            }
            return Container();
          }),
    );
  }
}

class TabContent extends StatelessWidget {
  final List<Leave> leaves;
  const TabContent({Key? key, required this.leaves}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.greyColor),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: LeaveButton(
                  leaves: leaves,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.greyColor),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.chat,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text('Message')
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmployeeInfo extends StatelessWidget {
  final Employee employee;
  const EmployeeInfo({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EmployeeField(
          title: localization.employee_mobile_tag,
          subtitle: employee.phone,
        ),
        EmployeeField(
            title: localization.employee_email_tag, subtitle: employee.email),
        EmployeeField(
          title: localization.employee_level_tag,
          subtitle: employee.level,
        ),
      ],
    );
  }
}

class LeaveButton extends StatelessWidget {
  final List<Leave> leaves;
  const LeaveButton({Key? key, required this.leaves}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return ExpandableNotifier(
      child: ScrollOnExpand(
        scrollOnCollapse: false,
        scrollOnExpand: true,
        child: ExpandablePanel(
          theme: const ExpandableThemeData(
            iconPadding: EdgeInsets.all(0),
            headerAlignment: ExpandablePanelHeaderAlignment.center,
          ),
          header: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.calendar_month_sharp,
              ),
              Text(
                localization.user_leave_upcoming_leaves_tag,
              ),
            ],
          ),
          expanded: leaves.isEmpty
              ? Text(localization.employee_empty_upcoming_leaves_view_message)
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: leaves.length,
                  itemBuilder: (context, index) {
                    Leave leave = leaves[index];
                    return UserLeaveCard(
                      leave: leave,
                    );
                  }),
          builder: (context, collapsed, expanded) {
            return Expandable(
              collapsed: collapsed,
              expanded: expanded,
              theme: const ExpandableThemeData(crossFadePoint: 0),
            );
          },
          collapsed: Container(),
        ),
      ),
    );
  }
}
