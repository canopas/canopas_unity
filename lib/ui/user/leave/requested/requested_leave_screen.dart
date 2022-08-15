import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/bloc/leaves/user/leaves/requested_leave_bloc.dart';
import 'package:projectunity/di/service_locator.dart';

import '../leaveScreen/leave_screen.dart';

class RequestedLeaveScreen extends StatefulWidget {
  const RequestedLeaveScreen({Key? key}) : super(key: key);

  @override
  State<RequestedLeaveScreen> createState() => _RequestedLeaveScreenState();
}

class _RequestedLeaveScreenState extends State<RequestedLeaveScreen> {
  final _userRequestedLeavesBloc = getIt<UserRequestedLeaveBloc>();

  @override
  void initState() {
    _userRequestedLeavesBloc.getRequestedLeaves();
    super.initState();
  }

  @override
  void dispose() {
//_userRequestedLeavesBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LeaveScreen(
        leaveStream: _userRequestedLeavesBloc.requestedLeaves,
        header: AppLocalizations.of(context).user_home_requested_leaves_tag);
  }
}
