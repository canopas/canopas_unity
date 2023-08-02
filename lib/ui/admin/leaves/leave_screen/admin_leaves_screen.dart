import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/di/service_locator.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leaves_state.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/widget/admin_leaves_filter.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import 'package:projectunity/ui/widget/empty_screen.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';
import 'package:projectunity/ui/widget/leave_application_card.dart';
import 'package:projectunity/ui/widget/leave_card.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../../../../data/configs/colors.dart';
import '../../../../data/configs/text_style.dart';
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
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      context.read<AdminLeavesBloc>().add(FetchMoreLeavesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              previous.showPaginationLoading != current.showPaginationLoading ||
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
                                header: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(
                                        color: AppColors.whiteColor),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                                  horizontal: 16)
                                              .copyWith(top: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  AppLocalizations.of(context)
                                                      .date_format_yMMMM(
                                                          monthWiseLeaveApplications
                                                              .key),
                                                  style:
                                                      AppFontStyle.headerDark),
                                              Text(
                                                monthWiseLeaveApplications
                                                    .value.length
                                                    .toString(),
                                                style: AppFontStyle.headerDark,
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Divider(height: 1)
                                      ],
                                    )),
                                content: ListView.separated(
                                  padding: const EdgeInsets.all(16),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: monthWiseLeaveApplications.key ==
                                              state.leaveApplicationMap.keys
                                                  .last &&
                                          state.showPaginationLoading
                                      ? monthWiseLeaveApplications
                                              .value.length +
                                          1
                                      : monthWiseLeaveApplications.value.length,
                                  itemBuilder: (context, index) {
                                    if (index ==
                                            monthWiseLeaveApplications
                                                .value.length &&
                                        monthWiseLeaveApplications.key ==
                                            state.leaveApplicationMap.keys
                                                .last) {
                                      return const Padding(
                                        padding: EdgeInsets.all(50),
                                        child: AppCircularProgressIndicator(),
                                      );
                                    }
                                    if (state.selectedMember == null) {
                                      return LeaveApplicationCard(
                                          onTap: () => context.goNamed(
                                              Routes.adminLeaveDetails,
                                              extra: monthWiseLeaveApplications
                                                  .value[index]),
                                          leaveApplication:
                                              monthWiseLeaveApplications
                                                  .value[index]);
                                    }
                                    return LeaveCard(
                                        onTap: () => context.goNamed(
                                            Routes.adminLeaveDetails,
                                            extra: monthWiseLeaveApplications
                                                .value[index]),
                                        leave: monthWiseLeaveApplications
                                            .value[index].leave);
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 16),
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
              child: const Icon(Icons.add),
              onPressed: () => context.goNamed(Routes.hrApplyLeave),
            )
          : null,
      backgroundColor: AppColors.whiteColor,
    );
  }
}
