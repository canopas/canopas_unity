import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectunity/bloc/leaves/user/leaves/upcoming_leave_bloc.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../leaveScreen/leave_screen.dart';

class UpComingLeaveScreen extends StatefulWidget {
  const UpComingLeaveScreen({Key? key}) : super(key: key);

  @override
  State<UpComingLeaveScreen> createState() => _UpComingLeaveScreenState();
}

class _UpComingLeaveScreenState extends State<UpComingLeaveScreen> {
  final _upcomingLeaveBloc = getIt<UpcomingLeaveBloc>();

  @override
  void initState() {
    _upcomingLeaveBloc.getUpcomingLeaves();
    super.initState();
  }

  @override
  void dispose() {
    _upcomingLeaveBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LeaveScreen(
        leaveStream: _upcomingLeaveBloc.upcomingLeaves,
        header: AppLocalizations.of(context).user_home_upcoming_leaves_tag);
  }
}
