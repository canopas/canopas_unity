import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../di/service_locator.dart';
import 'widget/leave_list.dart';
import '../../../../configs/colors.dart';
import '../../../../configs/text_style.dart';
import '../../../../configs/theme.dart';
import 'bloc/admin_employee_details_leave_bloc.dart';
import 'bloc/admin_employee_details_leave_events.dart';
import 'bloc/admin_employee_details_leave_state.dart';

class AdminEmployeeDetailsLeavesPage extends StatelessWidget {
  final String employeeName;
  final String employeeId;

  const AdminEmployeeDetailsLeavesPage({Key? key,   required this.employeeName, required this.employeeId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminEmployeeDetailsLeavesBLoc>()
        ..add(AdminEmployeeDetailsLeavesInitEvent(employeeId: employeeId)),
      child: AdminEmployeeDetailsLeavesScreen(employeeName: employeeName),
    );
  }
}

class AdminEmployeeDetailsLeavesScreen extends StatefulWidget {
  final String employeeName;

  const AdminEmployeeDetailsLeavesScreen({Key? key, required this.employeeName})
      : super(key: key);

  @override
  State<AdminEmployeeDetailsLeavesScreen> createState() =>
      _AdminEmployeeDetailsLeavesScreenState();
}

class _AdminEmployeeDetailsLeavesScreenState
    extends State<AdminEmployeeDetailsLeavesScreen>
    with SingleTickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).employee_details_leaves_title(
            widget.employeeName.split(" ").first)),
        bottom: TabBar(
          splashBorderRadius: AppTheme.commonBorderRadius,
          indicatorWeight: 2,
          indicatorColor: AppColors.primaryBlue,
          indicatorSize: TabBarIndicatorSize.label,
          controller: tabController,
          tabs: [
            Tab(
                child: Text(
              AppLocalizations.of(context).recent_tag,
              style: AppFontStyle.bodyMedium,
            )),
            Tab(
                child: Text(
              AppLocalizations.of(context).upcoming_tag,
              style: AppFontStyle.bodyMedium,
            )),
            Tab(
                child: Text(
              AppLocalizations.of(context).past_tag,
              style: AppFontStyle.bodyMedium,
            )),
          ],
        ),
      ),
      body: TabBarView(
        physics: const BouncingScrollPhysics(),
        controller: tabController,
        children: <Widget>[
          BlocBuilder<AdminEmployeeDetailsLeavesBLoc,
              AdminEmployeeDetailsLeavesState>(
            builder: (context, state) => LeaveList(
                employeeName: widget.employeeName,
                emptyStringTitle:
                    AppLocalizations.of(context).empty_recent_leaves_title,
                emptyStringMessage: AppLocalizations.of(context)
                    .empty_recent_leaves_message(widget.employeeName),
                isLoading: state.loading,
                leaves: state.recentLeaves),
          ),
          BlocBuilder<AdminEmployeeDetailsLeavesBLoc,
              AdminEmployeeDetailsLeavesState>(
            builder: (context, state) => LeaveList(
                employeeName: widget.employeeName,
                emptyStringTitle:
                    AppLocalizations.of(context).empty_upcoming_leaves_title,
                emptyStringMessage: AppLocalizations.of(context)
                    .empty_upcoming_leaves_message(widget.employeeName),
                isLoading: state.loading,
                leaves: state.upcomingLeaves,),
          ),
          BlocBuilder<AdminEmployeeDetailsLeavesBLoc,
              AdminEmployeeDetailsLeavesState>(
            builder: (context, state) => LeaveList(
                employeeName: widget.employeeName,
                emptyStringTitle:
                    AppLocalizations.of(context).empty_past_leaves_title,
                emptyStringMessage: AppLocalizations.of(context)
                    .empty_past_leaves_message(widget.employeeName),
                isLoading: state.loading,
                leaves: state.pastLeaves),
          ),
        ],
      ),
    );
  }
}
