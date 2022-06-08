import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/model/leave/leave_detail.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/viewmodel/team_leaves_bloc.dart';
import 'package:projectunity/widget/error_banner.dart';

import 'team/all_leaves.dart';
import 'team/upcoming_leaves.dart';

class TeamLeavesScreen extends StatefulWidget {
  const TeamLeavesScreen({Key? key}) : super(key: key);

  @override
  _TeamLeavesScreenState createState() => _TeamLeavesScreenState();
}

class _TeamLeavesScreenState extends State<TeamLeavesScreen> {
  final _bloc = getIt<TeamLeavesBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.getTeamLeaves();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: const Text(
              'Team Leaves',
            ),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'All',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Upcoming',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          body: StreamBuilder<ApiResponse<LeaveDetail>>(
            stream: _bloc.allTeamLeaves,
            initialData: const ApiResponse.loading(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return snapshot.data?.when(
                  idle: () => Container(),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  completed: (LeaveDetail leaveDetail) {
                    List<Leave>? allLeaves = leaveDetail.all;
                    List<Leave>? upcomingLeaves = leaveDetail.upcoming;
                    return TabBarView(children: [
                      TeamAllLeavesScreen(leaveList: allLeaves),
                      TeamUpcomingLeavesScreen(
                        leaveList: upcomingLeaves,
                      ),
                    ]);
                  },
                  error: (String error) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      showErrorBanner(error, context);
                    });
                    return Container();
                  });
            },
          ),
        ));
  }
}
