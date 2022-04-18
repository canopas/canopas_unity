import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:projectunity/ViewModel/all_leaves_user_bloc.dart';
import 'package:projectunity/Widget/error_banner.dart';
import 'package:projectunity/Widget/leave_widget.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/Leave/leave.dart';
import 'package:projectunity/model/Leave/leave_detail.dart';
import 'package:projectunity/rest/api_response.dart';

class AllLeavesUserScreen extends StatefulWidget {
  const AllLeavesUserScreen({Key? key}) : super(key: key);

  @override
  _AllLeavesUserScreenState createState() => _AllLeavesUserScreenState();
}

class _AllLeavesUserScreenState extends State<AllLeavesUserScreen> {
  final _bloc = getIt<AllLeavesUserBloc>();

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
              return ListView.builder(
                  itemCount: allLeaves.length,
                  itemBuilder: (BuildContext context, int index) {
                    Leave leave = allLeaves[index];
                    return LeaveWidget(leave: leave);
                  });
            }, error: (String error) {
              SchedulerBinding.instance?.addPostFrameCallback((_) {
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
