import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:projectunity/bloc/user_leaves_bloc.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/model/leave/leave_detail.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/widget/error_banner.dart';
import 'package:projectunity/widget/leave_widget.dart';

class UpComingLeavesUserScreen extends StatefulWidget {
  const UpComingLeavesUserScreen({Key? key}) : super(key: key);

  @override
  _UpComingLeavesUserScreenState createState() =>
      _UpComingLeavesUserScreenState();
}

class _UpComingLeavesUserScreenState extends State<UpComingLeavesUserScreen> {
  final _bloc = getIt<UserLeavesBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.getAllLeaves();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Upcoming leaves',
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<ApiResponse<LeaveDetail>>(
          stream: _bloc.allLeavesOfUser,
          initialData: const ApiResponse.loading(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return snapshot.data?.when(
                idle: () => Container(),
                loading: () => const Center(child: CircularProgressIndicator()),
                completed: (LeaveDetail leaveDetail) {
                  List<Leave> upcomingLeaves = leaveDetail.upcoming;
                  if (upcomingLeaves.isEmpty) {
                    return const Center(
                      child: Text('No any leave'),
                    );
                  }
                  return LeaveWidget(leaveList: upcomingLeaves);
                },
                error: (String error) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    showErrorBanner(error, context);
                  });
                  return Container();
                });
          },
        ),
      ),
    );
  }
}
