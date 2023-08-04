import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/di/service_locator.dart';
import 'package:projectunity/ui/navigation/app_router.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/widget/leave_count_card.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/widget/leave_list.dart';
import '../../../../data/configs/colors.dart';
import 'bloc/leave_count/user_leave_count_bloc.dart';
import 'bloc/leave_count/user_leave_cout_event.dart';
import 'bloc/leaves/user_leave_bloc.dart';
import 'bloc/leaves/user_leave_event.dart';

class UserLeavePage extends StatelessWidget {
  const UserLeavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (_) =>
              getIt<UserLeaveCountBloc>()..add(FetchLeaveCountEvent())),
      BlocProvider(
          create: (_) => getIt<UserLeaveBloc>()..add(LoadInitialUserLeaves()))
    ], child: const UserLeaveScreen());
  }
}

class UserLeaveScreen extends StatefulWidget {
  const UserLeaveScreen({Key? key}) : super(key: key);

  @override
  State<UserLeaveScreen> createState() => _UserLeaveScreenState();
}

class _UserLeaveScreenState extends State<UserLeaveScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent - 100) {
      context.read<UserLeaveBloc>().add(FetchMoreUserLeaves());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).leaves_tag),
      ),
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.only(bottom: 76),
        children: const [
          LeaveCountCard(),
          LeaveList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.goNamed(Routes.applyLeave),
      ),
    );
  }
}
