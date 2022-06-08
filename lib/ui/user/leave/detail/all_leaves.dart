import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/model/leave/leave_detail.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/viewmodel/user_leaves_bloc.dart';
import 'package:projectunity/widget/error_banner.dart';
import 'package:projectunity/widget/leave_widget.dart';

class AllLeavesUserScreen extends StatefulWidget {
  const AllLeavesUserScreen({Key? key}) : super(key: key);

  @override
  _AllLeavesUserScreenState createState() => _AllLeavesUserScreenState();
}

class _AllLeavesUserScreenState extends State<AllLeavesUserScreen> {
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
            'All leaves',
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<ApiResponse<LeaveDetail>>(
          stream: _bloc.allLeavesOfUser,
          initialData: const ApiResponse.loading(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return snapshot.data?.when(idle: () {
              return Container();
            }, loading: () {
              return const Center(child: CircularProgressIndicator());
            }, completed: (LeaveDetail leaveDetail) {
              List<Leave>? allLeaves = leaveDetail.all;
              if (allLeaves.isEmpty) {
                return const Center(
                  child: Text('No any leave'),
                );
              }
              return LeaveWidget(leaveList: allLeaves);
            }, error: (String error) {
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
