import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_page.dart';
import 'package:projectunity/ui/admin/members/details_leaves/widget/leave_list.dart';
import '../../../../data/di/service_locator.dart';
import '../../../../data/l10n/app_localization.dart';
import 'bloc/admin_employee_details_leave_bloc.dart';
import 'bloc/admin_employee_details_leave_events.dart';

class AdminEmployeeDetailsLeavesPage extends StatelessWidget {
  final String employeeName;
  final String employeeId;

  const AdminEmployeeDetailsLeavesPage(
      {super.key, required this.employeeName, required this.employeeId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminEmployeeDetailsLeavesBLoc>()
        ..add(LoadInitialLeaves(employeeId: employeeId)),
      child: AdminEmployeeDetailsLeavesScreen(employeeName: employeeName),
    );
  }
}

class AdminEmployeeDetailsLeavesScreen extends StatefulWidget {
  final String employeeName;

  const AdminEmployeeDetailsLeavesScreen(
      {super.key, required this.employeeName});

  @override
  State<AdminEmployeeDetailsLeavesScreen> createState() =>
      _AdminEmployeeDetailsLeavesScreenState();
}

class _AdminEmployeeDetailsLeavesScreenState
    extends State<AdminEmployeeDetailsLeavesScreen> {
  @override
  Widget build(BuildContext context) {
    return AppPage(
      backGroundColor: context.colorScheme.surface,
      title: AppLocalizations.of(context)
          .employee_details_leaves_title(widget.employeeName.split(" ").first),
      body: EmployeeLeaveList(employeeName: widget.employeeName),
    );
  }
}
