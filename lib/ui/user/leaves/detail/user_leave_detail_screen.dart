import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/core/extensions/leave_extension.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_bloc.dart';
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_event.dart';
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_state.dart';
import 'package:projectunity/ui/user/leaves/detail/widget/cancel_button.dart';
import 'package:projectunity/ui/user/leaves/detail/widget/leave_type_content.dart';
import 'package:projectunity/ui/user/leaves/detail/widget/response_note.dart';
import 'package:projectunity/ui/user/leaves/detail/widget/user_leave_date_content.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';

import '../../../../configs/colors.dart';
import '../../../../model/leave/leave.dart';
import '../../../../widget/error_snack_bar.dart';
import '../../../../widget/leave_details_widget/leave_details_per_day_duration_content.dart';
import '../../../../widget/leave_details_widget/reason_content.dart';

class UserLeaveDetailPage extends StatelessWidget {
  final String leaveId;

  const UserLeaveDetailPage({Key? key, required this.leaveId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserLeaveDetailBloc>(
      create: (_) => getIt<UserLeaveDetailBloc>()
        ..add(FetchLeaveDetailEvent(leaveId: leaveId)),
      child: const UserLeaveDetailScreen(),
    );
  }
}

class UserLeaveDetailScreen extends StatefulWidget {
  const UserLeaveDetailScreen({Key? key}) : super(key: key);

  @override
  State<UserLeaveDetailScreen> createState() => _UserLeaveDetailScreenState();
}

class _UserLeaveDetailScreenState extends State<UserLeaveDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).details_tag),
      ),
      body: BlocListener<UserLeaveDetailBloc, UserLeaveDetailState>(
        listenWhen: (previous, current) =>
            current is UserLeaveDetailErrorState ||
            current is UserCancelLeaveSuccessState,
        listener: (context, state) {
          if (state is UserLeaveDetailErrorState) {
            showSnackBar(context: context, error: state.error);
          }
          if (state is UserCancelLeaveSuccessState) {
            showSnackBar(
                context: context,
                msg: localization.user_leave_detail_cancel_leave_message);
            context.pop();
          }
        },
        child: BlocBuilder<UserLeaveDetailBloc, UserLeaveDetailState>(
            buildWhen: (previous, current) =>
                current is UserLeaveDetailLoadingState ||
                current is UserLeaveDetailSuccessState,
            builder: (context, state) {
              if (state is UserLeaveDetailLoadingState) {
                return const AppCircularProgressIndicator();
              } else if (state is UserLeaveDetailSuccessState) {
                Leave leave = state.leave;
                bool showCancelButton = state.showCancelButton;
                return ListView(
                  children: [
                    LeaveTypeContent(
                      leaveType: leave.leaveType,
                      appliedTime: leave.appliedOn,
                      leaveStatus: leave.leaveStatus,
                    ),
                    UserLeaveRequestDateContent(leave: leave),
                    PerDayDurationDateRange(
                        perDayDurationWithDate: leave.getDateAndDuration()),
                    ReasonField(
                      title: localization.reason_tag,
                      reason: leave.reason,
                    ),
                    if (leave.rejectionReason != null)
                      ResponseNote(leaveResponse: leave.rejectionReason!),
                    if (showCancelButton) CancelButton(leaveId: leave.leaveId)
                  ],
                );
              }
              return Container();
            }),
      ),
    );
  }
}
