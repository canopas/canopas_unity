import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/di/service_locator.dart';
import 'package:projectunity/data/model/leave_application.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leaves_state.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/widget/admin_leaves_filter.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import 'package:projectunity/ui/widget/empty_screen.dart';
import 'package:projectunity/ui/widget/leave_application_card.dart';
import 'package:projectunity/ui/widget/leave_card.dart';
import '../../../../data/configs/colors.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../navigation/app_router.dart';
import 'bloc /admin_leave_event.dart';
import 'bloc /admin_leaves_bloc.dart';

class AdminLeavesPage extends StatelessWidget {
  const AdminLeavesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<AdminLeavesBloc>()..add(AdminLeavesInitialLoadEvent()),
      child: const AdminLeavesScreen(),
    );
  }
}

class AdminLeavesScreen extends StatefulWidget {
  const AdminLeavesScreen({Key? key}) : super(key: key);

  @override
  State<AdminLeavesScreen> createState() => _AdminLeavesScreenState();
}

class _AdminLeavesScreenState extends State<AdminLeavesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).leaves_tag),
      ),
      body: BlocBuilder<AdminLeavesBloc, AdminLeavesState>(
          builder: (context, state) {
        if (state.status == Status.loading) {
          return const AppCircularProgressIndicator();
        }
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const AdminLeavesFilter(),
            const Divider(height: 32),
            state.leaves.isNotEmpty
                ? ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.leaves.length,
                    itemBuilder: (context, index) {
                      final leaveApplication = LeaveApplication(
                          employee: state.employees.firstWhere((element) =>
                              element.uid == state.leaves[index].uid),
                          leave: state.leaves[index]);
                      if (state.selectedEmployee == null) {
                        return LeaveApplicationCard(
                            onTap: () => context.goNamed(
                                Routes.adminLeaveDetails,
                                extra: leaveApplication),
                            leaveApplication: leaveApplication);
                      }
                      return LeaveCard(
                          onTap: () => context.goNamed(Routes.adminLeaveDetails,
                              extra: leaveApplication),
                          leave: state.leaves[index]);
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height - 350,
                    child: EmptyScreen(
                        message: AppLocalizations.of(context).empty_leaves_message,
                        title: AppLocalizations.of(context).no_leaves_tag)),
          ],
        );
      }),
      floatingActionButton: getIt<UserManager>().isHR
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => context.goNamed(Routes.hrApplyLeave),
            )
          : null,
      backgroundColor: AppColors.whiteColor,
    );
  }
}
