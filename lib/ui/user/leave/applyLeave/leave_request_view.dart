import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/bottom_button.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/date_range_selection_leave_request.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/date_selection_buttons.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/leave_request_reason_card.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/leave_type_card.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/total_leave_card.dart';
import 'package:projectunity/widget/error_snackbar.dart';
import '../../../../core/utils/const/space_constant.dart';
import 'bloc/leave_request_form_bloc/leave_request_view_events.dart';
import 'bloc/leave_request_form_bloc/leave_request_view_bloc.dart';
import 'bloc/leave_request_form_bloc/leave_request_view_states.dart';

class RequestLeavePage extends StatelessWidget {
  const RequestLeavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LeaveRequestBloc>()..add(LeaveRequestFormInitialLoadEvent()),
      child: const RequestLeaveView(),
    );
  }
}

class RequestLeaveView extends StatefulWidget {
  const RequestLeaveView({Key? key}) : super(key: key);

  @override
  State<RequestLeaveView> createState() => _RequestLeaveViewState();
}

class _RequestLeaveViewState extends State<RequestLeaveView> {
  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.leave_request_tag,),
      ),
      body: BlocListener<LeaveRequestBloc, LeaveRequestViewState>(
        listenWhen: (previous, current) => current.isFailure || current.leaveRequestStatus == LeaveRequestStatus.success,
        listener: (context, state) {
          if (state.isFailure) {
            showSnackBar(context: context, error: state.error);
          } else if (state.leaveRequestStatus == LeaveRequestStatus.success) {
            showSnackBar(context: context, msg: localization.user_apply_leave_success_message);
          }
        },
        child: ListView(
          padding: const EdgeInsets.only(top: primaryHalfSpacing, bottom: 80),
          children: const [
            LeaveTypeCard(),
            LeaveRequestDateSelection(),
            LeaveRequestDateRange(),
            TotalDaysMsgBox(),
            LeaveRequestReasonCard(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const ApplyButton(),
    );
  }
}
