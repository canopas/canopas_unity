import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/di/service_locator.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leaves_state.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/widget/admin_leaves_filter.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/widget/month_leave_list.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import 'package:projectunity/ui/widget/empty_screen.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';
import 'package:projectunity/ui/widget/pagination_widget.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../../../../data/configs/colors.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/model/leave_application.dart';
import '../../../navigation/app_router.dart';
import 'bloc /admin_leave_event.dart';
import 'bloc /admin_leaves_bloc.dart';

class AdminLeavesPage extends StatelessWidget {
  const AdminLeavesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AdminLeavesBloc>()..add(InitialAdminLeavesEvent()),
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
        _scrollController.position.maxScrollExtent - 200) {
      context.read<AdminLeavesBloc>().add(FetchMoreLeavesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AdminLeavesBloc>();

    void navigateToLeaveDetails(LeaveApplication la) async {
      final String? leaveId =
          await context.pushNamed(Routes.adminLeaveDetails, extra: la);
      if (leaveId != null) {
        bloc.add(UpdateLeaveApplication(leaveId: leaveId));
      }
    }

    void navigateToApplyLeave() async {
      final String? leaveId = await context.pushNamed(Routes.hrApplyLeave);
      if (leaveId != null) {
        bloc.add(UpdateLeaveApplication(leaveId: leaveId));
      }
    }

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(AppLocalizations.of(context).leaves_tag),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AdminLeavesFilter(),
        ),
      ),
      body: BlocConsumer<AdminLeavesBloc, AdminLeavesState>(
          listenWhen: (previous, current) => previous.error != current.error,
          listener: (context, state) {
            if (state.error != null) {
              showSnackBar(context: context, error: state.error);
            }
          },
          buildWhen: (previous, current) =>
              previous.fetchMoreData != current.fetchMoreData ||
              previous.selectedMember != current.selectedMember ||
              previous.leaveApplicationMap != current.leaveApplicationMap ||
              previous.leavesFetchStatus != current.leavesFetchStatus,
          builder: (context, state) {
            if (state.leavesFetchStatus == Status.loading) {
              return const AppCircularProgressIndicator();
            }
            return state.leaveApplicationMap.isNotEmpty
                ? ListView(
                    controller: _scrollController,
                    children: state.leaveApplicationMap.entries
                        .map((MapEntry<DateTime, List<LeaveApplication>>
                                monthWiseLeaveApplications) =>
                            StickyHeader(
                                header: LeaveListHeader(
                                  title: AppLocalizations.of(context)
                                      .date_format_yMMMM(
                                          monthWiseLeaveApplications.key),
                                  count:
                                      monthWiseLeaveApplications.value.length,
                                ),
                                content: MonthLeaveList(
                                  onCardTap: navigateToLeaveDetails,
                                  leaveApplications:
                                      monthWiseLeaveApplications.value,
                                  showLeaveApplicationCard:
                                      state.selectedMember == null,
                                  isPaginationLoading:
                                      monthWiseLeaveApplications.key ==
                                              state.leaveApplicationMap.keys
                                                  .last &&
                                          state.fetchMoreData == Status.loading,
                                )))
                        .toList(),
                  )
                : EmptyScreen(
                    title: AppLocalizations.of(context).no_leaves_tag,
                    message: AppLocalizations.of(context)
                        .admin_leave_empty_screen_message);
          }),
      floatingActionButton: getIt<UserStateNotifier>().isHR
          ? FloatingActionButton(
              onPressed: navigateToApplyLeave,
              child: const Icon(Icons.add),
            )
          : null,
      backgroundColor: AppColors.whiteColor,
    );
  }
}


