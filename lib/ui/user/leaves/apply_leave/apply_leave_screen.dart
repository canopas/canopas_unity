import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/di/service_locator.dart';
import 'package:projectunity/ui/user/leaves/apply_leave/widget/bottom_button.dart';
import 'package:projectunity/ui/user/leaves/apply_leave/widget/date_range_selection_leave_request.dart';
import 'package:projectunity/ui/user/leaves/apply_leave/widget/date_selection_buttons.dart';
import 'package:projectunity/ui/user/leaves/apply_leave/widget/leave_request_reason_card.dart';
import 'package:projectunity/ui/user/leaves/apply_leave/widget/leave_type_card.dart';
import 'package:projectunity/ui/user/leaves/apply_leave/widget/total_leave_card.dart';
import '../../../../data/configs/space_constant.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../widget/error_snack_bar.dart';
import 'bloc/apply_leave_bloc.dart';
import 'bloc/apply_leave_state.dart';

class ApplyLeavePage extends StatelessWidget {
  const ApplyLeavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ApplyLeaveBloc>(),
      child: const ApplyLeaveScreen(),
    );
  }
}

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({Key? key}) : super(key: key);

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.user_leaves_apply_appbar_tag),
      ),
      body: BlocListener<ApplyLeaveBloc, ApplyLeaveState>(
        listenWhen: (previous, current) =>
            current.isFailure || current.leaveRequestStatus == Status.success,
        listener: (context, state) {
          if (state.isFailure) {
            showSnackBar(context: context, error: state.error);
          } else if (state.leaveRequestStatus == Status.success) {
            showSnackBar(
                context: context,
                msg: localization.user_leaves_apply_leave_success_message);
            context.pop(state.leaveId);
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
