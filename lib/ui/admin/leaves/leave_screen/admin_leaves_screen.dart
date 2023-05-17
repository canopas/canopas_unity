import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/di/service_locator.dart';
import 'package:projectunity/data/model/leave_application.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leaves_state.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/widget/admin_leaves_filter.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import 'package:projectunity/ui/widget/leave_application_card.dart';
import 'package:projectunity/ui/widget/leave_card.dart';
import '../../../../data/configs/colors.dart';
import '../../../../data/core/utils/bloc_status.dart';
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
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.leaves.length,
              itemBuilder: (context, index) {
                if (state.selectedEmployee == null) {
                  return LeaveApplicationCard(
                      onTap: () {},
                      leaveApplication: LeaveApplication(
                          employee: state.employees.firstWhere((element) =>
                              element.uid == state.leaves[index].uid),
                          leave: state.leaves[index]));
                }
                return LeaveCard(onTap: () {}, leave: state.leaves[index]);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            )
          ],
        );
      }),
      backgroundColor: AppColors.whiteColor,
    );
  }
}
