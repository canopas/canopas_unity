import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/di/service_locator.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/ui/navigation/app_router.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/widget/leave_count_card.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/widget/leave_list.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/widget/year_selection.dart';
import '../../../../data/configs/colors.dart';
import 'bloc/leave_count/user_leave_count_bloc.dart';
import 'bloc/leave_count/user_leave_cout_event.dart';
import 'bloc/leaves/user_leave_bloc.dart';

class UserLeavePage extends StatelessWidget {
  const UserLeavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (_) =>
              getIt<UserLeaveCountBloc>()..add(FetchLeaveCountEvent())),
      BlocProvider(
          create: (_) => getIt<UserLeaveBloc>())
    ], child: const UserLeaveScreen());
  }
}

class UserLeaveScreen extends StatefulWidget {
  const UserLeaveScreen({Key? key}) : super(key: key);

  @override
  State<UserLeaveScreen> createState() => _UserLeaveScreenState();
}

class _UserLeaveScreenState extends State<UserLeaveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).leaves_tag),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16).copyWith(bottom: 86),
        children: [
          const LeaveCountCard(),
          const Divider(height: 32),
          YearSelection(
              dateOfJoining: getIt<UserStateNotifier>().employee.dateOfJoining),
          const Divider(height: 32),
          const LeaveList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.goNamed(Routes.applyLeave),
      ),
    );
  }
}
