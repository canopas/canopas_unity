import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/model/leave_application.dart';
import '../../../../di/service_locator.dart';
import '../../../../ui/user/upcoming_leaves/bloc/upcoming_leaves_bloc.dart';
import '../../../../ui/user/upcoming_leaves/bloc/upcoming_leaves_event.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../configs/colors.dart';
import '../../../core/utils/const/space_constant.dart';
import '../../../router/app_router.dart';
import '../../../widget/circular_progress_indicator.dart';
import '../../../widget/empty_screen.dart';
import '../../../widget/error_snack_bar.dart';
import '../../../widget/leave_card.dart';
import 'bloc/upcoming_leaves_state.dart';

class UpcomingLeavesPage extends StatelessWidget {
  const UpcomingLeavesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UpcomingLeavesViewBloc>()..add(UpcomingLeavesViewInitialLoadEvent()),
      child: const UpcomingLeavesView(),
    );
  }
}

class UpcomingLeavesView extends StatefulWidget {
  const UpcomingLeavesView({Key? key}) : super(key: key);

  @override
  State<UpcomingLeavesView> createState() => _UpcomingLeavesViewState();
}

class _UpcomingLeavesViewState extends State<UpcomingLeavesView> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
            localization.user_home_upcoming_leaves_tag),
      ),
      body: BlocConsumer<UpcomingLeavesViewBloc, UpcomingLeavesViewStates>(
        listenWhen:(previous, current) => current is UpcomingLeaveViewFailureState,
        listener: (context, state) {
          if(state is UpcomingLeaveViewFailureState) {
            showSnackBar(context: context, error: state.error);
          }
        },
        builder: (context, state) {
          if (state is UpcomingLeaveViewLoadingState) {
            return const AppCircularProgressIndicator();
          } else if (state is UpcomingLeaveViewSuccessState) {
            if (state.leaveApplications.isEmpty) {
              return EmptyScreen(
                message: localization.employee_empty_upcoming_leaves_view_message,
                title: localization.employee_empty_upcoming_leaves_view_title,
                actionButtonTitle: localization.apply_for_leave_button_text,
                onActionButtonTap: () => context.goNamed(Routes.applyLeave),
                showActionButton: true,
              );
            } else {
              return ListView.separated(
                itemCount: state.leaveApplications.length,
                padding: const EdgeInsets.all(primaryHorizontalSpacing),
                itemBuilder: (BuildContext context, int index) {
                  LeaveApplication leaveApplication= state.leaveApplications[index];
                  return LeaveCard(
                      leaveApplication: leaveApplication);
                },
                separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: primaryHorizontalSpacing),
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}

