import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/model/leave_application.dart';
import '../../../../ui/user/requested_leaves/bloc/requested_leave_event.dart';
import '../../../../ui/user/requested_leaves/bloc/requested_leave_state.dart';
import '../../../configs/colors.dart';
import '../../../core/utils/const/space_constant.dart';
import '../../../di/service_locator.dart';
import '../../../router/app_router.dart';
import '../../../widget/circular_progress_indicator.dart';
import '../../../widget/empty_screen.dart';
import '../../../widget/error_snack_bar.dart';
import '../../../widget/leave_card.dart';
import 'bloc/requested_leaves_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class RequestedLeavesPage extends StatelessWidget {
  const RequestedLeavesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RequestedLeavesViewBloc>()..add(RequestedLeavesViewInitialLoadEvent()),
      child: const RequestedLeavesView(),
    );
  }
}

class RequestedLeavesView extends StatefulWidget {
  const RequestedLeavesView({Key? key}) : super(key: key);

  @override
  State<RequestedLeavesView> createState() => _RequestedLeavesViewState();
}

class _RequestedLeavesViewState extends State<RequestedLeavesView> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
            localization.user_home_requested_leaves_tag),
      ),
      body: BlocConsumer<RequestedLeavesViewBloc, RequestedLeavesViewStates>(
        listenWhen: (previous, current) => current is RequestedLeaveViewFailureState,
        listener: (context, state) {
          if(state is RequestedLeaveViewFailureState){
               showSnackBar(context: context, error: state.error);
          }
        },
        builder: (context, state) {
          if (state is RequestedLeaveViewLoadingState) {
            return const AppCircularProgressIndicator();
          } else if (state is RequestedLeaveViewSuccessState) {
            if (state.leaveApplications.isEmpty) {
              return EmptyScreen(
                message: localization.employee_empty_requested_leaves_view_message,
                title: localization.employee_empty_requested_leaves_view_title,
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

