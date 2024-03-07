import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/core/extensions/leave_extension.dart';
import 'package:projectunity/data/core/extensions/string_extension.dart';
import 'package:projectunity/data/di/service_locator.dart';
import 'package:projectunity/style/app_page.dart';
import 'package:projectunity/style/other/app_button.dart';
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_bloc.dart';
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_event.dart';
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_state.dart';
import 'package:projectunity/ui/user/leaves/detail/widget/response_note.dart';
import 'package:projectunity/ui/user/leaves/detail/widget/user_leave_date_content.dart';
import 'package:projectunity/ui/widget/leave_details_widget/leave_details_header_content.dart';
import 'package:projectunity/ui/widget/widget_validation.dart';
import '../../../../data/provider/user_state.dart';
import '../../../widget/circular_progress_indicator.dart';
import '../../../widget/error_snack_bar.dart';
import '../../../widget/leave_details_widget/leave_details_per_day_duration_content.dart';
import '../../../widget/leave_details_widget/reason_content.dart';

class UserLeaveDetailPage extends StatelessWidget {
  final String leaveId;

  const UserLeaveDetailPage({super.key, required this.leaveId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserLeaveDetailBloc>(
      create: (_) => getIt<UserLeaveDetailBloc>()
        ..add(FetchLeaveDetailEvent(leaveId: leaveId)),
      child: UserLeaveDetailScreen(leaveId: leaveId),
    );
  }
}

class UserLeaveDetailScreen extends StatefulWidget {
  final String leaveId;

  const UserLeaveDetailScreen({super.key, required this.leaveId});

  @override
  State<UserLeaveDetailScreen> createState() => _UserLeaveDetailScreenState();
}

class _UserLeaveDetailScreenState extends State<UserLeaveDetailScreen> {
  final userStateNotifier = getIt<UserStateNotifier>();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return AppPage(
      backGroundColor: context.colorScheme.surface,
      title: AppLocalizations.of(context).details_tag,
      body: BlocConsumer<UserLeaveDetailBloc, UserLeaveDetailState>(
          listenWhen: (previous, current) =>
              current is UserLeaveDetailErrorState ||
              current is UserCancelLeaveSuccessState,
          listener: (context, state) {
            if (state is UserLeaveDetailErrorState) {
              showSnackBar(context: context, error: state.error);
            }
            if (state is UserCancelLeaveSuccessState) {
              showSnackBar(
                  context: context, msg: localization.cancel_leave_message);
              context.pop(widget.leaveId);
            }
          },
          builder: (context, state) {
            if (state is UserLeaveDetailLoadingState) {
              return const AppCircularProgressIndicator();
            } else if (state is UserLeaveDetailSuccessState) {
              final userIsAbleToSeeAllData = userStateNotifier.isAdmin ||
                  userStateNotifier.isHR ||
                  userStateNotifier.employeeId == state.leave.uid;
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: LeaveTypeAgoTitleWithStatus(
                        appliedOn: state.leave.appliedOn,
                        leaveType: state.leave.type,
                        status: state.leave.status),
                  ),
                  UserLeaveRequestDateContent(leave: state.leave),
                  PerDayDurationDateRange(
                      perDayDurationWithDate: state.leave.getDateAndDuration()),
                  ValidateWidget(
                    isValid: userIsAbleToSeeAllData,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8,
                      ),
                      child: ReasonField(
                        title: localization.reason_tag,
                        reason: state.leave.reason,
                      ),
                    ),
                  ),
                  ValidateWidget(
                      isValid: state.leave.response.isNotNullOrEmpty &&
                          userIsAbleToSeeAllData,
                      child: ResponseNote(
                          leaveResponse: state.leave.response ?? "")),
                ],
              );
            }
            //error screen
            return const SizedBox();
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          BlocBuilder<UserLeaveDetailBloc, UserLeaveDetailState>(
              builder: (context, state) {
        if (state is UserLeaveDetailSuccessState) {
          final userIsAbleToSeeAllData = userStateNotifier.isAdmin ||
              userStateNotifier.isHR ||
              userStateNotifier.employeeId == state.leave.uid;
          return ValidateWidget(
              isValid: state.showCancelButton && userIsAbleToSeeAllData,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: AppButton(
                  tag: context.l10n.cancel_button_tag,
                  onTap: () {
                    BlocProvider.of<UserLeaveDetailBloc>(context).add(
                        CancelLeaveApplicationEvent(
                            leaveId: state.leave.leaveId));
                  },
                ),
              ));
        }
        return const SizedBox();
      }),
    );
  }
}
